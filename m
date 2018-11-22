From: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
Subject: Re: [PATCH 0/6] devfreq: handle suspend/resume
Date: Thu, 22 Nov 2018 18:24:12 +0100
Message-ID: <1d9cf1b6-b625-4b6d-7578-0f02f7efdb8a@math.uni-bielefeld.de>
References: <CGME20181121180156eucas1p225af7f4341a039264ff26f2a9ad9bb12@eucas1p2.samsung.com>
 <1542823301-23563-1-git-send-email-l.luba@partner.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1542823301-23563-1-git-send-email-l.luba@partner.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lukasz Luba <l.luba@partner.samsung.com>, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Cc: myungjoo.ham@samsung.com, kyungmin.park@samsung.com, cw00.choi@samsung.com, rjw@rjwysocki.net, len.brown@intel.com, pavel@ucw.cz, gregkh@linuxfoundation.org, keescook@chromium.org, anton@enomsg.org, ccross@android.com, tony.luck@intel.com, robh+dt@kernel.org, mark.rutland@arm.com, kgene@kernel.org, krzk@kernel.org, m.szyprowski@samsung.com, b.zolnierkie@samsung.com
List-Id: linux-pm@vger.kernel.org

Hey Lukasz,

just wanted to say hi and thanks for picking this up. Sadly my work no longer
permits me to spend time working on the kernel.

Anyway, great that this issue finally gets solved! :)

With best wishes,
Tobias


Lukasz Luba wrote:
> Hi all,
> 
> This patch set aims to address the issue with devfreq devices' frequency
> during suspend/resume. It extends suspend/resume by calls to Devfreq
> framework. In the devfreq framework there is a small refactoring to avoid
> code duplication in changging frequency (patch 2) and there are extensions
> for suspending devices.
> 
> It has been tested on Odroid u3 with Exynos 4412.
> 
> The patch set draws on Tobias Jakobi's work posted ~2 years ago, who tried
> to solve issue with devfreq device's frequency during suspend/resume.
> During the discussion on LKML some corner cases and comments appeared
> related to the design. This patch set address them keeping in mind
> suggestions from Chanwoo Choi.
> Tobias's paches:
> https://www.spinics.net/lists/linux-samsung-soc/msg56602.html 
> 
> Regards,
> Lukasz Luba
> 
> Lukasz Luba (6):
>   devfreq: add basic fileds supporting suspend functionality
>   devfreq: refactor set_target frequency function
>   devfreq: add support for suspend/resume of a devfreq device
>   devfreq: add devfreq_suspend/resume() functions
>   drivers: power: suspend: call devfreq suspend/resume
>   arm: dts: exynos4: set opp-suspend for DMC and leftbus
> 
>  arch/arm/boot/dts/exynos4210.dtsi |   2 +
>  arch/arm/boot/dts/exynos4412.dtsi |   2 +
>  drivers/base/power/main.c         |   3 +
>  drivers/devfreq/devfreq.c         | 159 ++++++++++++++++++++++++++++++--------
>  include/linux/devfreq.h           |  11 +++
>  5 files changed, 146 insertions(+), 31 deletions(-)
> 
