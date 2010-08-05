From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 7/8] ACPI / PCI: Do not preserve _OSC control
	bits returned by a query (v2)
Date: Thu, 5 Aug 2010 16:25:06 +0200
Message-ID: <201008051625.07190.rjw__8654.16431702233$1281018539$gmane$org@sisk.pl>
References: <201008022351.31406.rjw@sisk.pl> <201008050151.27501.rjw@sisk.pl>
	<4C5A32A9.6010008@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4C5A32A9.6010008@jp.fujitsu.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
Cc: linux-pci@vger.kernel.org, linux-pm@lists.linux-foundation.org, Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>, Jesse Barnes <jbarnes@virtuousgeek.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thursday, August 05, 2010, Hidetoshi Seto wrote:
> (2010/08/05 8:51), Rafael J. Wysocki wrote:
> > On Wednesday, August 04, 2010, Rafael J. Wysocki wrote:
> >> On Wednesday, August 04, 2010, Hidetoshi Seto wrote:
> >>> (2010/08/04 14:46), Kenji Kaneshige wrote:
> >>>> (2010/08/04 6:02), Rafael J. Wysocki wrote:
> >>>>> On Tuesday, August 03, 2010, Rafael J. Wysocki wrote:
> >>>>>> On Tuesday, August 03, 2010, Hidetoshi Seto wrote:
> >>>>>>> (2010/08/03 13:52), Kenji Kaneshige wrote:
> >>>>>>>> (2010/08/03 6:59), Rafael J. Wysocki wrote:
> >>>>>>>>> @@ -434,19 +432,6 @@ acpi_status acpi_pci_osc_control_set(acp
> >>>>>>>>>        if ((root->osc_control_set&   control_req) == control_req)
> >>>>>>>>>            goto out;
> >>>>>>>>>
> >>>>>>>>> -    /* Need to query controls first before requesting them */
> >>>>>>>>> -    if (!root->osc_queried) {
> >>>>>>>>> -        status = acpi_pci_query_osc(root, root->osc_support_set, NULL);
> >>>>>>>>> -        if (ACPI_FAILURE(status))
> >>>>>>>>> -            goto out;
> >>>>>>>>> -    }
> >>>>>>>>> -    if ((root->osc_control_qry&   control_req) != control_req) {
> >>>>>>>>> -        printk(KERN_DEBUG
> >>>>>>>>> -               "Firmware did not grant requested _OSC control\n");
> >>>>>>>>> -        status = AE_SUPPORT;
> >>>>>>>>> -        goto out;
> >>>>>>>>> -    }
> >>>>>>>>
> >>>>>>>> I think acpi_pci_osc_control_set() still need to query before commit
> >>>>>>>> to ensure all the requested controls are granted to OS.
> >>>>>>>>
> >>>>>>>> So the code needs to be
> >>>>>>>>
> >>>>>>>>      status = acpi_pci_query_osc(root, root->osc_support_set,&control_req);
> >>>>>>>>      if (ACPI_FAILURE(status))
> >>>>>>>>          goto out;
> >>>>>>>
> >>>>
> >>>> Sorry, that should have been
> >>>>
> >>>>     query = control_req;
> >>>>     status = acpi_pci_query_osc(root, root->osc_support_set, &query);
> >>>>     if (ACPI_FAILURE(status))
> >>>>         goto out;
> >>>>     if ((query & control_req) != control_req) {
> >>>>         printk_(KERN_DEBUG
> >>>>             "Firmware did not grant requested _OSC control\n");
> >>>>         status = AE_SUPPORT;
> >>>>         goto out;
> >>>>     }
> >>>>
> >>>> I know current pcie_port_acpi_setup() queries the requesting controls
> >>>> before acpi_pci_osc_control_set() and only one control is requested
> >>>> in the other code. However, I think acpi_pci_osc_control_set() still
> >>>> need to query the requested controls to ensure all the requested
> >>>> controls, in case someone calls this function without querying the
> >>>> requesting controls. In other words, I think it must be ensured that
> >>>> any controls are never granted to OS when acpi_pci_osc_control_set()
> >>>> returns error.
> >>>
> >>> I think the following patch is what you mean.
> >>>
> >>> And... (Continue to next post)
> >>>
> >>> Thanks,
> >>> H.Seto
> >>
> >> OK, I'll repalce my 7/8 with the patch below.
> > 
> > Actually, having reconsidered that, I don't think this approach is valid.
> > 
> > First, it has the problem that if acpi_pci_osc_control_set() returns error
> > code, the caller doesn't really know whether the query failed, or the final
> > request failed.  Arguably, it won't matter for the majority of callers, but
> > some of them might be interested in knowing that in principle.
> 
> Ugh... there are only 2 callers now and both of them are in the majority.
> I don't think it is a time to take care of an invisible minority who might
> require acpi_pci_osc_raw() to complete its work.
> 
> > 
> > Second, the callers that call acpi_pci_osc_control_query() before
> > acpi_pci_osc_control_set() don't need the additional query inside
> > of acpi_pci_osc_control_set().
> 
> So we can recommend all of callers not to call acpi_pci_osc_control_query()
> before acpi_pci_osc_control_set().

Please consider pcie_port_acpi_setup() in [4/8].

It has to do the query by itself, because it may not request the controls
_even_ _if_ _the_ _query_ _is_ _successful_.  Namely, if the result of the
query is that the BIOS won't let us control the PCIe Capability Structure,
pcie_port_acpi_setup() should return error code instead of requesting control
of the other features.  Now, if you put the query into
acpi_pci_osc_control_set(), it won't be able to recognize this corner case and
handle it correctly.

> I suppose that almost all of "the majority" just want to set fixed set of
> controls and they will just return error when fails anyway.
> 
> > 
> > Therefore I'd prefer to have two separate functions, one for querying and the
> > other for requesting control.  Then, we can provide a helper that calls the
> > both of them for the callers of acpi_pci_osc_control_set() that don't need
> > to call acpi_pci_osc_control_query() directly by themselves.
> 
> I'm afraid the "two" is not enough for the minority.
> 
> Therefore I don't think it is a time to prepare for such an inexistent
> minor usage.

As explained above, I think there is a reason to do that, because
pcie_port_acpi_setup() has to run a query anyway.

> > Given that acpi_pci_osc_control_query() is introduced by
> > https://patchwork.kernel.org/patch/117176/ , the helper may be implemented
> > like in the appended patch.
> > 
> > After that patch, the $subject patch can be applied without any modifications
> > to remove the no-longer-used fields in struct acpi_pci_root.
> > 
> > ---
> > From: Rafael J. Wysocki <rjw@sisk.pl>
> > Subject: ACPI / PCI: Introduce function for requesting _OSC controls safely
> > 
> > Calling raw acpi_pci_osc_control_set() is generally unsafe, because
> > it may return error code even if control of some requested features
> > have been granted by the BIOS.  For this reason the callers of
> > acpi_pci_osc_control_set() should call acpi_pci_osc_control_query()
> > before it to make sure that the BIOS is willing to grant control of
> > the requested features.
> > 
> > Introduce helper function acpi_pci_osc_control_set_safe() allowing
> > a caller of acpi_pci_osc_control_set() who is not interested in
> > the control bits returned by acpi_pci_osc_control_query() to
> > request control of _OSC features in a safe way.
> > 
> > Make acpi_get_hp_hw_control_from_firmware() use the new function.
> > 
> > Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> > ---
> >  drivers/acpi/pci_root.c          |   24 ++++++++++++++++++++++++
> >  drivers/pci/hotplug/acpi_pcihp.c |    2 +-
> >  include/linux/acpi.h             |    1 +
> >  3 files changed, 26 insertions(+), 1 deletion(-)
> > 
> > Index: linux-2.6/drivers/acpi/pci_root.c
> > ===================================================================
> > --- linux-2.6.orig/drivers/acpi/pci_root.c
> > +++ linux-2.6/drivers/acpi/pci_root.c
> > @@ -472,6 +472,30 @@ out:
> >  }
> >  EXPORT_SYMBOL(acpi_pci_osc_control_set);
> >  
> > +/**
> > + * acpi_pci_osc_control_set_safe - Query and set _OSC control bit mask.
> > + * @handle: ACPI handle of a PCI root bridge (or PCIe Root Complex).
> > + * @flags: Mask of _OSC bits to query and set.
> > + *
> > + * Check if the BIOS is willing to grant control of the features represented
> > + * by @flags and request control of these features from it.
> > + **/
> > +acpi_status acpi_pci_osc_control_set_safe(acpi_handle handle, u32 flags)
> > +{
> > +	acpi_status status;
> > +	u32 ctrl = flags;
> > +
> > +	status = acpi_pci_osc_control_query(handle, &flags);
> > +	if (ACPI_FAILURE(status))
> > +		return status;
> > +	if ((ctrl & flags) != ctrl)
> > +		return AE_SUPPORT;
> > +
> > +	status = acpi_pci_osc_control_set(handle, flags);
> > +	return status;
> > +}
> > +EXPORT_SYMBOL(acpi_pci_osc_control_set_safe);
> > +
> >  static int __devinit acpi_pci_root_add(struct acpi_device *device)
> >  {
> >  	unsigned long long segment, bus;
> > Index: linux-2.6/drivers/pci/hotplug/acpi_pcihp.c
> > ===================================================================
> > --- linux-2.6.orig/drivers/pci/hotplug/acpi_pcihp.c
> > +++ linux-2.6/drivers/pci/hotplug/acpi_pcihp.c
> > @@ -358,7 +358,7 @@ int acpi_get_hp_hw_control_from_firmware
> >  		acpi_get_name(handle, ACPI_FULL_PATHNAME, &string);
> >  		dbg("Trying to get hotplug control for %s\n",
> >  				(char *)string.pointer);
> > -		status = acpi_pci_osc_control_set(handle, flags);
> > +		status = acpi_pci_osc_control_set_safe(handle, flags);
> >  		if (ACPI_SUCCESS(status))
> >  			goto got_one;
> >  		if (status == AE_SUPPORT)
> > Index: linux-2.6/include/linux/acpi.h
> > ===================================================================
> > --- linux-2.6.orig/include/linux/acpi.h
> > +++ linux-2.6/include/linux/acpi.h
> > @@ -307,6 +307,7 @@ acpi_status acpi_run_osc(acpi_handle han
> >  
> >  extern acpi_status acpi_pci_osc_control_query(acpi_handle handle, u32 *mask);
> >  extern acpi_status acpi_pci_osc_control_set(acpi_handle handle, u32 flags);
> > +extern acpi_status acpi_pci_osc_control_set_safe(acpi_handle handle, u32 flags);
> >  extern void acpi_early_init(void);
> >  
> >  #else	/* !CONFIG_ACPI */
> > 
> > 
> 
> So I'd like to say NAK against this patch, sorry.

IMHO you've not given a sufficient reason for that.

Thanks,
Rafael
