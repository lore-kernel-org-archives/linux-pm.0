From: joeyli <jlee@suse.com>
Subject: Re: [RFC PATCH] PM / hibernate: make sure each resuming page is in
 current memory zones
Date: Mon, 6 Jul 2015 16:37:39 +0800
Message-ID: <20150706083739.GA29021@linux-rxt1.site>
References: <1435679668-13806-1-git-send-email-yu.c.chen@intel.com>
 <20150702061935.GA19010@linux-rxt1.site>
 <5594EFAA.1000905@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:60112 "EHLO
	smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751454AbbGFIh4 (ORCPT
	<rfc822;groupwise-linux-pm@vger.kernel.org:0:0>);
	Mon, 6 Jul 2015 04:37:56 -0400
Content-Disposition: inline
In-Reply-To: <5594EFAA.1000905@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: chenyu5 <yu.c.chen@intel.com>
Cc: linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com, rui.zhang@intel.com, len.brown@intel.com, aaron.lu@intel.com, ying.huang@intel.com

Hi Chen Yu,=20

On Thu, Jul 02, 2015 at 04:00:42PM +0800, chenyu5 wrote:
> Hi, Joey
> thanks for your reply,
>=20
> On 2015=E5=B9=B407=E6=9C=8802=E6=97=A5 14:19, joeyli wrote:
> >Hi Chen Yu,
> >
> >On Tue, Jun 30, 2015 at 11:54:28PM +0800, Chen Yu wrote:
> >>Commit 84c91b7ae07c ("PM / hibernate: avoid unsafe pages in e820 re=
served
> >>regions") was reverted, because this patch makes resume from hibern=
ation
> >>on Lenovo x230 unreliable. But reverting may bring back the kernel
> >>exception firstly reported in former patch. In general, there are t=
hree
> >>problems in current code when resuming from hibernation:
> >>
> >>1.Resuming page may also be in second kernel's e820 reserved region=
=2E
> >>BIOS-e820: [mem 0x0000000069d4f000-0x0000000069e12fff] reserved
> >>this causes kernel exception described in Commit 84c91b7ae07c
> >>("PM / hibernate: avoid unsafe pages in e820 reserved regions")
> >>
> >>2.If Commit 84c91b7ae07c ("PM / hibernate: avoid unsafe pages in e8=
20
> >>reserved regions") is applied to fix problem 1, and if E820_RESERVE=
D_KERN
> >>regions causes some regions at e820 table not page aligned,
> >>e820_mark_nosave_regions will misjudgment the non-page aligned spac=
e to
> >>be "hole" space and add to nosave regions, this causes resuming fai=
led.
> >>Refer to https://bugzilla.kernel.org/show_bug.cgi?id=3D96111 for de=
tail.
> >>
> >
> >Sorry for I am not fully understand why checking pfn_valid could avo=
id
> >the above 2. issue?
> >
> [Yu] According to e820_mark_nosave_regions, two kinds of e820
> regions will be regarded as nosave:
> a.e820.map holes between each e820entry
> b.e820entry with (!E820_RAM && !E820_RESERVED_KERN)
> dmesg in
> https://bugzilla.kernel.org/show_bug.cgi?id=3D96111
> shows that:
>=20
> BIOS-e820: [mem 0x000000005baff000-0x00000000d684ffff] usable
> reserve setup_data: [mem 0x000000009d3e0018-0x000000009d3f0057] usabl=
e
> PM: Registered nosave memory: [mem 0x9d3e0000-0x9d3e0fff]
>=20
> e820 map was changed by situation a, but it should not be added to
> nosave list, right?
>=20
> and according to saveable_page, only pages in the zone will be saved:
> if (page_zone(page_ !=3D zone)
> 	return NULL;
>=20
> The function of is_valid_orig_page in this patch treats setup_data as
> valid page, so I think this workaround issue 2.
>=20
>=20
> >Per my understood should waiting Yinghai Lu's patches for killing
> >E820_RESERVED_KERN to avoid the aligned problem.
> [Yu] yes, it is a graceful solution, but I don't see that in 4.1? And
> we encountered problem 3 in our testing enviroment, so I wrote a patc=
h
> to deal with it first.
> >
> >
> >Thanks a lot!
> >Joey Lee
> >

Thanks for your explanation, then your patch makes sense to me.

Please feel free to add tag:

Reviewed-by: Lee, Chun-Yi <joeyli.kernel@gmail.com>


Thanks a lot!
Joey Lee

