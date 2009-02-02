From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 3/3] PCI PM: Make warning in
	pci_legacy_suspend more useful
Date: Mon, 2 Feb 2009 13:02:30 +0100
Message-ID: <200902021302.31158.rjw__18774.1885347807$1233576474$gmane$org@sisk.pl>
References: <200902012229.27517.rjw@sisk.pl> <200902012234.25165.rjw@sisk.pl>
	<1233540601.21871.10.camel@nigel-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1233540601.21871.10.camel@nigel-laptop>
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
To: Nigel Cunningham <ncunningham@crca.org.au>
Cc: Linux PCI <linux-pci@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>
List-Id: linux-pm@vger.kernel.org

On Monday 02 February 2009, Nigel Cunningham wrote:
> Hi again.
> 
> On Sun, 2009-02-01 at 22:34 +0100, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rjw@sisk.pl>
> > 
> > The warning in pci_legacy_suspend() would be much more useful if it
> > printed the name of the function that did the wrong thing.  Make it
> > do so.
> > 
> > Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> > ---
> >  drivers/pci/pci-driver.c |    4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > Index: linux-2.6/drivers/pci/pci-driver.c
> > ===================================================================
> > --- linux-2.6.orig/drivers/pci/pci-driver.c
> > +++ linux-2.6/drivers/pci/pci-driver.c
> > @@ -365,7 +365,9 @@ static int pci_legacy_suspend(struct dev
> >  		if (pci_dev->state_saved)
> >  			goto Fixup;
> >  
> > -		if (WARN_ON_ONCE(pci_dev->current_state != PCI_D0))
> > +		if (WARN_ONCE(pci_dev->current_state != PCI_D0,
> > +				"PCI PM: Device state not saved by %pF\n",
> > +				drv->suspend))
> >  			goto Fixup;
> >  	}
> 
> Am I right in thinking that WARN_ONCE will only warn about the first
> driver that has the problem? If so, wouldn't it be better to make it
> warn about all drivers that have the problem, but only once per device?

That would be better, but I don't think we are going to see many of these
anyway. :-)

Thanks,
Rafael
