From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: dev_pm_ops and PCMCIA sockets
Date: Mon, 15 Mar 2010 16:50:36 +0100
Message-ID: <20100315155036.GA15101@comet.dominikbrodowski.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-pm@lists.linux-foundation.org
Cc: linux-pcmcia@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Hey,

attempting to use the "new-style" dev_pm_ops to handle the suspend / resume
needs of PCMCIA sockets gives me a headache. Maybe you can assist me in
doing it properly?

(1) PCMCIA/CardBus sockets all share one class:
	 struct class pcmcia_socket_class
    The "class" devices (which are struct *device now) are registered in
    drivers/pcmcia/cs.c . The functional ordering is:


	struct device *dev	-- some PCMCIA/CardBus bridge

	struct device *dev	-- of class pcmcia_socket_class; represents
				   the socket. One bridge may have mutliple
				   sockets.

	struct device *dev	-- of bus "pcmcia" or "pci"; represents the
				   PCMCIA/CardBus card. One card is in one
				   socket; but one card may have multiple
				   "pcmcia" or "pci" devices.


(2) For suspend, we need the following order:

	1) CardBus and PCMCIA cards themselves;
	   IRQs may be on.

	   For CardBus, this is well handled by the PCI subsystem; for
	   PCMCIA cards, we currently rely on an old-style "suspend"
	   callback in struct bus_type .

	2) the PCMCIA/CardBus socket ("class devices"); IRQs may be on

	   Currently, we rely on an ugly, custom callback mechanism. Quoting
	   drivers/pcmcia/cs.c:

	    * socket drivers are expected to use the following callbacks in
	    * their .drv struct:
	    *  - pcmcia_socket_dev_suspend
	    *  - pcmcia_socket_dev_resume
	    * These functions check for the appropriate struct pcmcia_soket arrays,
	    * and pass them to the low-level functions pcmcia_{suspend,resume}_socket

	3) The PCMCIA/CardBus bridge devices; both with IRQs on and off

	   For example, yenta_socket appropriately uses "struct dev_pm_ops".


(3) For resume, it's a bit more complicated:

	1) The PCMCIA/CardBus bridge devices with IRQs off

	2) The PCMCIA/CardBus sockets ("class devices") with IRQs off

	3) the PCMCIA/CardBus bridge devices with IRQs on

	4) The PCMCIA/CardBus sockets ("class devices") with IRQs on

	5) CardBus and PCMCIA cards themselves


(4) A first attempt to use struct dev_pm_ops in struct class pcmcia_socket_class

+ const struct dev_pm_ops pcmcia_socket_pm_ops = {
+ 	/* dev_suspend, dev_resume may be called with IRQs enabled */
+ 	SET_SYSTEM_SLEEP_PM_OPS(pcmcia_socket_classdev_suspend,
+ 				pcmcia_socket_classdev_resume)
+ 
+ 	/* early resume must be called with IRQs disabled */
+ 	.resume_noirq = pcmcia_socket_classdev_resume_noirq,
+ 	.thaw_noirq = pcmcia_socket_classdev_resume_noirq,
+ 	.restore_noirq = pcmcia_socket_classdev_resume_noirq,
+ };

    lead to the following issues:

     a) resume_noirq never got called. Haven't tried thaw_noirq and
	restore_noirq so far.

     b) If I read the information about ordering in Documentation/power/devices.txt
        correctly, even a functioning _noirq callback for classes would
	cause the order for suspend to be:

	- IRQs on, classes first, devices next:
		PCMCIA/CardBus socket (is 1, should be 2)
		PCMCIA/CardBus cards (is 2, should be 1)

		PCMCIA/CardBus bridge devices (is 3)

	- IRQs off:
		PCMCIA/CardBus bridge devices (is 3)

        and for resume to be:

	- IRQs off, devices first, classes next:

		PCMCIA/CardBus bridge devices (is 1)
		PCMCIA/CardBus socket         (is 2)

	- IRQs on, devices first, classes next:

		PCMCIA/CardBus bridge	      (is 3)
		PCMCIA/CardBus cards	      (is 4, should be 5)
		PCMCIA/CardBus socket	      (is 5, should be 4)


Any ideas on how to resolve these issues using the new-stlye dev_pm_ops?

Best,
	Dominik
