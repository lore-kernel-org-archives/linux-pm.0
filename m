From: Tomasz Figa <t.figa@samsung.com>
Subject: Re: [PATCH 1/3] ARM: EXYNOS: remove non-working AFTR mode support
Date: Wed, 17 Jul 2013 16:07:35 +0200
Message-ID: <3222513.hHN6nfv2Cl@amdc1227>
References: <1372241627-22695-1-git-send-email-b.zolnierkie@samsung.com>
 <51E694BA.3030906@linaro.org>
 <20130717133123.GA5453@e102568-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <20130717133123.GA5453@e102568-lin.cambridge.arm.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, "kgene.kim@samsung.com" <kgene.kim@samsung.com>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "jc.lee@samsung.com" <jc.lee@samsung.com>, Amit Kachhap <amit.daniel@samsung.com>, "rjw@sisk.pl" <rjw@sisk.pl>, "kyungmin.park@samsung.com" <kyungmin.park@samsung.com>, Arnd Bergmann <arnd@arndb.de>, chander.kashyap@linaro.org
List-Id: linux-pm@vger.kernel.org

Hi,

On Wednesday 17 of July 2013 14:31:23 Lorenzo Pieralisi wrote:
> On Wed, Jul 17, 2013 at 01:57:30PM +0100, Daniel Lezcano wrote:
> > On 07/11/2013 03:14 PM, Bartlomiej Zolnierkiewicz wrote:
> > > Hi,
> > > 
> > > On Friday, June 28, 2013 11:47:49 PM Daniel Lezcano wrote:
> > >> On 06/28/2013 06:27 PM, Bartlomiej Zolnierkiewicz wrote:
> > >>> On Friday, June 28, 2013 01:20:09 PM Daniel Lezcano wrote:
> > >>>> On 06/28/2013 12:11 PM, Tomasz Figa wrote:
> > >>>>> Hi Daniel,
> > >>>>> 
> > >>>>> I've been fighting with this whole AFTR state as well, before
> > >>>>> Bartlomiej. Let me share my thoughts on this.
> > >> 
> > >> [ ... ]
> > >> 
> > >>>>> If you don't unplug all the CPUs >0 the state is obviously never
> > >>>>> reached. Otherwise the whole system hangs after it tries to
> > >>>>> enter this mode without any reaction for external events, other
> > >>>>> than reset.
> > >>>> 
> > >>>> Need investigation.
> > >>>> 
> > >>>> What is the exynos board version where that occurs ?
> > >>> 
> > >>> Could you please tell me what exactly do you mean by that?
> > >>> 
> > >>> I already wrote that we can reproduce the problem on EXYNOS4210
> > >>> rev0
> > >>> and rev1.1 (we don't have rev1.0). Tomek has also reproduced the
> > >>> problem
> > >>> on some later SoCs (I hope that he can give you exact revisions).
> > >>> 
> > >>> In our testing we didn't encounter the board on which the problem
> > >>> doesn't occur. Our current working theory is that the problem may
> > >>> be
> > >>> u-boot (or first stage bootloader) related.
> > >> 
> > >> Ok, the status for what I know:
> > >> 
> > >> Origen Exynos4210, board ver A: works for me
> > >> Arndale Exynos5250: works for me but only if u-boot does not enable
> > >> the
> > >> hypervisor mode.
> > >> Chromebook Exynos5250: works for me
> > > 
> > > I've also done some more testing. First I tested on some Exynos4412
> > > devices (M0 and SLP_PQ) and AFTR was not working on them. Then I got
> > > my hands on Origen Exynos4210 (thanks to Tomek Figa for providing
> > > it) and AFTR is working just fine on it. Finally I tried Trats board
> > > again but with the upstream u-boot instead of our custom modified
> > > version (thanks to help from Lukasz Majewski) and I found out that
> > > after this change AFTR works fine on it! It also gives quite nice
> > > power savings (~80mA less current drawn in AFTR mode compared to
> > > just WFI one).
> > 
> > Is the 80mA power saving comparing with:
> >  * (cpu0/cpu1 online) vs (cpu0 AFTR and cpu1 offline)
> > 
> > or
> > 
> >  * (cpu0 AFTR and cpu1 offline) vs (cpu0 WFI and cpu1 offline)
> > 
> > ?
> > 
> > > With the above findings it now seems that the issue is on our side
> > > and is outside the kernel. Thanks for help with narrowing down the
> > > problem and sorry for wasting your time.
> > 
> > May be we were not working on the same tree.
> > 
> > I am on the linux-pm-next tree.
> > 
> > Now the merge window occurred, the AFTR is no longer working on my
> > board.
> > 
> > After git bisecting:
> > 
> > commit 87107d89052bcec1fe91b309631de4ed294a5171
> > Author: Arnd Bergmann <arnd@arndb.de>
> > Date:   Wed Jun 19 01:36:52 2013 +0900
> > 
> >     ARM: EXYNOS: Remove legacy L2X0 initialization
> >     
> >     Since Exynos is now supporting only DT-based boot, the old L2X0
> >     initialization code is not needed anymore, so
> >     exynos4_l2x0_cache_init()
> >     can be greatly simplified.
> >     
> >     Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> >     Signed-off-by: Tomasz Figa <t.figa@samsung.com>
> >     Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> >     Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> > :
> > :040000 040000 79e1adfd6386256ba71b3f609592d5acf9c08222
> > 
> > 9cb0026563b3b8657d906767493d26c501963269 M	arch
> > 
> > Reverting the patch solves the problem.
> > 
> > Any ideas ?
> 
> It is certainly a problem related to restoring L2 control registers in
> plat-samsung/s5p-sleep.S, probably DT init misses some registers
> (prefetch and power control) that are restored to zero values most
> likely, or the cluster cannot be shut down owing to those values not
> being programmed properly.

Looks like it.

> Chander posted a patch to fix that but I could
> not follow that thread, I have no idea where he got to and if that fixes
> the issue, I think so.

I will be doing a lot of cleanup of PM code for Samsung platforms starting 
from next week. Mostly low level suspend/resume handling (Samsung PM core), 
but since AFTR mode has much in common with sleep mode (e.g. both go 
through s5p-sleep.S after waking up), so I can look at this issue too, on 
our internal boards and Origen.

As for L2 suspend/resume on Samsung platforms, it has to be reworked 
completely, because on newer boards which have secure firmware it can't be 
resumed normally, because this requires calling several firmware operations. 
I already have patches for this, but need to do more testing, including 
checking how this interferes with things like AFTR mode.

Best regards,
Tomasz
