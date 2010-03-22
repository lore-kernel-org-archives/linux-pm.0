From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: [PATCH v2] pcmcia: db1xxx-ss: suspend/resume fix
Date: Mon, 22 Mar 2010 21:58:14 +0100
Message-ID: <20100322205814.GB15250@isilmar.linta.de>
References: <1269287003-15523-1-git-send-email-manuel.lauss@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1269287003-15523-1-git-send-email-manuel.lauss@gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Manuel Lauss <manuel.lauss@googlemail.com>, "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Manuel Lauss <manuel.lauss@gmail.com>, linux-pm@lists.linux-foundation.org, linux-pcmcia@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Hm, what about using two commits currently in my tree for 2.6.36 instead,
which should fix all socket drivers?

    power: support _noirq actions on device types and classes
    pcmcia: use dev_pm_ops for class pcmcia_socket_class

Manuel: Could you try whether they also solve these issues? If so, I'd
propose pushing both patches already for 2.6.36. Rafael: do you concur?

Best,
	Dominik

On Mon, Mar 22, 2010 at 08:43:23PM +0100, Manuel Lauss wrote:
> This patch adds more pm method callbacks to the db1xxx-ss socket
> driver, which fixes spurious interrupts and dead cards upon resume
> from STR.
> 
> Tested on DB1200 with CF card (tons of spurious interrupts resulting
> in card interrupt being disabled) and a 3c509 card (this one was
> just dead after resume).
> 
> Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
> ---
> v2: remove uneeded .suspend callback (which was identical to
>     suspend_noirq).

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index d477f4d..941fcb8 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -439,8 +439,23 @@ static int device_resume_noirq(struct device *dev, pm_message_t state)
 	if (dev->bus && dev->bus->pm) {
 		pm_dev_dbg(dev, state, "EARLY ");
 		error = pm_noirq_op(dev, dev->bus->pm, state);
+		if (error)
+			goto End;
 	}
 
+	if (dev->type && dev->type->pm) {
+		pm_dev_dbg(dev, state, "EARLY type ");
+		error = pm_noirq_op(dev, dev->type->pm, state);
+		if (error)
+			goto End;
+	}
+
+	if (dev->class && dev->class->pm) {
+		pm_dev_dbg(dev, state, "EARLY class ");
+		error = pm_noirq_op(dev, dev->class->pm, state);
+	}
+
+End:
 	TRACE_RESUME(error);
 	return error;
 }
@@ -735,10 +750,26 @@ static int device_suspend_noirq(struct device *dev, pm_message_t state)
 {
 	int error = 0;
 
+	if (dev->class && dev->class->pm) {
+		pm_dev_dbg(dev, state, "LATE class ");
+		error = pm_noirq_op(dev, dev->class->pm, state);
+		if (error)
+			goto End;
+	}
+
+	if (dev->type && dev->type->pm) {
+		pm_dev_dbg(dev, state, "LATE type ");
+		error = pm_noirq_op(dev, dev->type->pm, state);
+		if (error)
+			goto End;
+	}
+
 	if (dev->bus && dev->bus->pm) {
 		pm_dev_dbg(dev, state, "LATE ");
 		error = pm_noirq_op(dev, dev->bus->pm, state);
 	}
+
+End:
 	return error;
 }
 
diff --git a/drivers/pcmcia/at91_cf.c b/drivers/pcmcia/at91_cf.c
index 5d22807..fb904f4 100644
--- a/drivers/pcmcia/at91_cf.c
+++ b/drivers/pcmcia/at91_cf.c
@@ -361,7 +361,6 @@ static int at91_cf_suspend(struct platform_device *pdev, pm_message_t mesg)
 	struct at91_cf_socket	*cf = platform_get_drvdata(pdev);
 	struct at91_cf_data	*board = cf->board;
 
-	pcmcia_socket_dev_suspend(&pdev->dev);
 	if (device_may_wakeup(&pdev->dev)) {
 		enable_irq_wake(board->det_pin);
 		if (board->irq_pin)
@@ -381,7 +380,6 @@ static int at91_cf_resume(struct platform_device *pdev)
 			disable_irq_wake(board->irq_pin);
 	}
 
