From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFC PATCH] PM / hibernate: make sure each resuming page is in current memory zones
Date: Wed, 22 Jul 2015 03:03:30 +0200
Message-ID: <2662645.fpATfiHLLF@vostro.rjw.lan>
References: <1435679668-13806-1-git-send-email-yu.c.chen@intel.com> <1613617.2K941pjbyO@vostro.rjw.lan> <55ADA040.7050408@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:53816 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S933999AbbGVAgp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 21 Jul 2015 20:36:45 -0400
In-Reply-To: <55ADA040.7050408@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: chenyu5 <yu.c.chen@intel.com>
Cc: linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com, joeyli <jlee@suse.com>, yex.tian@intel.com

On Tuesday, July 21, 2015 09:28:32 AM chenyu5 wrote:
> On 2015=E5=B9=B407=E6=9C=8816=E6=97=A5 08:30, Rafael J. Wysocki wrote=
:
> > On Monday, July 06, 2015 04:37:39 PM joeyli wrote:
> >> Hi Chen Yu,
> >>
> >> On Thu, Jul 02, 2015 at 04:00:42PM +0800, chenyu5 wrote:
> >>> Hi, Joey
> >>> thanks for your reply,
> >>>
> >>> On 2015=E5=B9=B407=E6=9C=8802=E6=97=A5 14:19, joeyli wrote:
> >>>> Hi Chen Yu,
> >>>>
> >>>> On Tue, Jun 30, 2015 at 11:54:28PM +0800, Chen Yu wrote:
> >>>>> Commit 84c91b7ae07c ("PM / hibernate: avoid unsafe pages in e82=
0 reserved
> >>>>> regions") was reverted, because this patch makes resume from hi=
bernation
> >>>>> on Lenovo x230 unreliable. But reverting may bring back the ker=
nel
> >>>>> exception firstly reported in former patch. In general, there a=
re three
> >>>>> problems in current code when resuming from hibernation:
> >>>>>
> >>>>> 1.Resuming page may also be in second kernel's e820 reserved re=
gion.
> >>>>> BIOS-e820: [mem 0x0000000069d4f000-0x0000000069e12fff] reserved
> >>>>> this causes kernel exception described in Commit 84c91b7ae07c
> >>>>> ("PM / hibernate: avoid unsafe pages in e820 reserved regions")
> >>>>>
> >>>>> 2.If Commit 84c91b7ae07c ("PM / hibernate: avoid unsafe pages i=
n e820
> >>>>> reserved regions") is applied to fix problem 1, and if E820_RES=
ERVED_KERN
> >>>>> regions causes some regions at e820 table not page aligned,
> >>>>> e820_mark_nosave_regions will misjudgment the non-page aligned =
space to
> >>>>> be "hole" space and add to nosave regions, this causes resuming=
 failed.
> >>>>> Refer to https://bugzilla.kernel.org/show_bug.cgi?id=3D96111 fo=
r detail.
> >>>>>
> >>>>
> >>>> Sorry for I am not fully understand why checking pfn_valid could=
 avoid
> >>>> the above 2. issue?
> >>>>
> >>> [Yu] According to e820_mark_nosave_regions, two kinds of e820
> >>> regions will be regarded as nosave:
> >>> a.e820.map holes between each e820entry
> >>> b.e820entry with (!E820_RAM && !E820_RESERVED_KERN)
> >>> dmesg in
> >>> https://bugzilla.kernel.org/show_bug.cgi?id=3D96111
> >>> shows that:
> >>>
> >>> BIOS-e820: [mem 0x000000005baff000-0x00000000d684ffff] usable
> >>> reserve setup_data: [mem 0x000000009d3e0018-0x000000009d3f0057] u=
sable
> >>> PM: Registered nosave memory: [mem 0x9d3e0000-0x9d3e0fff]
> >>>
> >>> e820 map was changed by situation a, but it should not be added t=
o
> >>> nosave list, right?
> >>>
> >>> and according to saveable_page, only pages in the zone will be sa=
ved:
> >>> if (page_zone(page_ !=3D zone)
> >>> 	return NULL;
> >>>
> >>> The function of is_valid_orig_page in this patch treats setup_dat=
a as
> >>> valid page, so I think this workaround issue 2.
> >>>
> >>>
> >>>> Per my understood should waiting Yinghai Lu's patches for killin=
g
> >>>> E820_RESERVED_KERN to avoid the aligned problem.
> >>> [Yu] yes, it is a graceful solution, but I don't see that in 4.1?=
 And
> >>> we encountered problem 3 in our testing enviroment, so I wrote a =
patch
> >>> to deal with it first.
> >>>>
> >>>>
> >>>> Thanks a lot!
> >>>> Joey Lee
> >>>>
> >>
> >> Thanks for your explanation, then your patch makes sense to me.
> >>
> >> Please feel free to add tag:
> >>
> >> Reviewed-by: Lee, Chun-Yi <joeyli.kernel@gmail.com>
> >
> > Patch queued up for 4.3, thanks!
> >
> Hi Rafeal,
> Please help drop this patch for now, QA has
> found some problems with this patch applied,
> we're working on it now. Sorry for inconvenience.

Dropping, thanks for the heads up!


--=20
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
