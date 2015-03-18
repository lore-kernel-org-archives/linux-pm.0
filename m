From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH v3 3/4] ARM: EXYNOS: cpuidle: add AFTR mode support for
 Exynos3250
Date: Wed, 18 Mar 2015 16:03:27 +0100
Message-ID: <1662403.kKJKYQxI82@amdc1032>
References: <1426683113-31209-1-git-send-email-b.zolnierkie@samsung.com>
 <1426683113-31209-4-git-send-email-b.zolnierkie@samsung.com>
 <CAJKOXPc6Z9iSC=XfYmLUPcp_xQC=-9FRajw1LR4ood0zr5KFiQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7Bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <CAJKOXPc6Z9iSC=XfYmLUPcp_xQC=-9FRajw1LR4ood0zr5KFiQ@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Kukjin Kim <kgene.kim@samsung.com>, Kukjin Kim <kgene@kernel.org>, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, Daniel Lezcano <daniel.lezcano@linaro.org>, Tomasz Figa <tomasz.figa@gmail.com>, linux-kernel@vger.kernel.org, Kyungmin Park <kyungmin.park@samsung.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Wednesday, March 18, 2015 02:38:26 PM Krzysztof Kozlowski wrote:
> 2015-03-18 13:51 GMT+01:00 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>:
> 
> The patchset itself looks good... but it's missing commit message.
> What benefits does the AFTR bring?

AFTR support brings reduced energy consumption and is a prerequisite
for more advanced W-AFTR/LPA power saving modes.  AFTR has been already
supported on other Exynos SoCs for few years so there is really no need
to explain its purpose with every new SoC support addition.

[ Moreover you know this all really well since we've worked together on
  many Exynos Power Management issues :). ]

I understand that you are complaining about skimpy commit message and
I can certainly improve it (however personally I think that it will not
bring much benefit because the patch is rather straightforward one).

Please also note that while I appreciate review comments please try to
make them more substantial and bring them earlier (this patchset hasn't
really changed since v1 which was posted in October 2014).

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
