From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 1/8] ACPI / PCI: Introduce
	acpi_pci_osc_control_query()
Date: Tue, 3 Aug 2010 11:24:56 +0200
Message-ID: <201008031124.56735.rjw__6547.13211483813$1280827770$gmane$org@sisk.pl>
References: <201008022351.31406.rjw@sisk.pl> <201008022353.04353.rjw@sisk.pl>
	<4C57A071.2090902@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4C57A071.2090902@jp.fujitsu.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Cc: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>, linux-pci@vger.kernel.org, Jesse Barnes <jbarnes@virtuousgeek.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Tuesday, August 03, 2010, Kenji Kaneshige wrote:
> (2010/08/03 6:53), Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki<rjw@sisk.pl>
> >
> > Introduce a function allowing the caller to obtain a mask of _OSC
> > control bits the BIOS will allow the kernel to control for a given
> > PCI root bridge.
> >
> > Signed-off-by: Rafael J. Wysocki<rjw@sisk.pl>
> > ---
> >   drivers/acpi/pci_root.c |   58 ++++++++++++++++++++++++++++++++++++++++--------
> >   include/linux/acpi.h    |    1
> >   2 files changed, 50 insertions(+), 9 deletions(-)
> >
> > Index: linux-2.6/drivers/acpi/pci_root.c
> > ===================================================================
> > --- linux-2.6.orig/drivers/acpi/pci_root.c
> > +++ linux-2.6/drivers/acpi/pci_root.c
> > @@ -225,21 +225,32 @@ static acpi_status acpi_pci_run_osc(acpi
> >   	return status;
> >   }
> >
> > -static acpi_status acpi_pci_query_osc(struct acpi_pci_root *root, u32 flags)
> > +static acpi_status acpi_pci_query_osc(struct acpi_pci_root *root,
> > +					u32 support,
> > +					u32 *control)
> >   {
> >   	acpi_status status;
> > -	u32 support_set, result, capbuf[3];
> > +	u32 result, capbuf[3];
> > +
> > +	support&= OSC_PCI_SUPPORT_MASKS;
> > +	support |= root->osc_support_set;
> >
> > -	/* do _OSC query for all possible controls */
> > -	support_set = root->osc_support_set | (flags&  OSC_PCI_SUPPORT_MASKS);
> >   	capbuf[OSC_QUERY_TYPE] = OSC_QUERY_ENABLE;
> > -	capbuf[OSC_SUPPORT_TYPE] = support_set;
> > -	capbuf[OSC_CONTROL_TYPE] = OSC_PCI_CONTROL_MASKS;
> > +	capbuf[OSC_SUPPORT_TYPE] = support;
> > +	if (control) {
> > +		*control&= OSC_PCI_CONTROL_MASKS;
> > +		capbuf[OSC_CONTROL_TYPE] = *control;
> 
> I think controls that are already granted to OS need to be ORed here.
> I.e.
> 
> 		capbuf[OSC_CONTROL_TYPE] = root->osc_control_set | *control;

That's correct.

Thanks,
Rafael
