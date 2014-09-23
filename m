From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v8 6/8] drivers: cpuidle: CPU idle ARM64 driver
Date: Tue, 23 Sep 2014 19:16:17 +0100
Message-ID: <20140923181617.GB6269@e102568-lin.cambridge.arm.com>
References: <1409585324-3678-1-git-send-email-lorenzo.pieralisi@arm.com>
 <20140911085727.GA25773@e102568-lin.cambridge.arm.com>
 <5415C968.90303@gmail.com>
 <2444560.uIlK6FC0A9@amdc1032>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:56150 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755797AbaIWSQb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 23 Sep 2014 14:16:31 -0400
In-Reply-To: <2444560.uIlK6FC0A9@amdc1032>
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Tomasz Figa <tomasz.figa@gmail.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Will Deacon <Will.Deacon@arm.com>, Catalin Marinas <Catalin.Marinas@arm.com>, Mark Rutland <Mark.Rutland@arm.com>, Lina Iyer <lina.iyer@linaro.org>, Chander Kashyap <k.chander@samsung.com>, Vincent Guittot <vincent.guittot@linaro.org>, Nicolas Pitre <nico@linaro.org>, Ashwin Chaugule <ashwin.chaugule@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Kevin Hilman <khilman@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Sebastian Capella <sebcape@gmail.com>, Mark Brown <broonie@kernel.org>, Antti Miettinen <ananaza@iki.fi>, Paul Walmsley <paul@pwsan.com>, Geoff

On Tue, Sep 23, 2014 at 02:42:48PM +0100, Bartlomiej Zolnierkiewicz wrote:
> 
> Hi,
> 
> On Sunday, September 14, 2014 06:59:20 PM Tomasz Figa wrote:
> > [dropping my old @samsung.com address]
> > 
> > On 11.09.2014 10:57, Lorenzo Pieralisi wrote:
> > > On Thu, Sep 11, 2014 at 09:28:06AM +0100, Daniel Lezcano wrote:
> > >> On 09/05/2014 05:34 PM, Lorenzo Pieralisi wrote:
> > >>> On Fri, Sep 05, 2014 at 10:21:20AM +0100, Will Deacon wrote:
> > >>>> On Thu, Sep 04, 2014 at 06:29:10PM +0100, Lorenzo Pieralisi wrote:
> > >>>>> On Thu, Sep 04, 2014 at 05:03:20PM +0100, Catalin Marinas wrote:
> > >>>>>> On Wed, Sep 03, 2014 at 06:37:40PM +0100, Lorenzo Pieralisi wrote:
> > >>>>>>> This patch should be ready to go too, is it ok if I split the series
> > >>>>>>> in arm64 arch specific patches (will ask Catalin to pull) and CPUidle ones
> > >>>>>>> (inclusive of DT bindings and !!this patch!!) and send two separate pull
> > >>>>>>> requests ?
> > >>>>>>
> > >>>>>> If Daniel/Rafael don't have any objection, I can take the whole series
> > >>>>>> through the arm64 tree (it seems that patches have been already acked by
> > >>>>>> Daniel).
> > >>>>>
> > >>>>> Thanks a lot Catalin. Since this one is a brand new CPUidle driver and it
> > >>>>> follows a different pattern from arm legacy drivers I would like to get
> > >>>>> Daniel's ack on this patch too before pushing it. For the records I have
> > >>>>> just added two pr_err to signal driver probing error, ultraminor changes
> > >>>>> that do not justify a repost.
> > >>>>>
> > >>>>> If Samsung guys do not manifest themselves I would drop patch 8 from
> > >>>>> the series till it gets tested and its patch dependency queued too.
> > >>>>
> > >>>> The last patch also has a dependency, as you mentioned to Daniel. I think
> > >>>> we can certainly merge the arm64 parts, and if Daniel doesn't object, then
> > >>>> we can take the driver stuff too but leaving the exynos bits out (i.e. drop
> > >>>> the last patch).
> > >>>>
> > >>>> Anyway, if you could repost with the acks you've collected and rearrange it
> > >>>> so the arm64 patches are first in the series, that would be great.
> > >>>
> > >>> I can repost it with the acks and rearrange the patches, but for the
> > >>> pull request I have to know what code can be merged, since there are
> > >>> some arm64 patches (PSCI and CPUidle arm64 back-end) that are strictly
> > >>> tied to the arm64 CPUidle driver, so I *have* to know if the arm64
> > >>> CPUidle driver (this patch) can get merged and that requires an ack.
> > >>>
> > >>> If I do not hear from Samsung guys I will drop patch 8.
> > >>
> > >> Well I would prefer to have this patch merged (Cc'ing Tomasz).
> > > 
> > > Ok, but:
> > > 
> > > a) I only compile tested it
> > > b) There is a dts patch dependency for patch 8 to apply cleanly and it
> > >    hasn't been acked (I can't really do it since I can't test it)
> > > 
> > >    http://lists.infradead.org/pipermail/linux-arm-kernel/2014-July/274179.html
> > > 
> > > So, what should we do ? Tomasz ?
> > 
> > Sorry for late reply. I don't work for Samsung anymore so I don't focus
> > that much on areas other than I still maintain.
> > 
> > As for b) I believe all my patches have been already merged and now
> > we're just waiting for Kukjin to apply Bart's patch (although it's been
> > sitting on the ML since July, so probably needs rebasing).
> > 
> > About the patch 8 alone, somebody would have to test it. Maybe Bart or
> > Krzysztof could find some time to look at this? Other than that, I'm not
> > quite sure about entry latency you specified. It would look like
> > entering the state takes longer time than leaving, which I believe is
> > not the case. However I can't find any place in the code which would use
> > entry latency, so it might not be that important for now.
> 
> I tested this patch series on both Exynos4210 (Origen board) and Exynos5250
> (Arndale board).  On Exynos4210 AFTR cpuidle mode is still working fine
> with the patch series applied.  On Exynos5250 AFTR is not working but it is
> an upstream problem (same happens with v3.17-rc4).
> 
> Lorenzo, you can add
> 
> Tested-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> 
> to the Exynos patch (patch #8).

Thanks a lot, that's great. I hope Daniel can add the tag and get this
merged.

Lorenzo

