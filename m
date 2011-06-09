From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [RFC PATCH v4] ARM hibernation/suspend-to-disk
	support
Date: Thu, 09 Jun 2011 22:05:28 +0530
Message-ID: <4DF0F650.4040604__42457.3056087413$1307637397$gmane$org@ti.com>
References: <alpine.DEB.2.00.1106071722040.2236@localhost6.localdomain6>	<201106072348.44624.rjw@sisk.pl>	<alpine.DEB.2.00.1106091604180.11513@localhost6.localdomain6>	<20110609154058.GA24424@n2100.arm.linux.org.uk>
	<alpine.DEB.2.00.1106091707220.11513@localhost6.localdomain6>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.DEB.2.00.1106091707220.11513@localhost6.localdomain6>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: frank.hofmann@tomtom.com
Cc: linux-pm@lists.linux-foundation.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, tuxonice-devel@tuxonice.net, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On 6/9/2011 9:56 PM, Frank Hofmann wrote:
>
>
> On Thu, 9 Jun 2011, Russell King - ARM Linux wrote:
>
>> On Thu, Jun 09, 2011 at 04:30:08PM +0100, Frank Hofmann wrote:
>>> Btw, when testing this I found that generic cpu_suspend seems to be just
>>> fine for OMAP3; the OMAP platforms though do not at this time use the
>>> generic cpu_suspend/resume for sleep, is it planned to change that ?
>>
>> That's because OMAP was doing changes to their sleep code while I was
>> consolidating the sleep code, and although I asked several times that
>> the OMAP folk should participate in this effort, but evidentally I was
>> unsuccessful in achieving anything in that direction.
>>
>> And of course since then it's been forgotten about, and I've given up
>> on that particular aspect. I've also come to the conclusion that OMAP
>> is sufficiently weird (requiring soo much to execute from SRAM) that
>> its hopeless to persue.
>>
>
> Thanks for the info.
>
> You're right the omap sleep code is long. The l1_logic_lost sequence of
> p15 accesses in there could probably be shortened via cpu_suspend/resume
> but it's not fully obvious (to me) how to plug it in.
>
> I'm largely asking because the hibernation patch, as written (and using
> the cpu_v7_do_suspend/resume backends), does "work" on OMAP3 as far as
> I've tested it, i.e. it didn't need the complex dance done by the OMAP
> sleep code itself.
>
It's not doing it for fun for sure.

> That said, there's secure state, there's maybe other stuff the iROM
> deals with, and I don't know how to comprehensively test this gets
> restored to a usable state (or even needs to), so a claim that the
> hibernation patch is proven perfect goes a bit far. Hence quotes, "works".
>
Thanks for appreciating something in that code
about secure state and all.

> Re OMAP, there's two questions regarding hibernation/suspend-to-disk:
>
> a) What reasons if any are there why cpu_{v7_do_}suspend/resume are not
> ok to use (on OMAP) for snapshotting core state, for the purpose of
> hibernation ?
> If there are any such issues, then how could they be addresssed ?
>
Part of the answer is what Russell described. We think it's doable,
but it needs some work. First and fore most is this code should
be able to be executed from DDR. It's not the case today.

There are some trust zone registers comes on the way. Like
AUXCTRL can't be written on OMAP directly. It will either
abort or not have any effect. L2 cache invalidations need
to use secure APIs etc.
WFI can't be executed being in DDR. It must be from SRAM
which is mapped as non-cache able memory.


> b) Is it necessary to provide machine hooks in the hibernation code for
> some auxilliary stuff that's not saved/restored by device suspend ?
> If so, how would this need to look like, from the OMAP view ?
>
I already covered this above.

> OMAP is a complex piece as it seems, hence maybe someone can comment
> from that angle ?
>
Agree it's complex but with some provisions in generic code,
it might work.

Regards
Santosh
