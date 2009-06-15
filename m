From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: PCI hotplug v.s. suspend
Date: Mon, 15 Jun 2009 21:58:30 +0200
Message-ID: <200906152158.30989.rjw__46911.7036358968$1245095951$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0906151035560.5057-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0906151035560.5057-100000@iolanthe.rowland.org>
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
To: linux-pm@lists.linux-foundation.org
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, Alan Jenkins <alan-jenkins@tuffmail.co.uk>, ath5k-devel@venema.h4ckr.net, linux-pci@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Monday 15 June 2009, Alan Stern wrote:
> On Mon, 15 Jun 2009, Alan Jenkins wrote:
> 
> > Alan Stern wrote:
> > > On Mon, 15 Jun 2009, Alan Jenkins wrote:
> > >
> > >   
> > >> Hi,
> > >>
> > >> I triggered a WARNING while hacking on eeepc-laptop's 
> > >> rfkill-by-pci-hotplug.  I saw "Trying to free already-free IRQ" in 
> > >> ath5k_pci_remove(), because the IRQ was already freed by 
> > >> ath5k_pci_suspend().  My changes to eeepc-laptop had allowed the PCI 
> > >> device to be removed while suspended.
> > >>
> > >> Are PCI drivers supposed to handle remove() while suspended?
> > >>     
> > >
> > > Yes.  You found a bug in the driver.  However it's not clear (to me at
> > > least) whether the bug is that the IRQ is freed in the suspend method
> > > or that there's no check for already-freed in the remove method.  My 
> > > guess is the latter.
> > >
> > > Alan Stern
> > >   
> > 
> > The example in Documentation/power/pci.txt shows free_irq() being called
> > in suspend (and request_irq() in resume).  So the problem is in remove().
> 
> I'm not sure whether the example is trustworthy.  There was some
> discussion quite a while ago regarding whether drivers should free
> their IRQs during suspend, but I don't remember what the outcome was.

No, they shouldn't.

That's why we do the entire suspend_device_irqs() thing etc.

Best,
Rafael
