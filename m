From: joeyli <jlee@suse.com>
Subject: Re: [RFC PATCH] PM / hibernate: make sure each resuming page is in
 current memory zones
Date: Thu, 23 Jul 2015 13:34:32 +0800
Message-ID: <20150723053432.GI23137@linux-rxt1.site>
References: <1435679668-13806-1-git-send-email-yu.c.chen@intel.com>
 <1613617.2K941pjbyO@vostro.rjw.lan>
 <55ADA040.7050408@intel.com>
 <2662645.fpATfiHLLF@vostro.rjw.lan>
 <36DF59CE26D8EE47B0655C516E9CE6402FC8C2@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:38993 "EHLO
	smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750771AbbGWFeo (ORCPT
	<rfc822;groupwise-linux-pm@vger.kernel.org:0:0>);
	Thu, 23 Jul 2015 01:34:44 -0400
Content-Disposition: inline
In-Reply-To: <36DF59CE26D8EE47B0655C516E9CE6402FC8C2@SHSMSX101.ccr.corp.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Chen, Yu C" <yu.c.chen@intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Tian, YeX" <yex.tian@intel.com>

Hi Chen Yu,

On Wed, Jul 22, 2015 at 08:58:11AM +0000, Chen, Yu C wrote:
>=20
>=20
> > -----Original Message-----
> > From: Rafael J. Wysocki [mailto:rjw@rjwysocki.net]
> > Sent: Wednesday, July 22, 2015 9:04 AM
> > To: Chen, Yu C
> > Cc: linux-pm@vger.kernel.org; Wysocki, Rafael J; joeyli; Tian, YeX
> > Subject: Re: [RFC PATCH] PM / hibernate: make sure each resuming pa=
ge is
> > in current memory zones
> >=20
> > On Tuesday, July 21, 2015 09:28:32 AM chenyu5 wrote:
> > > On 2015=E5=B9=B407=E6=9C=8816=E6=97=A5 08:30, Rafael J. Wysocki w=
rote:
> > > > On Monday, July 06, 2015 04:37:39 PM joeyli wrote:
> > > >> Hi Chen Yu,
> > > >>
> > > >> On Thu, Jul 02, 2015 at 04:00:42PM +0800, chenyu5 wrote:
> > > >>> Hi, Joey
> > > >>> thanks for your reply,
> > > >>>
> > > >>> On 2015=E5=B9=B407=E6=9C=8802=E6=97=A5 14:19, joeyli wrote:
> > > >>>> Hi Chen Yu,
> > > >>>>
> > > >>>> On Tue, Jun 30, 2015 at 11:54:28PM +0800, Chen Yu wrote:
> > > >>>>> Commit 84c91b7ae07c ("PM / hibernate: avoid unsafe pages in=
 e820
> > > >>>>> reserved
> > > >>>>> regions") was reverted, because this patch makes resume fro=
m
> > > >>>>> hibernation on Lenovo x230 unreliable. But reverting may br=
ing
> > > >>>>> back the kernel exception firstly reported in former patch.=
 In
> > > >>>>> general, there are three problems in current code when resu=
ming
> > from hibernation:
> > > >>>>>
> > > >>>>> 1.Resuming page may also be in second kernel's e820 reserve=
d
> > region.
> > > >>>>> BIOS-e820: [mem 0x0000000069d4f000-0x0000000069e12fff]
> > reserved
> > > >>>>> this causes kernel exception described in Commit 84c91b7ae0=
7c
> > > >>>>> ("PM / hibernate: avoid unsafe pages in e820 reserved regio=
ns")
> > > >>>>>
> > > >>>>> 2.If Commit 84c91b7ae07c ("PM / hibernate: avoid unsafe pag=
es in
> > > >>>>> e820 reserved regions") is applied to fix problem 1, and if
> > > >>>>> E820_RESERVED_KERN regions causes some regions at e820 tabl=
e
> > not
> > > >>>>> page aligned, e820_mark_nosave_regions will misjudgment the
> > > >>>>> non-page aligned space to be "hole" space and add to nosave
> > regions, this causes resuming failed.
> > > >>>>> Refer to https://bugzilla.kernel.org/show_bug.cgi?id=3D9611=
1 for
> > detail.
> > > >>>>>
> > > >>>>
> > > >>>> Sorry for I am not fully understand why checking pfn_valid c=
ould
> > > >>>> avoid the above 2. issue?
> > > >>>>
> > > >>> [Yu] According to e820_mark_nosave_regions, two kinds of e820
> > > >>> regions will be regarded as nosave:
> > > >>> a.e820.map holes between each e820entry b.e820entry with
> > > >>> (!E820_RAM && !E820_RESERVED_KERN) dmesg in
> > > >>> https://bugzilla.kernel.org/show_bug.cgi?id=3D96111
> > > >>> shows that:
> > > >>>
> > > >>> BIOS-e820: [mem 0x000000005baff000-0x00000000d684ffff] usable
> > > >>> reserve setup_data: [mem 0x000000009d3e0018-0x000000009d3f005=
7]
> > > >>> usable
> > > >>> PM: Registered nosave memory: [mem 0x9d3e0000-0x9d3e0fff]
> > > >>>
> > > >>> e820 map was changed by situation a, but it should not be add=
ed to
> > > >>> nosave list, right?
> > > >>>
> > > >>> and according to saveable_page, only pages in the zone will b=
e saved:
> > > >>> if (page_zone(page_ !=3D zone)
> > > >>> 	return NULL;
> > > >>>
> > > >>> The function of is_valid_orig_page in this patch treats setup=
_data
> > > >>> as valid page, so I think this workaround issue 2.
> > > >>>
> > > >>>
> > > >>>> Per my understood should waiting Yinghai Lu's patches for ki=
lling
> > > >>>> E820_RESERVED_KERN to avoid the aligned problem.
> > > >>> [Yu] yes, it is a graceful solution, but I don't see that in =
4.1?
> > > >>> And we encountered problem 3 in our testing enviroment, so I =
wrote
> > > >>> a patch to deal with it first.
> > > >>>>
> > > >>>>
> > > >>>> Thanks a lot!
> > > >>>> Joey Lee
> > > >>>>
> > > >>
> > > >> Thanks for your explanation, then your patch makes sense to me=
=2E
> > > >>
> > > >> Please feel free to add tag:
> > > >>
> > > >> Reviewed-by: Lee, Chun-Yi <joeyli.kernel@gmail.com>
> > > >
> > > > Patch queued up for 4.3, thanks!
> > > >
> > > Hi Rafeal,
> > > Please help drop this patch for now, QA has found some problems w=
ith
> > > this patch applied, we're working on it now. Sorry for inconvenie=
nce.
> >=20
> > Dropping, thanks for the heads up!
> >=20
> Hi,Rafeal, Joey
> I've sent out another patch, it is based on Joey's=20
> original patch, and it treats any adjacent E820_RAM/E820_RESERVED_KER=
N regions as
> one. In this way,  non-page-aligned setup_data address would not be a=
dded=20
> to nosave regions, thus workaround the hibernation failor mentiones i=
n
> https://bugzilla.kernel.org/show_bug.cgi?id=3D96111
>=20
> V1 patch has a problem that, NOT every page in page zone has a valid =
mapping address , thus
> accessing these pages would cause problem. So I rewrite this path and=
 send out another V2 version.
> Thanks for your time.
>=20
>  Yu
> >

Thanks for your work on this patch, but the E820_RESERVED_KERN will be =
removed
anyhow. So I prefer waiting Yinghai Lu's patch for killing E820_RESERVE=
D_KERN.


Regards
Joey Lee=20
