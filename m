From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [regression,bisected] restore of disks after suspend-to-disk
 broken in 3.9.x
Date: Fri, 21 Jun 2013 20:19:07 +0800
Message-ID: <1371817147.2170.8.camel@rzhang1-mobl4>
References: <CAPm-kmsTNz4niGXsWyhLwwBkQ48gHdq1vjPvSKKwQ0kbhHm=JQ@mail.gmail.com>
	 <1369631226.2159.5.camel@rzhang1-mobl4>
	 <CAPm-kmu4WmAKX4N5GTsG-J+oq95pLxB9=iLMf2dyK-p6RbwFXQ@mail.gmail.com>
	 <1369878386.3368.16.camel@rzhang1-mobl4>
	 <CAPm-kmtwxgDO24UmtmZ44-P2W-80tK11k1aE8M4Ty3t3LKu14Q@mail.gmail.com>
	 <1369911036.2636.5.camel@rzhang1-mobl4>
	 <CAPm-kmtdxjf1J0GUSMo+x1XY0BX7hFBsDQCjuAH=f65TfGHRbQ@mail.gmail.com>
	 <CAPm-kmupuP-MKU5xQuReEagNz1EFzWyzjs1vPhKQYOkxg96_uA@mail.gmail.com>
	 <744357E9AAD1214791ACBA4B0B9092630111E53C@SHSMSX101.ccr.corp.intel.com>
	 <1371801239.2170.2.camel@rzhang1-mobl4>
	 <CAPm-kmsEx_xfneSa4=eBhfY-JvHG2AzyD3vcBXra7nWJT7K_-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:65027 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161172Ab3FUMTM (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 21 Jun 2013 08:19:12 -0400
In-Reply-To: <CAPm-kmsEx_xfneSa4=eBhfY-JvHG2AzyD3vcBXra7nWJT7K_-w@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Giacomo Perale <giacomo.perale@gmail.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>

On Fri, 2013-06-21 at 11:51 +0200, Giacomo Perale wrote:
> 2013/6/21 Zhang Rui <rui.zhang@intel.com>:
> > On Wed, 2013-06-05 at 13:23 +0000, Zhang, Rui wrote:
> >>
> >> > -----Original Message-----
> >> > From: Giacomo Perale [mailto:giacomo.perale@gmail.com]
> >> > Sent: Wednesday, June 05, 2013 5:09 PM
> >> > To: Zhang, Rui
> >> > Cc: linux-acpi@vger.kernel.org; linux-pm@vger.kernel.org; Rafael J.
> >> > Wysocki
> >> > Subject: Re: [regression,bisected] restore of disks after suspend-to-
> >> > disk broken in 3.9.x
> >> > Importance: High
> >> >
> >> > 2013/5/30 Giacomo Perale <giacomo.perale@gmail.com>:
> >> > > 2013/5/30 Zhang Rui <rui.zhang@intel.com>:
> >> > >> On Thu, 2013-05-30 at 10:04 +0200, Giacomo Perale wrote:
> >> > >>> 2013/5/30 Zhang Rui <rui.zhang@intel.com>:
> >> > >>> > On Mon, 2013-05-27 at 22:07 +0200, Giacomo Perale wrote:
> >> > >>> >> 2013/5/27 Zhang Rui <rui.zhang@intel.com>:
> >> > >>> >> > On Sun, 2013-05-26 at 15:51 +0200, Giacomo Perale wrote:
> >> > >>> >> >> Hello,
> >> > >>> >> >>
> >> > >>> >> >> after upgrading from 3.8.7 to 3.9.x I noticed some slightly
> >> > >>> >> >> longer delays when resuming from suspend-to-disk and a few
> >> > new
> >> > >>> >> >> error messages in the logs:
> >> > >>> >> >>
> >> > >>> >> >>
> >> > >>> >> >> Not having connected the issue with the previous error
> >> > >>> >> >> messages I initially blamed the disk and replaced it with a
> >> > >>> >> >> new one thinking it was broken, but the problem persisted so
> >> > I
> >> > >>> >> >> started a bisection run that pointed to this commit:
> >> > >>> >> >>
> >> > >>> >> >>
> >> > >>> >> > I do not see how this would affect the sata hibernation/resume.
> >> > >>> >> > but anyway, would you please try the four patches in comment
> >> > >>> >> > #10, #11,
> >> > >>> >> > #12 and #13 in
> >> > >>> >> > https://bugzilla.kernel.org/show_bug.cgi?id=58301
> >> > >>> >> > and check if they help?
> >> > >>> >> >
> >> > >>> >> > thanks,
> >> > >>> >> > rui
> >> > >>> >> >
> >> > >>> >>
> >> > >>> >> No luck, with git head and those four patches hibernation is
> >> > >>> >> completely broken, the system doesn't even shut down, it just
> >> > >>> >> loses the disks (I'm attaching what I could get from /proc/kmsg
> >> > >>> >> to this email).
> >> > >>> >>
> >> > >>> > then can you please try the patch at
> >> > >>> > https://patchwork.kernel.org/patch/2633071/
> >> > >>> > on top of the four patches and see if it helps?
> >> > >>> >
> >> > >>> > thanks,
> >> > >>> > rui
> >> > >>> >
> >> > >>>
> >> > >>> Do you mean without Rafael's patch?
> >> > >>>
> >> > >> right.
> >> > >>
> >> > >> thanks,
> >> > >> rui
> >> > >
> >> > > [cc-ing list]
> >> > >
> >> > > No difference, system doesn't shut down and disks become unavailable.
> >> > >
> >> > > Giacomo
> >> >
> >> > Any news about this?
> >> >
> >>
> >> I'm proposing a new patch set based on the problem found by Rafael's patch.
> >> And I'll send them out in a day or two, please wait for the update. :)
> >>
> > sorry for the late response.
> >
> > can you please check if the patch series at
> > https://patchwork.kernel.org/patch/2733361/
> > https://patchwork.kernel.org/patch/2733371/
> > https://patchwork.kernel.org/patch/2733391/
> > https://patchwork.kernel.org/patch/2733401/
> > https://patchwork.kernel.org/patch/2733411/
> > https://patchwork.kernel.org/patch/2733421/
> > helps or not?
> >
> > thanks,
> > rui
> >
> >> Thanks,
> >> rui
> >>
> >>
> >> > Thanks.
> 
> Are those patches already in git head or do I need to apply them separately?
> 
you need to apply them manually on top of clean linus' git tree.

thanks,
rui
> Thanks
> 
> Giacomo


