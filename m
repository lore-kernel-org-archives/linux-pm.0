From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] ACPI / PCI: Fix NULL pointer dereference in
	acpi_get_pci_dev()
Date: Tue, 6 Oct 2009 02:01:42 +0200
Message-ID: <200910060201.42519.rjw@sisk.pl>
References: <200910060130.43246.rjw@sisk.pl>
	<20091005233759.GB14394@ldl.fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20091005233759.GB14394@ldl.fc.hp.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alex Chiang <achiang@hp.com>
Cc: chepioq@gmail.com, Linux PCI <linux-pci@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Danny Feng <dfeng@redhat.com>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Tuesday 06 October 2009, Alex Chiang wrote:
> * Rafael J. Wysocki <rjw@sisk.pl>:
> > 
> > Fixes http://bugzilla.kernel.org/show_bug.cgi?id=14129, which is a
> > regression from 2.6.30.
> 
> Thanks for doing this.
> 
> One small comment below (not major), but other than that:
> 
> Reviewed-by: Alex Chiang <achiang@hp.com>
> 
> > Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> > Reported-by: Danny Feng <dfeng@redhat.com>
> > Tested-by: chepioq <chepioq@gmail.com>
> > ---
> >  drivers/acpi/pci_root.c |   12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> > 
> > Index: linux-2.6/drivers/acpi/pci_root.c
> > ===================================================================
> > --- linux-2.6.orig/drivers/acpi/pci_root.c
> > +++ linux-2.6/drivers/acpi/pci_root.c
> > @@ -389,6 +389,18 @@ struct pci_dev *acpi_get_pci_dev(acpi_ha
> >  
> >  		pbus = pdev->subordinate;
> >  		pci_dev_put(pdev);
> > +
> > +		/*
> > +		 * During resume from a sleep state we can get a dock
> > +		 * notification for a device that is present in ACPI tables,
> > +		 * but not physically accessible at the moment, so tell the
> > +		 * caller it's not present in that case.
> > +		 */
> > +		if (!pbus) {
> > +			dev_info(&pdev->dev, "Secondary bus not present\n");
> 
> Should this be dev_dbg() or maybe even strike it completely?

I thought about that, but I decided not to just in order to get some idea about
how many affected systems are out there.  If that happens to be a problem for
anyone, we can simply remove the message in the future.

> 
> > +			pdev = NULL;
> > +			break;
> > +		}
> >  	}
> >  out:
> >  	list_for_each_entry_safe(node, tmp, &device_list, node)
> > 

Thanks,
Rafael
