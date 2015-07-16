From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFC PATCH] PM / hibernate: make sure each resuming page is in current memory zones
Date: Thu, 16 Jul 2015 02:30:40 +0200
Message-ID: <1613617.2K941pjbyO@vostro.rjw.lan>
References: <1435679668-13806-1-git-send-email-yu.c.chen@intel.com> <5594EFAA.1000905@intel.com> <20150706083739.GA29021@linux-rxt1.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:47763 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753847AbbGPAEC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 15 Jul 2015 20:04:02 -0400
In-Reply-To: <20150706083739.GA29021@linux-rxt1.site>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: joeyli <jlee@suse.com>
Cc: chenyu5 <yu.c.chen@intel.com>, linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com, rui.zhang@intel.com, len.brown@intel.com, aaron.lu@intel.com, ying.huang@intel.com

On Monday, July 06, 2015 04:37:39 PM joeyli wrote:
> Hi Chen Yu,=20
>=20
> On Thu, Jul 02, 2015 at 04:00:42PM +0800, chenyu5 wrote:
> > Hi, Joey
> > thanks for your reply,
> >=20
> > On 2015=E5=B9=B407=E6=9C=8802=E6=97=A5 14:19, joeyli wrote:
> > >Hi Chen Yu,
> > >
> > >On Tue, Jun 30, 2015 at 11:54:28PM +0800, Chen Yu wrote:
> > >>Commit 84c91b7ae07c ("PM / hibernate: avoid unsafe pages in e820 =
reserved
> > >>regions") was reverted, because this patch makes resume from hibe=
rnation
> > >>on Lenovo x230 unreliable. But reverting may bring back the kerne=
l
> > >>exception firstly reported in former patch. In general, there are=
 three
> > >>problems in current code when resuming from hibernation:
> > >>
> > >>1.Resuming page may also be in second kernel's e820 reserved regi=
on.
> > >>BIOS-e820: [mem 0x0000000069d4f000-0x0000000069e12fff] reserved
> > >>this causes kernel exception described in Commit 84c91b7ae07c
> > >>("PM / hibernate: avoid unsafe pages in e820 reserved regions")
> > >>
> > >>2.If Commit 84c91b7ae07c ("PM / hibernate: avoid unsafe pages in =
e820
> > >>reserved regions") is applied to fix problem 1, and if E820_RESER=
VED_KERN
> > >>regions causes some regions at e820 table not page aligned,
> > >>e820_mark_nosave_regions will misjudgment the non-page aligned sp=
ace to
> > >>be "hole" space and add to nosave regions, this causes resuming f=
ailed.
> > >>Refer to https://bugzilla.kernel.org/show_bug.cgi?id=3D96111 for =
detail.
> > >>
> > >
> > >Sorry for I am not fully understand why checking pfn_valid could a=
void
> > >the above 2. issue?
> > >
> > [Yu] According to e820_mark_nosave_regions, two kinds of e820
> > regions will be regarded as nosave:
> > a.e820.map holes between each e820entry
> > b.e820entry with (!E820_RAM && !E820_RESERVED_KERN)
> > dmesg in
> > https://bugzilla.kernel.org/show_bug.cgi?id=3D96111
> > shows that:
> >=20
> > BIOS-e820: [mem 0x000000005baff000-0x00000000d684ffff] usable
> > reserve setup_data: [mem 0x000000009d3e0018-0x000000009d3f0057] usa=
ble
> > PM: Registered nosave memory: [mem 0x9d3e0000-0x9d3e0fff]
> >=20
> > e820 map was changed by situation a, but it should not be added to
> > nosave list, right?
> >=20
> > and according to saveable_page, only pages in the zone will be save=
d:
> > if (page_zone(page_ !=3D zone)
> > 	return NULL;
> >=20
> > The function of is_valid_orig_page in this patch treats setup_data =
as
> > valid page, so I think this workaround issue 2.
> >=20
> >=20
> > >Per my understood should waiting Yinghai Lu's patches for killing
> > >E820_RESERVED_KERN to avoid the aligned problem.
> > [Yu] yes, it is a graceful solution, but I don't see that in 4.1? A=
nd
> > we encountered problem 3 in our testing enviroment, so I wrote a pa=
tch
> > to deal with it first.
> > >
> > >
> > >Thanks a lot!
> > >Joey Lee
> > >
>=20
> Thanks for your explanation, then your patch makes sense to me.
>=20
> Please feel free to add tag:
>=20
> Reviewed-by: Lee, Chun-Yi <joeyli.kernel@gmail.com>

Patch queued up for 4.3, thanks!


--=20
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
