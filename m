From: Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [PATCH v3 0/5] bq27xxx_battery data memory update
Date: Tue, 5 Sep 2017 22:14:49 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1709052214030.2058@hadrien>
References: <20170824033617.20840-1-liam@networkimprov.net> <20170829105413.6wbejdaxxxd6hk7b@earth> <0bf4ba2f-18f9-1204-8241-8acb6ac6f490@ti.com> <20170829212259.gs4bljwscrprsfjl@earth> <CAKvHMgTEe_xBP2ENMTU5BNwWaRjfqbAuRJC32sHYL_Mh5oJOsQ@mail.gmail.com>
 <20170830002939.ns43wldvffmwqhuv@earth> <CAKvHMgSyr8aZ1cVd-Zf6WHNkwyTcSBvRaVuDWuHEnuNM=MStUA@mail.gmail.com> <alpine.DEB.2.20.1708311150440.3243@hadrien> <CAKvHMgSkuzi_BuicT7edYrM8Q87pnPJcgHRMDJEB21wdNKf8ow@mail.gmail.com> <alpine.DEB.2.20.1708311330570.3243@hadrien>
 <CAKvHMgSKLJk2wB9pefYuGyMG2aNp7bCCaOMABGRxXZ9ju-ivHw@mail.gmail.com> <CAKvHMgRzFpueUccSL1iu_-EazCe76cF8iSAPyYgcxJ3dNOZejA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:37977
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752017AbdIEUOw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 5 Sep 2017 16:14:52 -0400
In-Reply-To: <CAKvHMgRzFpueUccSL1iu_-EazCe76cF8iSAPyYgcxJ3dNOZejA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Liam Breck <liam@networkimprov.net>
Cc: Julia Lawall <julia.lawall@lip6.fr>, Sebastian Reichel <sebastian.reichel@collabora.co.uk>, Gilles Muller <Gilles.Muller@lip6.fr>, Nicolas Palix <nicolas.palix@imag.fr>, Michal Marek <mmarek@suse.com>, cocci@systeme.lip6.fr, "Andrew F. Davis" <afd@ti.com>, =?ISO-8859-15?Q?Pali_Roh=E1r?= <pali.rohar@gmail.com>, Linux PM mailing list <linux-pm@vger.kernel.org>



On Tue, 5 Sep 2017, Liam Breck wrote:

> Hi Julia, any luck on this?

I was trying to improve the parser, but it seems that my improvements
don't have a sufficient effect so I will try your suggestion of just
seding out the offending code.

julia

