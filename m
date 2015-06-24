From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH 4/6] ARM: dts: Exynos4210: add CPU OPP and regulator supply
 property
Date: Wed, 24 Jun 2015 16:25:51 +0200
Message-ID: <14660850.Y17AZAAdgl@amdc1976>
References: <'@samsung.com> <20150622150421.9112.96812@quantum>
 <55889E59.1070001@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <55889E59.1070001@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Michael Turquette <mturquette@baylibre.com>, Kukjin Kim <kgene@kernel.org>, linux-arm-kernel@lists.infradead.org, 'Lukasz Majewski' <l.majewski@samsung.com>, 'Heiko Stuebner' <heiko@sntech.de>, 'Kevin Hilman' <khilman@linaro.org>, 'Sachin Kamat' <sachin.kamat@linaro.org>, 'Viresh Kumar' <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, 'Tomasz Figa' <tomasz.figa@gmail.com>, linux-kernel@vger.kernel.org, 'Chanwoo Choi' <cw00.choi@samsung.com>, 'Thomas Abraham' <thomas.ab@samsung.com>, 'Sylwester Nawrocki' <s.nawrocki@samsung.com>, 'Andreas Faerber' <afaerber@suse.de>, 'Doug Anderson' <dianders@chromium.org>, 'Javier Martinez Canillas' <javier.martinez@collabora.co.uk>, linux-samsung-soc@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


Hi,

On Tuesday, June 23, 2015 08:46:33 AM Krzysztof Kozlowski wrote:
> On 23.06.2015 00:04, Michael Turquette wrote:
> > Quoting Kukjin Kim (2015-06-21 18:46:26)
> >> Krzysztof Kozlowski wrote:
> >>>
> >>> On 22.06.2015 10:38, Kukjin Kim wrote:
> >>>> Krzysztof Kozlowski wrote:
> >>>>> 2015-05-08 9:18 GMT+09:00 Krzysztof Kozlowski <k.kozlowski@samsung.com>:
> >>>>>> 2015-04-04 1:43 GMT+09:00 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>:
> >>>>>>> From: Thomas Abraham <thomas.ab@samsung.com>
> >>>>>>>
> >>>>>>> For Exynos4210 platforms, add CPU operating points and CPU
> >>>>>>> regulator supply properties for migrating from Exynos specific
> >>>>>>> cpufreq driver to using generic cpufreq driver.
> >>>>>>>
> >>>>>>> Changes by Bartlomiej:
> >>>>>>> - removed Exynos5250 and Exynos5420 support for now
> >>>>>>>
> >>>>>>> Cc: Kukjin Kim <kgene.kim@samsung.com>
> >>>>>>> Cc: Doug Anderson <dianders@chromium.org>
> >>>>>>> Cc: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
> >>>>>>> Cc: Andreas Faerber <afaerber@suse.de>
> >>>>>>> Cc: Sachin Kamat <sachin.kamat@linaro.org>
> >>>>>>> Cc: Andreas Farber <afaerber@suse.de>
> >>>>>>> Cc: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
> >>>>>>> Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
> >>>>>>> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> >>>>>>
> >>>>>> Acked-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> >>>>>
> >>>>> Rebased and applied to my tree, I'll sent it later to Kukjin unless he
> >>>>> picks it by himself from LKML.
> >>>>>
> >>>> Hi, as far as I know, this is for v4.2 not v4.1 so it will be applied based on
> >>>> v4.2-rc1 after v4.2-rc1 release.
> >>>
> >>> You mean it is for v4.3, not v4.2?
> >>>
> >> Oops, yes v4.3.
> >>
> >> Thanks for the correction.
> > 
> > Kukjin & Krzysztof,
> > 
> > I'm confused on this point. I was planning to take patches 1, 2, 3, 5
> > and 6 towards 4.2 (e.g. in the pull request that I'll send out this
> > week).
> > 
> > Is patch 4 going out for 4.2 or 4.3?
> 
> It is quite late for sending pull request to arm-soc for 4.2.
> For example SoCFPGA pull request from last week was rejected:
> http://comments.gmane.org/gmane.linux.ports.arm.kernel/417980
> 
> If you want to take it for 4.2 then I am fine with it but this will
> cause some easy but annoying conflicts. There aren't difficult - just
> most of nodes in board DTS changed their place.

Taking all patches together would be a preferred solution from my POV.

It would also be great if it could happen in v4.2 (all code changes are
practically limited to our Exynos4210 platform so I hope that it should
be fine) as it would be easier to work on Exynos4x12, Exynos5250 and
Exynos542x/5800 patch series.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> Example of resolution (target file after merge, with cpu nodes reordered
> alphabetically):
> https://github.com/krzk/linux/commit/2cec3cb48abaf44848c62f1c0836b772eb4680dd
> 
> Best regards,
> Krzysztof
