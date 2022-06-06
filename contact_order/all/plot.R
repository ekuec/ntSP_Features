mycol=c("#7FBF26","#C9CACA","gray60","gray40")
mynam=c("ntSP","ntCP","ctrl","PME")

my.lng=read.table("/home/ekuec/Projects/reference/contact_order/yst/yst_contact_order.tsv",head=F)
hit1=read.table("hit1.txt",head=F)
hit2=read.table("hit2.txt",head=F)
hit3=read.table("hit3.txt",head=F)
hit4=read.table("hit4.txt",head=F)

l1<-my.lng[which(my.lng$V1 %in% hit1$V1),]
l2<-my.lng[which(my.lng$V1 %in% hit2$V1),]
l3<-my.lng[which(my.lng$V1 %in% hit3$V1),]
l4<-my.lng[which(my.lng$V1 %in% hit4$V1),]

pdf("icontact_order_aplhafold.pdf",width=8,height=8)
par(oma=c(1,1,1,1),mar=c(2,3,1,1),mgp=c(2,1,0), mfrow=c(2,2))
boxplot(l1$V2,l2$V2,l3$V2,l4$V2,col=mycol,names=mynam,ylab="Contact Order", outline=F)
dev.off()

message("==Longest==")
wilcox.test(l1$V2,l2$V2)$p.value
wilcox.test(l1$V2,l3$V2)$p.value
wilcox.test(l1$V2,l4$V2)$p.value
wilcox.test(l2$V2,l2$V2)$p.value
wilcox.test(l2$V2,l3$V2)$p.value
wilcox.test(l2$V2,l4$V2)$p.value
message("==Ns==")
length(l1$V1)
length(l2$V1)
length(l3$V1)
length(l4$V1)

save.image(file='co_af.Rdata')
