From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] PM / Qos: Ensure device not in PRM_SUSPENDED when pm qos flags request functions are invoked in the pm core.
Date: Sun, 11 Nov 2012 15:43:03 +0100
Message-ID: <2605346.OH2s8ljTr5@vostro.rjw.lan>
References: <1351843430-8023-1-git-send-email-tianyu.lan@intel.com> <5096852C.3000707@intel.com> <509F9550.70508@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <509F9550.70508@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Lan Tianyu <tianyu.lan@intel.com>
Cc: stern@rowland.harvard.edu, linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Sunday, November 11, 2012 08:08:48 PM Lan Tianyu wrote:
> On 2012/11/4 23:09, Lan Tianyu wrote:
> > On 2012/11/3 4:11, Rafael J. Wysocki wrote:
> >>>>>    }
> >>>>> > >>   EXPORT_SYMBOL_GPL(dev_pm_qos_expose_flags);
> >>>>> > >>@@ -645,7 +649,9 @@ void dev_pm_qos_hide_flags(struct device *dev)
> >>>>> > >>   {
> >>>>> > >>       if (dev->power.qos && dev->power.qos->flags_req) {
> >>>>> > >>           pm_qos_sysfs_remove_flags(dev);
> >>>>> > >>+        pm_runtime_get_sync(dev);
> >>>>> > >>           __dev_pm_qos_drop_user_request(dev, DEV_PM_QOS_FLAGS);
> >>>>> > >>+        pm_runtime_put(dev);
> >>>> > >
> >>>> > >I'm not sure if these two are necessary.  If we remove a request,
> >>>> > >then what happens worst case is that some flags will be cleared
> >>>> > >effectively which means fewer restrictions on the next sleep state.
> >>>> > >Then, it shouldn't hurt that the current sleep state is more
> >>>> > >restricted.
> >>> >
> >>> >But this mean the device can be put into lower power state(power off).
> >>> >So why not do that? that can save more power, right?
> >> Correct.  On the other hand, though, if the device already is in the
> >> deepest low-power state available, we will resume it unnecessarily this
> >> way.  Which may not be a big deal, however, and since we do that in other
> >> cases, we may as well do it here.
> > Yeah. This seems not very reasonable. But we can optimize this
> > later.From my previous opinion, add notifier for flags and let device
> > driver or bus driver to determine when the device should be resumed.
> > Since you said at another email you would remove all notifiers in the pm
> > qos to make some functions able to be invoked in interrupt context. I
> > have a thought that check the context before call notifiers chain. If it
> > was in interrupt, not call notifier chain and trigger a work queue or
> > other choices to do that. If not, call the chain. Does this make sense? :)
> >
> Hi Rafael:
> 	Do you have some opinions?

First off, I've applied the last version of this patch. :-)

Second, I don't think we need notifiers at all in the case of device PM QoS
and, moreover, we'd actually be better off without them.

There generally are two reasons for the notifiers in that case.  One reason
is to prevent devices from sleeping too long if they were suspended before
a new PM QoS request has been added (or an existing one has been updated).
The second reason is to allow things like PM domains to recompute their
numbers taking the new request into account.

Now, if whoever modifies/adds PM QoS requests for certain device ensures
that the device is not RPM_SUSPENDED while the PM QoS constraints are
changing, that makes the first reason go away.  The second reason may be
taken care of by changing the PM core to set a (new) flag whenever PM QoS
constraints for a device change, so that whoever cares can take that into
account while the device is suspended next time.  This way all of the
additional computations will only need to happen when devices are suspended
and the code flow will be much easier to follow.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
