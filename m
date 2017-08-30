From: Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [PATCH v3 0/5] bq27xxx_battery data memory update
Date: Wed, 30 Aug 2017 08:01:05 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1708300800360.2152@hadrien>
References: <20170824033617.20840-1-liam@networkimprov.net>
 <20170829105413.6wbejdaxxxd6hk7b@earth>
 <0bf4ba2f-18f9-1204-8241-8acb6ac6f490@ti.com>
 <20170829212259.gs4bljwscrprsfjl@earth>
 <CAKvHMgTEe_xBP2ENMTU5BNwWaRjfqbAuRJC32sHYL_Mh5oJOsQ@mail.gmail.com>
 <20170830002939.ns43wldvffmwqhuv@earth>
 <CAKvHMgSyr8aZ1cVd-Zf6WHNkwyTcSBvRaVuDWuHEnuNM=MStUA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <cocci-bounces@systeme.lip6.fr>
In-Reply-To: <CAKvHMgSyr8aZ1cVd-Zf6WHNkwyTcSBvRaVuDWuHEnuNM=MStUA@mail.gmail.com>
List-Unsubscribe: <https://systeme.lip6.fr/mailman/options/cocci>,
 <mailto:cocci-request@systeme.lip6.fr?subject=unsubscribe>
List-Archive: <https://systeme.lip6.fr/pipermail/cocci>
List-Post: <mailto:cocci@systeme.lip6.fr>
List-Help: <mailto:cocci-request@systeme.lip6.fr?subject=help>
List-Subscribe: <https://systeme.lip6.fr/mailman/listinfo/cocci>,
 <mailto:cocci-request@systeme.lip6.fr?subject=subscribe>
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr
To: Liam Breck <liam@networkimprov.net>
Cc: linux-pm@vger.kernel.org, Nicolas Palix <nicolas.palix@imag.fr>, Michal Marek <mmarek@suse.com>, =?ISO-8859-15?Q?Pali_Roh=E1r?= <pali.rohar@gmail.com>, Sebastian Reichel <sebastian.reichel@collabora.co.uk>, cocci@systeme.lip6.fr
List-Id: linux-pm@vger.kernel.org



On Tue, 29 Aug 2017, Liam Breck wrote:

> Coccinelle folks,
>
> On Tue, Aug 29, 2017 at 5:29 PM, Sebastian Reichel
> <sebastian.reichel@collabora.co.uk> wrote:
> > Hi,
> >
> > On Tue, Aug 29, 2017 at 04:07:12PM -0700, Liam Breck wrote:
> >> I don't see a Julia in CC list...
> >
> > <_< let's try that again.
> >
> >> On Tue, Aug 29, 2017 at 2:22 PM, Sebastian Reichel
> >> <sebastian.reichel@collabora.co.uk> wrote:
> >> > [adding Julia to Cc for Coccinelle question]
> >> >
> >> > Hi,
> >> >
> >> > On Tue, Aug 29, 2017 at 10:31:57AM -0500, Andrew F. Davis wrote:
> >> >> On 08/29/2017 05:54 AM, Sebastian Reichel wrote:
> >> >> > On Wed, Aug 23, 2017 at 08:36:12PM -0700, Liam Breck wrote:
> >> >> >> Overview:
> >> >> >> * Reorganizes chip data definitions
> >> >> >> * Enables features landed in these patches:
> >> >> >>   dt-bindings: power: supply: bq27xxx: Add monitored-battery documentation
> >> >> >>   power: supply: bq27xxx: Add chip data memory read/write support
> >> >> >>   power: supply: bq27xxx: Add power_supply_battery_info support
> >> >> >> * Supports the following chips (only BQ27425 is active)
> >> >> >>   BQ27500, 545, 425, 421, 441, 621
> >> >> >>
> >> >> >> Changes in v3:
> >> >> >> * BQ27425 tested; workaround minor chip bug
> >> >> >> * Dropped driver_version
> >> >> >> * Fixed dbg_dupes logic for .props & .dm_regs
> >> >> >> * Dropped two props array dupes
> >> >> >>
> >> >> >> Changes in v2:
> >> >> >> * Added di->opts flags for remaining chip features
> >> >> >> * Commented out untested bq27xxx_dm_regs parameters
> >> >> >> * Changed dbg_dupes to run only once
> >> >> >>
> >> >> >> Notes on v1:
> >> >> >> * Not fully tested (hence RFC tag)
> >> >> >
> >> >> > Thanks, full series queued.
> >> >> >
> >> >> > -- Sebastian
> >> >>
> >> >> Anyway, I've not got the time to fight these changes anymore, but at
> >> >> very least could you drop 4/5, it's static analysis code made into a
> >> >> runtime check built into a kernel driver, if not at least add my
> >> >> nacked-by. :)
> >> >
> >> > Since it's not critical at all and nobody depends on it, I dropped 4/5
> >> > for now. I agree, that checking it at runtime is not nice. On the other
> >> > hand I do think a duplication check makes sense. Doing a static
> >> > check should be possible, but I have no idea how to implement this
> >> > (without much effort). I suspect Coccinelle can do it, so I added
> >> > Julia.
> >> >
> >> > For reference this is the runtime check:
> >> > https://patchwork.kernel.org/patch/9918953/
>
> The data structures being checked start here:
> https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git/tree/drivers/power/supply/bq27xxx_battery.c?h=for-next#n138
>
> And are aggregated here:
> https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git/tree/drivers/power/supply/bq27xxx_battery.c?h=for-next#n743

It looks like it could be possible, since there are a lot of constants
involved.  I will look into it.

julia
