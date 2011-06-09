From: Frank Hofmann <frank.hofmann@tomtom.com>
Subject: Re: [RFC PATCH v4] ARM hibernation/suspend-to-disk
 support
Date: Thu, 9 Jun 2011 17:26:35 +0100 (BST)
Message-ID: <alpine.DEB.2.00.1106091707220.11513__14315.557285636$1307636848$gmane$org@localhost6.localdomain6>
References: <alpine.DEB.2.00.1106071722040.2236@localhost6.localdomain6>
	<201106072348.44624.rjw@sisk.pl>
	<alpine.DEB.2.00.1106091604180.11513@localhost6.localdomain6>
	<20110609154058.GA24424@n2100.arm.linux.org.uk>
Reply-To: frank.hofmann@tomtom.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20110609154058.GA24424@n2100.arm.linux.org.uk>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Frank Hofmann <frank.hofmann@tomtom.com>, linux-pm@lists.linux-foundation.org, tuxonice-devel@tuxonice.net, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org



On Thu, 9 Jun 2011, Russell King - ARM Linux wrote:

> On Thu, Jun 09, 2011 at 04:30:08PM +0100, Frank Hofmann wrote:
>> Btw, when testing this I found that generic cpu_suspend seems to be just
>> fine for OMAP3; the OMAP platforms though do not at this time use the
>> generic cpu_suspend/resume for sleep, is it planned to change that ?
>
> That's because OMAP was doing changes to their sleep code while I was
> consolidating the sleep code, and although I asked several times that
> the OMAP folk should participate in this effort, but evidentally I was
> unsuccessful in achieving anything in that direction.
>
> And of course since then it's been forgotten about, and I've given up
> on that particular aspect.  I've also come to the conclusion that OMAP
> is sufficiently weird (requiring soo much to execute from SRAM) that
> its hopeless to persue.
>

Thanks for the info.

You're right the omap sleep code is long. The l1_logic_lost sequence of 
p15 accesses in there could probably be shortened via cpu_suspend/resume 
but it's not fully obvious (to me) how to plug it in.

I'm largely asking because the hibernation patch, as written (and using 
the cpu_v7_do_suspend/resume backends), does "work" on OMAP3 as far as 
I've tested it, i.e. it didn't need the complex dance done by the OMAP 
sleep code itself.

That said, there's secure state, there's maybe other stuff the iROM deals 
with, and I don't know how to comprehensively test this gets restored to 
a usable state (or even needs to), so a claim that the hibernation patch 
is proven perfect goes a bit far. Hence quotes, "works".

Re OMAP, there's two questions regarding hibernation/suspend-to-disk:

a) What reasons if any are there why cpu_{v7_do_}suspend/resume are not
    ok to use (on OMAP) for snapshotting core state, for the purpose of
    hibernation ?
    If there are any such issues, then how could they be addresssed ?

b) Is it necessary to provide machine hooks in the hibernation code for
    some auxilliary stuff that's not saved/restored by device suspend ?
    If so, how would this need to look like, from the OMAP view ?

OMAP is a complex piece as it seems, hence maybe someone can comment from 
that angle ?

FrankH.
