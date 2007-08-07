From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH] uli526x: Add suspend and resume routines
Date: Wed, 8 Aug 2007 00:24:28 +0200
Message-ID: <200708080024.28692.rjw__2466.99256026677$1186525135$gmane$org@sisk.pl>
References: <200708052114.01790.rjw@sisk.pl> <46B8E6D4.30405@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <46B8E6D4.30405@garzik.org>
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
To: Jeff Garzik <jeff@garzik.org>
Cc: Kyle McMartin <kyle@mcmartin.ca>, pm list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Grant Grundler <grundler@parisc-linux.org>
List-Id: linux-pm@vger.kernel.org

On Tuesday, 7 August 2007 23:40, Jeff Garzik wrote:
> Rafael J. Wysocki wrote:
> > +static int uli526x_suspend(struct pci_dev *pdev, pm_message_t state)
> > +{
> > +	struct net_device *dev = pci_get_drvdata(pdev);
> > +	int err = 0;
> > +
> > +	ULI526X_DBUG(0, "uli526x_suspend", 0);
> > +
> > +	if (dev && netdev_priv(dev)) {
> > +		pci_power_t power_state;
> > +
> > +		pci_save_state(pdev);
> > +
> > +		if (!netif_running(dev))
> > +			return 0;
> > +
> > +		netif_device_detach(dev);
> > +		uli526x_reset_prepare(dev);
> > +
> > +		power_state = pci_choose_state(pdev, state);
> > +		pci_enable_wake(pdev, power_state, 0);
> > +		err = pci_set_power_state(pdev, power_state);
> > +		if (err) {
> > +			netif_device_attach(dev);
> > +			/* Re-initialize ULI526X board */
> > +			uli526x_init(dev);
> > +			/* Restart upper layer interface */
> > +			netif_wake_queue(dev);
> > +		}
> > +	}
> > +	return err;
> > +}
> > +
> > +/*
> > + *	Resume the interface.
> > + */
> > +
> > +static int uli526x_resume(struct pci_dev *pdev)
> > +{
> > +	struct net_device *dev = pci_get_drvdata(pdev);
> > +	struct uli526x_board_info *db = netdev_priv(dev);
> > +
> > +	ULI526X_DBUG(0, "uli526x_resume", 0);
> > +
> > +	if (dev && db) {
> > +		int err;
> > +
> > +		pci_restore_state(pdev);
> > +
> > +		if (!netif_running(dev))
> > +			return 0;
> > +
> > +		err = pci_set_power_state(pdev, PCI_D0);
> > +		if (err) {
> > +			printk(KERN_WARNING
> > +				"%s: Could not put device into D0\n",
> > +				dev->name);
> > +			return err;
> > +		}
> > +
> > +		netif_device_attach(dev);
> > +		/* Re-initialize ULI526X board */
> > +		uli526x_init(dev);
> > +		/* Restart upper layer interface */
> > +		netif_wake_queue(dev);
> > +	}
> > +	return 0;
> 
> 
> Ugh -- please fix indentation.  This is not proper Linux code.
> 
> If you have the -vast majority- of code on an indented branch, as you 
> have here, then you should either add an early 'return x;' or a goto, 
> and unindent the main body of code.

OK, I will.

> I'll let our new tulip maintainer see what he thinks about the 
> implementation.  Seems fairly sane to me, but should at least get an "it 
> works" test.

It has been tested, as stated in the changelog, and works (on my test system).

Greetings,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth
