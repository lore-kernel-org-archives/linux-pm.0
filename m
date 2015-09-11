From: Andreas Dannenberg <dannenberg@ti.com>
Subject: Re: [PATCH v2 13/13] dt: power: bq2425x-charger: Cover additional
 devices
Date: Fri, 11 Sep 2015 09:47:06 -0500
Message-ID: <20150911144704.GA17875@beast>
References: <1441757557-7266-1-git-send-email-dannenberg@ti.com>
 <1441757557-7266-14-git-send-email-dannenberg@ti.com>
 <55EF7CDA.9030505@samsung.com>
 <20150909024841.GB32255@beast>
 <55EFBC61.1050405@samsung.com>
 <20150909201534.GB9887@beast>
 <55F0CB8D.9000507@samsung.com>
 <20150910205701.GA16113@borg>
 <55F22182.9000508@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:42326 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751875AbbIKOrl (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 11 Sep 2015 10:47:41 -0400
Content-Disposition: inline
In-Reply-To: <55F22182.9000508@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Laurentiu Palcu <laurentiu.palcu@intel.com>, Ramakrishna Pallala <ramakrishna.pallala@intel.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org

On Fri, Sep 11, 2015 at 09:34:10AM +0900, Krzysztof Kozlowski wrote:
> On 11.09.2015 05:57, Andreas Dannenberg wrote:
> > On Thu, Sep 10, 2015 at 09:15:09AM +0900, Krzysztof Kozlowski wrote:
> 
> (...)
> 
> > 
> >>>> bq2415x.txt - ti,current-limit  - maximum current to be drawn in mA
> >>>>
> >>>> New bindings:
> >>>> ti,charge-current (bq24261) - default charge current in mA
> >>>> ti,max-charge-current (bq24261) - maximum charging current in mA
> >>>
> >>> This ti,max-charge-current is actually an interesting one. It's not a
> >>> device setting as it does not impact any of the device registers at all.
> >>> Instead, it's an artificial limit that can be set through DT that
> >>> prevents somebody from going into sysfs and configuring a charge current
> >>> higher than ti,max-charge-current. In other drivers I have seen that the
> >>> sysfs property reflecting that max charge current is just read-only and
> >>> gives you the maximum the HW is capable of. From a device point of view
> >>> there is nothing configurable about this property.
> >>
> >> Hmmm, so now I wonder whether this should be a DT binding. The purpose
> >> of DT isn't the control of the driver like enable some stuff, set some
> >> value used by the driver. The DT provides information about hardware so
> >> the driver could properly configure the device and work with it.
> >>
> >> Reason to put this into DT would be:
> >> For example one device configuration (device, board, connected battery)
> >> could handle one maximum value and the other configuration would require
> >> lower one. The device and its capabilities (bq24257 for example) are the
> >> same but configuration changes.
> > 
> > Yes this could be useful in this case but this property only makes sense
> > if userspace is allowed to change the actual charge current through
> > sysfs as some drivers do including Ram's proposed bq24261 driver. But if we
> > get rid of the general sysfs configurability of the charge current
> > (which I say we should) we don't need that ti,max-charge-current property.
> > Also see...
> > 
> > http://marc.info/?l=linux-pm&m=143080413218161&w=2
> 
> Right, that's my previous reply. :) I must admit that here and for
> bq24261 I looked mostly at bindings so I did not initially about the
> sysfs interface.
> 
> Anyway I am not convinced to having such sysfs interfaces and definitely
> they should not mess with DT. I would rather expect these to be totally
> orthogonal.
> 
> Summarizing all these bq24261 properties:
>  - ti,enable-user-write
>  - ti,max-charge-current
>  - ti,max-charge-voltage
> are related to that sysfs interface, not to hardware configuration. If
> that's true, then all should be gone.
> 
> > 
> >> To prevent future issues in naming and bindings consistency maybe there
> >> should be a dedicated maintainer for bq/TI charger devices? Pali Rohar
> >> recently took care for devices related to Nokia N900 but maybe someone
> >> from TI should also take care of rest or all of them (if TI is
> >> interested in this)?
> > 
> > I'd be happy to step in here. Let me know how I can help and contribute.
> 
> I don't know Sebastian's opinion on that idea but I think usually a new
> maintainer and reviewer of particular drivers is welcomed by community.
> I see also Intel's interest and his contributions in these chargers.
> Laurentiu seems to do a thorough review as well. There can be both
> official reviewers.

Hi Krzysztof,
If we already have good coverage then that's great. The value I can add
is that I literally sit in the same building with the "battery charger
people" :) so it's easy to go talk to them to clarify technical details
amongst other things that might come up as drivers are getting
developed/reviewed. So at a minimum folks like Laurentiu should feel
free to reach out to me as needed.

Regards,

--
Andreas Dannenberg
Texas Instruments Inc

 
> It's up to you people. Just make a first step and we'll see how other
> people react (and what Sebastian thinks about it :) ).
> 
> Best regards,
> Krzysztof
> 