-	pcmcia_socket_dev_resume(&pdev->dev);
 	return 0;
 }
 
diff --git a/drivers/pcmcia/au1000_generic.c b/drivers/pcmcia/au1000_generic.c
index 171c8a6..ac4d089 100644
--- a/drivers/pcmcia/au1000_generic.c
+++ b/drivers/pcmcia/au1000_generic.c
@@ -510,17 +510,6 @@ static int au1x00_drv_pcmcia_probe(struct platform_device *dev)
 	return ret;
 }
 
-static int au1x00_drv_pcmcia_suspend(struct platform_device *dev,
-				     pm_message_t state)
-{
-	return pcmcia_socket_dev_suspend(&dev->dev);
-}
-
-static int au1x00_drv_pcmcia_resume(struct platform_device *dev)
-{
-	return pcmcia_socket_dev_resume(&dev->dev);
-}
-
 static struct platform_driver au1x00_pcmcia_driver = {
 	.driver = {
 		.name		= "au1x00-pcmcia",
@@ -528,8 +517,6 @@ static struct platform_driver au1x00_pcmcia_driver = {
 	},
 	.probe		= au1x00_drv_pcmcia_probe,
 	.remove		= au1x00_drv_pcmcia_remove,
-	.suspend 	= au1x00_drv_pcmcia_suspend,
-	.resume 	= au1x00_drv_pcmcia_resume,
 };
 
 
diff --git a/drivers/pcmcia/bfin_cf_pcmcia.c b/drivers/pcmcia/bfin_cf_pcmcia.c
index 1744f38..b16f209 100644
--- a/drivers/pcmcia/bfin_cf_pcmcia.c
+++ b/drivers/pcmcia/bfin_cf_pcmcia.c
@@ -300,16 +300,6 @@ static int __devexit bfin_cf_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static int bfin_cf_suspend(struct platform_device *pdev, pm_message_t mesg)
-{
-	return pcmcia_socket_dev_suspend(&pdev->dev);
-}
-
-static int bfin_cf_resume(struct platform_device *pdev)
-{
-	return pcmcia_socket_dev_resume(&pdev->dev);
-}
-
 static struct platform_driver bfin_cf_driver = {
 	.driver = {
 		   .name = (char *)driver_name,
@@ -317,8 +307,6 @@ static struct platform_driver bfin_cf_driver = {
 		   },
 	.probe = bfin_cf_probe,
 	.remove = __devexit_p(bfin_cf_remove),
-	.suspend = bfin_cf_suspend,
-	.resume = bfin_cf_resume,
 };
 
 static int __init bfin_cf_init(void)
diff --git a/drivers/pcmcia/cs.c b/drivers/pcmcia/cs.c
index 2295837..4c1bb8a 100644
--- a/drivers/pcmcia/cs.c
+++ b/drivers/pcmcia/cs.c
@@ -76,65 +76,6 @@ DECLARE_RWSEM(pcmcia_socket_list_rwsem);
 EXPORT_SYMBOL(pcmcia_socket_list_rwsem);
 
 
-/*
- * Low-level PCMCIA socket drivers need to register with the PCCard
- * core using pcmcia_register_socket.
- *
- * socket drivers are expected to use the following callbacks in their
- * .drv struct:
- *  - pcmcia_socket_dev_suspend
- *  - pcmcia_socket_dev_resume
- * These functions check for the appropriate struct pcmcia_soket arrays,
- * and pass them to the low-level functions pcmcia_{suspend,resume}_socket
- */
-static int socket_early_resume(struct pcmcia_socket *skt);
-static int socket_late_resume(struct pcmcia_socket *skt);
-static int socket_resume(struct pcmcia_socket *skt);
-static int socket_suspend(struct pcmcia_socket *skt);
-
-static void pcmcia_socket_dev_run(struct device *dev,
-				  int (*cb)(struct pcmcia_socket *))
-{
-	struct pcmcia_socket *socket;
-
-	down_read(&pcmcia_socket_list_rwsem);
-	list_for_each_entry(socket, &pcmcia_socket_list, socket_list) {
-		if (socket->dev.parent != dev)
-			continue;
-		mutex_lock(&socket->skt_mutex);
-		cb(socket);
-		mutex_unlock(&socket->skt_mutex);
-	}
-	up_read(&pcmcia_socket_list_rwsem);
-}
-
-int pcmcia_socket_dev_suspend(struct device *dev)
-{
-	pcmcia_socket_dev_run(dev, socket_suspend);
-	return 0;
-}
-EXPORT_SYMBOL(pcmcia_socket_dev_suspend);
-
-void pcmcia_socket_dev_early_resume(struct device *dev)
-{
-	pcmcia_socket_dev_run(dev, socket_early_resume);
-}
-EXPORT_SYMBOL(pcmcia_socket_dev_early_resume);
-
-void pcmcia_socket_dev_late_resume(struct device *dev)
-{
-	pcmcia_socket_dev_run(dev, socket_late_resume);
-}
-EXPORT_SYMBOL(pcmcia_socket_dev_late_resume);
-
-int pcmcia_socket_dev_resume(struct device *dev)
-{
-	pcmcia_socket_dev_run(dev, socket_resume);
-	return 0;
-}
-EXPORT_SYMBOL(pcmcia_socket_dev_resume);
-
-
 struct pcmcia_socket *pcmcia_get_socket(struct pcmcia_socket *skt)
 {
 	struct device *dev = get_device(&skt->dev);
@@ -577,12 +518,18 @@ static int socket_early_resume(struct pcmcia_socket *skt)
 
 static int socket_late_resume(struct pcmcia_socket *skt)
 {
+	int ret;
+
 	mutex_lock(&skt->ops_mutex);
 	skt->state &= ~SOCKET_SUSPEND;
 	mutex_unlock(&skt->ops_mutex);
 
-	if (!(skt->state & SOCKET_PRESENT))
-		return socket_insert(skt);
+	if (!(skt->state & SOCKET_PRESENT)) {
+		ret = socket_insert(skt);
+		if (ret == -ENODEV)
+			ret = 0;
+		return ret;
+	}
 
 	if (skt->resume_status) {
 		socket_shutdown(skt);
@@ -918,11 +865,66 @@ static void pcmcia_release_socket_class(struct class *data)
 }
 
 
+#ifdef CONFIG_PM
+
+static int __pcmcia_pm_op(struct device *dev,
+			  int (*callback) (struct pcmcia_socket *skt))
+{
+	struct pcmcia_socket *s = container_of(dev, struct pcmcia_socket, dev);
+	int ret;
+
+	mutex_lock(&s->skt_mutex);
+	ret = callback(s);
+	mutex_unlock(&s->skt_mutex);
+
+	return ret;
+}
+
+static int pcmcia_socket_dev_suspend_noirq(struct device *dev)
+{
+	return __pcmcia_pm_op(dev, socket_suspend);
+}
+
+static int pcmcia_socket_dev_resume_noirq(struct device *dev)
+{
+	return __pcmcia_pm_op(dev, socket_early_resume);
+}
+
+static int pcmcia_socket_dev_resume(struct device *dev)
+{
+	return __pcmcia_pm_op(dev, socket_late_resume);
+}
+
+static const struct dev_pm_ops pcmcia_socket_pm_ops = {
+	/* dev_resume may be called with IRQs enabled */
+	SET_SYSTEM_SLEEP_PM_OPS(NULL,
+				pcmcia_socket_dev_resume)
+
+	/* late suspend must be called with IRQs disabled */
+	.suspend_noirq = pcmcia_socket_dev_suspend_noirq,
+	.freeze_noirq = pcmcia_socket_dev_suspend_noirq,
+	.poweroff_noirq = pcmcia_socket_dev_suspend_noirq,
+
+	/* early resume must be called with IRQs disabled */
+	.resume_noirq = pcmcia_socket_dev_resume_noirq,
+	.thaw_noirq = pcmcia_socket_dev_resume_noirq,
+	.restore_noirq = pcmcia_socket_dev_resume_noirq,
+};
+
+#define PCMCIA_SOCKET_CLASS_PM_OPS (&pcmcia_socket_pm_ops)
+
+#else /* CONFIG_PM */
+
+#define PCMCIA_SOCKET_CLASS_PM_OPS NULL
+
+#endif /* CONFIG_PM */
+
 struct class pcmcia_socket_class = {
 	.name = "pcmcia_socket",
 	.dev_uevent = pcmcia_socket_uevent,
 	.dev_release = pcmcia_release_socket,
 	.class_release = pcmcia_release_socket_class,
+	.pm = PCMCIA_SOCKET_CLASS_PM_OPS,
 };
 EXPORT_SYMBOL(pcmcia_socket_class);
 
diff --git a/drivers/pcmcia/db1xxx_ss.c b/drivers/pcmcia/db1xxx_ss.c
index 9254ab0..a520193 100644
--- a/drivers/pcmcia/db1xxx_ss.c
+++ b/drivers/pcmcia/db1xxx_ss.c
@@ -558,37 +558,10 @@ static int __devexit db1x_pcmcia_socket_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM
-static int db1x_pcmcia_suspend(struct device *dev)
-{
-	return pcmcia_socket_dev_suspend(dev);
-}
-
-static int db1x_pcmcia_resume(struct device *dev)
-{
-	return pcmcia_socket_dev_resume(dev);
-}
-
-static struct dev_pm_ops db1x_pcmcia_pmops = {
-	.resume		= db1x_pcmcia_resume,
-	.suspend	= db1x_pcmcia_suspend,
-	.thaw		= db1x_pcmcia_resume,
-	.freeze		= db1x_pcmcia_suspend,
-};
-
-#define DB1XXX_SS_PMOPS &db1x_pcmcia_pmops
-
-#else
-
-#define DB1XXX_SS_PMOPS NULL
-
-#endif
-
 static struct platform_driver db1x_pcmcia_socket_driver = {
 	.driver	= {
 		.name	= "db1xxx_pcmcia",
 		.owner	= THIS_MODULE,
-		.pm	= DB1XXX_SS_PMOPS
 	},
 	.probe		= db1x_pcmcia_socket_probe,
 	.remove		= __devexit_p(db1x_pcmcia_socket_remove),
diff --git a/drivers/pcmcia/i82092.c b/drivers/pcmcia/i82092.c
index f5da626..3003bb3 100644
--- a/drivers/pcmcia/i82092.c
+++ b/drivers/pcmcia/i82092.c
@@ -39,27 +39,11 @@ static struct pci_device_id i82092aa_pci_ids[] = {
 };
 MODULE_DEVICE_TABLE(pci, i82092aa_pci_ids);
 
-#ifdef CONFIG_PM
-static int i82092aa_socket_suspend (struct pci_dev *dev, pm_message_t state)
-{
-	return pcmcia_socket_dev_suspend(&dev->dev);
-}
-
-static int i82092aa_socket_resume (struct pci_dev *dev)
-{
-	return pcmcia_socket_dev_resume(&dev->dev);
-}
-#endif
-
 static struct pci_driver i82092aa_pci_driver = {
 	.name           = "i82092aa",
 	.id_table       = i82092aa_pci_ids,
 	.probe          = i82092aa_pci_probe,
 	.remove         = __devexit_p(i82092aa_pci_remove),
-#ifdef CONFIG_PM
-	.suspend        = i82092aa_socket_suspend,
-	.resume         = i82092aa_socket_resume,
-#endif
 };
 
 
diff --git a/drivers/pcmcia/i82365.c b/drivers/pcmcia/i82365.c
index c13fd93..d53d9b5 100644
--- a/drivers/pcmcia/i82365.c
+++ b/drivers/pcmcia/i82365.c
@@ -1223,16 +1223,7 @@ static int pcic_init(struct pcmcia_socket *s)
 	return 0;
 }
 
-static int i82365_drv_pcmcia_suspend(struct platform_device *dev,
-				     pm_message_t state)
-{
-	return pcmcia_socket_dev_suspend(&dev->dev);
-}
 
-static int i82365_drv_pcmcia_resume(struct platform_device *dev)
-{
-	return pcmcia_socket_dev_resume(&dev->dev);
-}
 static struct pccard_operations pcic_operations = {
 	.init			= pcic_init,
 	.get_status		= pcic_get_status,
@@ -1248,8 +1239,6 @@ static struct platform_driver i82365_driver = {
 		.name = "i82365",
 		.owner		= THIS_MODULE,
 	},
-	.suspend 	= i82365_drv_pcmcia_suspend,
-	.resume 	= i82365_drv_pcmcia_resume,
 };
 
 static struct platform_device *i82365_device;
diff --git a/drivers/pcmcia/m32r_cfc.c b/drivers/pcmcia/m32r_cfc.c
index 0ece2cd..ab21264 100644
--- a/drivers/pcmcia/m32r_cfc.c
+++ b/drivers/pcmcia/m32r_cfc.c
@@ -685,16 +685,7 @@ static struct pccard_operations pcc_operations = {
 	.set_mem_map		= pcc_set_mem_map,
 };
 
-static int cfc_drv_pcmcia_suspend(struct platform_device *dev,
-				     pm_message_t state)
-{
-	return pcmcia_socket_dev_suspend(&dev->dev);
-}
 
-static int cfc_drv_pcmcia_resume(struct platform_device *dev)
-{
-	return pcmcia_socket_dev_resume(&dev->dev);
-}
 /*====================================================================*/
 
 static struct platform_driver pcc_driver = {
@@ -702,8 +693,6 @@ static struct platform_driver pcc_driver = {
 		.name		= "cfc",
 		.owner		= THIS_MODULE,
 	},
-	.suspend 	= cfc_drv_pcmcia_suspend,
-	.resume 	= cfc_drv_pcmcia_resume,
 };
 
 static struct platform_device pcc_device = {
diff --git a/drivers/pcmcia/m32r_pcc.c b/drivers/pcmcia/m32r_pcc.c
index 72844c5..0caf3db 100644
--- a/drivers/pcmcia/m32r_pcc.c
+++ b/drivers/pcmcia/m32r_pcc.c
@@ -663,16 +663,6 @@ static struct pccard_operations pcc_operations = {
 	.set_mem_map		= pcc_set_mem_map,
 };
 
-static int pcc_drv_pcmcia_suspend(struct platform_device *dev,
-				     pm_message_t state)
-{
-	return pcmcia_socket_dev_suspend(&dev->dev);
-}
-
-static int pcc_drv_pcmcia_resume(struct platform_device *dev)
-{
-	return pcmcia_socket_dev_resume(&dev->dev);
-}
 /*====================================================================*/
 
 static struct platform_driver pcc_driver = {
@@ -680,8 +670,6 @@ static struct platform_driver pcc_driver = {
 		.name		= "pcc",
 		.owner		= THIS_MODULE,
 	},
-	.suspend 	= pcc_drv_pcmcia_suspend,
-	.resume 	= pcc_drv_pcmcia_resume,
 };
 
 static struct platform_device pcc_device = {
diff --git a/drivers/pcmcia/m8xx_pcmcia.c b/drivers/pcmcia/m8xx_pcmcia.c
index 61c2159..01ef7de 100644
--- a/drivers/pcmcia/m8xx_pcmcia.c
+++ b/drivers/pcmcia/m8xx_pcmcia.c
@@ -1288,21 +1288,6 @@ static int m8xx_remove(struct of_device *ofdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM
-static int m8xx_suspend(struct platform_device *pdev, pm_message_t state)
-{
-	return pcmcia_socket_dev_suspend(&pdev->dev);
-}
-
-static int m8xx_resume(struct platform_device *pdev)
-{
-	return pcmcia_socket_dev_resume(&pdev->dev);
-}
-#else
-#define m8xx_suspend NULL
-#define m8xx_resume NULL
-#endif
-
 static const struct of_device_id m8xx_pcmcia_match[] = {
 	{
 	 .type = "pcmcia",
@@ -1318,8 +1303,6 @@ static struct of_platform_driver m8xx_pcmcia_driver = {
 	.match_table = m8xx_pcmcia_match,
 	.probe = m8xx_probe,
 	.remove = m8xx_remove,
-	.suspend = m8xx_suspend,
-	.resume = m8xx_resume,
 };
 
 static int __init m8xx_init(void)
diff --git a/drivers/pcmcia/omap_cf.c b/drivers/pcmcia/omap_cf.c
index 7d49ba0..eef5f1c 100644
--- a/drivers/pcmcia/omap_cf.c
+++ b/drivers/pcmcia/omap_cf.c
@@ -330,24 +330,12 @@ static int __exit omap_cf_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static int omap_cf_suspend(struct platform_device *pdev, pm_message_t mesg)
-{
-	return pcmcia_socket_dev_suspend(&pdev->dev);
-}
-
-static int omap_cf_resume(struct platform_device *pdev)
-{
-	return pcmcia_socket_dev_resume(&pdev->dev);
-}
-
 static struct platform_driver omap_cf_driver = {
 	.driver = {
 		.name	= (char *) driver_name,
 		.owner	= THIS_MODULE,
 	},
 	.remove		= __exit_p(omap_cf_remove),
-	.suspend	= omap_cf_suspend,
-	.resume		= omap_cf_resume,
 };
 
 static int __init omap_cf_init(void)
diff --git a/drivers/pcmcia/pd6729.c b/drivers/pcmcia/pd6729.c
index 47f342f..4a34268 100644
--- a/drivers/pcmcia/pd6729.c
+++ b/drivers/pcmcia/pd6729.c
@@ -764,18 +764,6 @@ static void __devexit pd6729_pci_remove(struct pci_dev *dev)
 	kfree(socket);
 }
 
-#ifdef CONFIG_PM
-static int pd6729_socket_suspend(struct pci_dev *dev, pm_message_t state)
-{
-	return pcmcia_socket_dev_suspend(&dev->dev);
-}
-
-static int pd6729_socket_resume(struct pci_dev *dev)
-{
-	return pcmcia_socket_dev_resume(&dev->dev);
-}
-#endif
-
 static struct pci_device_id pd6729_pci_ids[] = {
 	{
 		.vendor		= PCI_VENDOR_ID_CIRRUS,
@@ -792,10 +780,6 @@ static struct pci_driver pd6729_pci_driver = {
 	.id_table	= pd6729_pci_ids,
 	.probe		= pd6729_pci_probe,
 	.remove		= __devexit_p(pd6729_pci_remove),
-#ifdef CONFIG_PM
-	.suspend	= pd6729_socket_suspend,
-	.resume		= pd6729_socket_resume,
-#endif
 };
 
 static int pd6729_module_init(void)
diff --git a/drivers/pcmcia/pxa2xx_base.c b/drivers/pcmcia/pxa2xx_base.c
index 76e640b..0a876fa 100644
--- a/drivers/pcmcia/pxa2xx_base.c
+++ b/drivers/pcmcia/pxa2xx_base.c
@@ -325,19 +325,13 @@ static int pxa2xx_drv_pcmcia_remove(struct platform_device *dev)
 	return 0;
 }
 
-static int pxa2xx_drv_pcmcia_suspend(struct device *dev)
-{
-	return pcmcia_socket_dev_suspend(dev);
-}
-
 static int pxa2xx_drv_pcmcia_resume(struct device *dev)
 {
 	pxa2xx_configure_sockets(dev);
-	return pcmcia_socket_dev_resume(dev);
+	return 0;
 }
 
 static const struct dev_pm_ops pxa2xx_drv_pcmcia_pm_ops = {
-	.suspend	= pxa2xx_drv_pcmcia_suspend,
 	.resume		= pxa2xx_drv_pcmcia_resume,
 };
 
diff --git a/drivers/pcmcia/sa1100_generic.c b/drivers/pcmcia/sa1100_generic.c
index 8db86b9..5188962 100644
--- a/drivers/pcmcia/sa1100_generic.c
+++ b/drivers/pcmcia/sa1100_generic.c
@@ -95,17 +95,6 @@ static int sa11x0_drv_pcmcia_remove(struct platform_device *dev)
 	return 0;
 }
 
-static int sa11x0_drv_pcmcia_suspend(struct platform_device *dev,
-				     pm_message_t state)
-{
-	return pcmcia_socket_dev_suspend(&dev->dev);
-}
-
-static int sa11x0_drv_pcmcia_resume(struct platform_device *dev)
-{
-	return pcmcia_socket_dev_resume(&dev->dev);
-}
-
 static struct platform_driver sa11x0_pcmcia_driver = {
 	.driver = {
 		.name		= "sa11x0-pcmcia",
@@ -113,8 +102,6 @@ static struct platform_driver sa11x0_pcmcia_driver = {
 	},
 	.probe		= sa11x0_drv_pcmcia_probe,
 	.remove		= sa11x0_drv_pcmcia_remove,
-	.suspend 	= sa11x0_drv_pcmcia_suspend,
-	.resume 	= sa11x0_drv_pcmcia_resume,
 };
 
 /* sa11x0_pcmcia_init()
diff --git a/drivers/pcmcia/sa1111_generic.c b/drivers/pcmcia/sa1111_generic.c
index db79ca6..799e979 100644
--- a/drivers/pcmcia/sa1111_generic.c
+++ b/drivers/pcmcia/sa1111_generic.c
@@ -213,16 +213,6 @@ static int __devexit pcmcia_remove(struct sa1111_dev *dev)
 	return 0;
 }
 
-static int pcmcia_suspend(struct sa1111_dev *dev, pm_message_t state)
-{
-	return pcmcia_socket_dev_suspend(&dev->dev);
-}
-
-static int pcmcia_resume(struct sa1111_dev *dev)
-{
-	return pcmcia_socket_dev_resume(&dev->dev);
-}
-
 static struct sa1111_driver pcmcia_driver = {
 	.drv = {
 		.name	= "sa1111-pcmcia",
@@ -230,8 +220,6 @@ static struct sa1111_driver pcmcia_driver = {
 	.devid		= SA1111_DEVID_PCMCIA,
 	.probe		= pcmcia_probe,
 	.remove		= __devexit_p(pcmcia_remove),
-	.suspend	= pcmcia_suspend,
-	.resume		= pcmcia_resume,
 };
 
 static int __init sa1111_drv_pcmcia_init(void)
diff --git a/drivers/pcmcia/tcic.c b/drivers/pcmcia/tcic.c
index 12c49ee..bac85f3 100644
--- a/drivers/pcmcia/tcic.c
+++ b/drivers/pcmcia/tcic.c
@@ -348,16 +348,6 @@ static int __init get_tcic_id(void)
     return id;
 }
 
-static int tcic_drv_pcmcia_suspend(struct platform_device *dev,
-				     pm_message_t state)
-{
-	return pcmcia_socket_dev_suspend(&dev->dev);
-}
-
-static int tcic_drv_pcmcia_resume(struct platform_device *dev)
-{
-	return pcmcia_socket_dev_resume(&dev->dev);
-}
 /*====================================================================*/
 
 static struct platform_driver tcic_driver = {
@@ -365,8 +355,6 @@ static struct platform_driver tcic_driver = {
 		.name = "tcic-pcmcia",
 		.owner		= THIS_MODULE,
 	},
-	.suspend 	= tcic_drv_pcmcia_suspend,
-	.resume 	= tcic_drv_pcmcia_resume,
 };
 
 static struct platform_device tcic_device = {
diff --git a/drivers/pcmcia/vrc4171_card.c b/drivers/pcmcia/vrc4171_card.c
index aaccdb9..86e4a1a 100644
--- a/drivers/pcmcia/vrc4171_card.c
+++ b/drivers/pcmcia/vrc4171_card.c
@@ -705,24 +705,11 @@ static int __devinit vrc4171_card_setup(char *options)
 
 __setup("vrc4171_card=", vrc4171_card_setup);
 
-static int vrc4171_card_suspend(struct platform_device *dev,
-				     pm_message_t state)
-{
-	return pcmcia_socket_dev_suspend(&dev->dev);
-}
-
-static int vrc4171_card_resume(struct platform_device *dev)
-{
-	return pcmcia_socket_dev_resume(&dev->dev);
-}
-
 static struct platform_driver vrc4171_card_driver = {
 	.driver = {
 		.name		= vrc4171_card_name,
 		.owner		= THIS_MODULE,
 	},
-	.suspend	= vrc4171_card_suspend,
-	.resume		= vrc4171_card_resume,
 };
 
 static int __devinit vrc4171_card_init(void)
diff --git a/drivers/pcmcia/yenta_socket.c b/drivers/pcmcia/yenta_socket.c
index 418988a..f19ad02 100644
--- a/drivers/pcmcia/yenta_socket.c
+++ b/drivers/pcmcia/yenta_socket.c
@@ -1290,12 +1290,9 @@ static int yenta_dev_suspend_noirq(struct device *dev)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
 	struct yenta_socket *socket = pci_get_drvdata(pdev);
-	int ret;
-
-	ret = pcmcia_socket_dev_suspend(dev);
 
 	if (!socket)
-		return ret;
+		return 0;
 
 	if (socket->type && socket->type->save_state)
 		socket->type->save_state(socket);
@@ -1312,7 +1309,7 @@ static int yenta_dev_suspend_noirq(struct device *dev)
 	 */
 	/* pci_set_power_state(dev, 3); */
 
-	return ret;
+	return 0;
 }
 
 static int yenta_dev_resume_noirq(struct device *dev)
@@ -1336,26 +1333,16 @@ static int yenta_dev_resume_noirq(struct device *dev)
 	if (socket->type && socket->type->restore_state)
 		socket->type->restore_state(socket);
 
-	pcmcia_socket_dev_early_resume(dev);
-	return 0;
-}
-
-static int yenta_dev_resume(struct device *dev)
-{
-	pcmcia_socket_dev_late_resume(dev);
 	return 0;
 }
 
 static const struct dev_pm_ops yenta_pm_ops = {
 	.suspend_noirq = yenta_dev_suspend_noirq,
 	.resume_noirq = yenta_dev_resume_noirq,
-	.resume = yenta_dev_resume,
 	.freeze_noirq = yenta_dev_suspend_noirq,
 	.thaw_noirq = yenta_dev_resume_noirq,
-	.thaw = yenta_dev_resume,
 	.poweroff_noirq = yenta_dev_suspend_noirq,
 	.restore_noirq = yenta_dev_resume_noirq,
-	.restore = yenta_dev_resume,
 };
 
 #define YENTA_PM_OPS	(&yenta_pm_ops)
diff --git a/include/pcmcia/ss.h b/include/pcmcia/ss.h
index 313c912..5a109c8 100644
--- a/include/pcmcia/ss.h
+++ b/include/pcmcia/ss.h
@@ -275,12 +275,6 @@ extern struct pccard_resource_ops pccard_nonstatic_ops;
 #endif
 
 
-/* socket drivers are expected to use these callbacks in their .drv struct */
-extern int pcmcia_socket_dev_suspend(struct device *dev);
-extern void pcmcia_socket_dev_early_resume(struct device *dev);
-extern void pcmcia_socket_dev_late_resume(struct device *dev);
-extern int pcmcia_socket_dev_resume(struct device *dev);
-
 /* socket drivers use this callback in their IRQ handler */
 extern void pcmcia_parse_events(struct pcmcia_socket *socket,
 				unsigned int events);