>
> On Thu, Aug 31, 2017 at 4:43 AM, Liam Breck <liam@networkimprov.net> wrote:
> > On Thu, Aug 31, 2017 at 4:33 AM, Julia Lawall <julia.lawall@lip6.fr> wrote:
> >>
> >>
> >> On Thu, 31 Aug 2017, Liam Breck wrote:
> >>
> >>> On Thu, Aug 31, 2017 at 2:54 AM, Julia Lawall <julia.lawall@lip6.fr> wrote:
> >>> >
> >>> >
> >>> > On Tue, 29 Aug 2017, Liam Breck wrote:
> >>> >
> >>> >> Coccinelle folks,
> >>> >>
> >>> >> On Tue, Aug 29, 2017 at 5:29 PM, Sebastian Reichel
> >>> >> <sebastian.reichel@collabora.co.uk> wrote:
> >>> >> > Hi,
> >>> >> >
> >>> >> > On Tue, Aug 29, 2017 at 04:07:12PM -0700, Liam Breck wrote:
> >>> >> >> I don't see a Julia in CC list...
> >>> >> >
> >>> >> > <_< let's try that again.
> >>> >> >
> >>> >> >> On Tue, Aug 29, 2017 at 2:22 PM, Sebastian Reichel
> >>> >> >> <sebastian.reichel@collabora.co.uk> wrote:
> >>> >> >> > [adding Julia to Cc for Coccinelle question]
> >>> >> >> >
> >>> >> >> > Hi,
> >>> >> >> >
> >>> >> >> > On Tue, Aug 29, 2017 at 10:31:57AM -0500, Andrew F. Davis wrote:
> >>> >> >> >> On 08/29/2017 05:54 AM, Sebastian Reichel wrote:
> >>> >> >> >> > On Wed, Aug 23, 2017 at 08:36:12PM -0700, Liam Breck wrote:
> >>> >> >> >> >> Overview:
> >>> >> >> >> >> * Reorganizes chip data definitions
> >>> >> >> >> >> * Enables features landed in these patches:
> >>> >> >> >> >>   dt-bindings: power: supply: bq27xxx: Add monitored-battery documentation
> >>> >> >> >> >>   power: supply: bq27xxx: Add chip data memory read/write support
> >>> >> >> >> >>   power: supply: bq27xxx: Add power_supply_battery_info support
> >>> >> >> >> >> * Supports the following chips (only BQ27425 is active)
> >>> >> >> >> >>   BQ27500, 545, 425, 421, 441, 621
> >>> >> >> >> >>
> >>> >> >> >> >> Changes in v3:
> >>> >> >> >> >> * BQ27425 tested; workaround minor chip bug
> >>> >> >> >> >> * Dropped driver_version
> >>> >> >> >> >> * Fixed dbg_dupes logic for .props & .dm_regs
> >>> >> >> >> >> * Dropped two props array dupes
> >>> >> >> >> >>
> >>> >> >> >> >> Changes in v2:
> >>> >> >> >> >> * Added di->opts flags for remaining chip features
> >>> >> >> >> >> * Commented out untested bq27xxx_dm_regs parameters
> >>> >> >> >> >> * Changed dbg_dupes to run only once
> >>> >> >> >> >>
> >>> >> >> >> >> Notes on v1:
> >>> >> >> >> >> * Not fully tested (hence RFC tag)
> >>> >> >> >> >
> >>> >> >> >> > Thanks, full series queued.
> >>> >> >> >> >
> >>> >> >> >> > -- Sebastian
> >>> >> >> >>
> >>> >> >> >> Anyway, I've not got the time to fight these changes anymore, but at
> >>> >> >> >> very least could you drop 4/5, it's static analysis code made into a
> >>> >> >> >> runtime check built into a kernel driver, if not at least add my
> >>> >> >> >> nacked-by. :)
> >>> >> >> >
> >>> >> >> > Since it's not critical at all and nobody depends on it, I dropped 4/5
> >>> >> >> > for now. I agree, that checking it at runtime is not nice. On the other
> >>> >> >> > hand I do think a duplication check makes sense. Doing a static
> >>> >> >> > check should be possible, but I have no idea how to implement this
> >>> >> >> > (without much effort). I suspect Coccinelle can do it, so I added
> >>> >> >> > Julia.
> >>> >> >> >
> >>> >> >> > For reference this is the runtime check:
> >>> >> >> > https://patchwork.kernel.org/patch/9918953/
> >>> >>
> >>> >> The data structures being checked start here:
> >>> >> https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git/tree/drivers/power/supply/bq27xxx_battery.c?h=for-next#n138
> >>> >>
> >>> >> And are aggregated here:
> >>> >> https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git/tree/drivers/power/supply/bq27xxx_battery.c?h=for-next#n743
> >>> >
> >>> > I worked a bit on this, but unfortunately there is a major parsing
> >>> > problem, and most of the definitions are ignored.  Specifically, the
> >>> > definitions of the regs variables are interspersed with eg:
> >>> >
> >>> > #define bq27510g1_regs bq27500_regs
> >>>
> >>> You can transform the macros with sed to either of:
> >>>
> >>> static u8 *bq27510g1_regs = 0 // skip comparison if x == 0
> >>>
> >>> static u8 bq27510g1_regs[BQ27XXX_REG_MAX] = { 0xFF } // skip
> >>> comparison if x[0] == 0xff
> >>>
> >>> Does that help?
> >>
> >> Not quite, because it's really a list of variable declarations, like
> >>
> >> int a, b, c, d;
> >>
> >> The following could be fine:
> >>
> >> *bq27510g1_regs = 0,
> >
> > i forgot about the static u8 at the top of the array set. But yes,
> > just drop static u8 from either of the alternatives I gave.
>
