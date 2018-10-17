From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH 06/11] DT: arm64: exynos: add support for thermal trip irq-mode
Date: Wed, 17 Oct 2018 09:04:26 +0200
Message-ID: <CAJKOXPdfkdAAoEj=J4T4yxC2EL8rcu88P2Yg2OkUCq89CW3Qiw@mail.gmail.com>
References: <CGME20181016145647eucas1p206c068806214535da339588d77cbdfa5@eucas1p2.samsung.com>
 <1539701782-26852-1-git-send-email-l.luba@partner.samsung.com>
 <20181016145647eucas1p206c068806214535da339588d77cbdfa5~eHqLYh2dR2135021350eucas1p2K@eucas1p2.samsung.com>
 <CAJKOXPe4Jf3QVbQ6BFPFptkgvmmpNu+QCmDoD3JqhyYOidJ7vA@mail.gmail.com> <20181016154833eucas1p2b2e7cbb90df83737e655bb8a343c4eab~eIXYh7z9r2960029600eucas1p2p@eucas1p2.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181016154833eucas1p2b2e7cbb90df83737e655bb8a343c4eab~eIXYh7z9r2960029600eucas1p2p@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: l.luba@partner.samsung.com
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, rui.zhang@intel.com, edubezval@gmail.com, daniel.lezcano@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, corbet@lwn.net, =?UTF-8?B?QmFydMWCb21pZWogxbtvxYJuaWVya2lld2ljeg==?= <b.zolnierkie@samsung.com>, kgene@kernel.org
List-Id: linux-pm@vger.kernel.org

On Tue, 16 Oct 2018 at 17:48, Lukasz Luba <l.luba@partner.samsung.com> wrote:
>
> Hi Krzysztof,
>
> On 10/16/2018 05:09 PM, Krzysztof Kozlowski wrote:
> > On Tue, 16 Oct 2018 at 16:56, Lukasz Luba <l.luba@partner.samsung.com> wrote:
> >>
> >
> > Hi Lukasz,
> >
> > Thanks for patches.
> >
> > I did not receive the first patches in the series. It is okay (depends
> > on the context) but in such case sending cover letter to all people is
> > quite useful. It helps to understand the entire patchset. Since I did
> > not get them, I really do not know:
> > 1. Whether DTS patches are independent?
> > 2. How this fits in the big picture of Exynos thermal?
> I have lost your email for my 'cc' command line, my apologies.
> I will add you in v2.
> Here you can find the cover letter:
> https://marc.info/?l=linux-pm&m=153970180314648&w=2
> regarding
> 1. they are independent
> 2. It will be less confusing and more coherent with documentation
> when we use 'passive' for DVFS cooling. Unfortunately, when 'passive'
> is set, it registers our trip points for polling and thermal schedules
> the work. I had conversation with Daniel regarding this setup,
> please check these email:
> https://marc.info/?l=linux-kernel&m=153924620318766&w=2
> and my response:
> https://marc.info/?l=linux-kernel&m=153933708316168&w=2

I see it on the linux-pm, I'll reply there.

Best regards,
Krzysztof
