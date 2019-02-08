From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v4 6/8] DT: arm: exynos: add DMC device for exynos5422
Date: Fri, 8 Feb 2019 09:14:22 +0100
Message-ID: <CAJKOXPd07M_qAMtkRE8u6JFAj-f7iPEmwanWfmLkpG5Osi8mSg@mail.gmail.com>
References: <CGME20190201164721eucas1p286976bab0cc9e06c2cf74a0eaa20144e@eucas1p2.samsung.com>
 <1549039612-28905-1-git-send-email-l.luba@partner.samsung.com> <1549039612-28905-7-git-send-email-l.luba@partner.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1549039612-28905-7-git-send-email-l.luba@partner.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lukasz Luba <l.luba@partner.samsung.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, =?UTF-8?B?QmFydMWCb21pZWogxbtvxYJuaWVya2lld2ljeg==?= <b.zolnierkie@samsung.com>, kgene@kernel.org, Chanwoo Choi <cw00.choi@samsung.com>, kyungmin.park@samsung.com, Marek Szyprowski <m.szyprowski@samsung.com>, s.nawrocki@samsung.com, myungjoo.ham@samsung.com, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Fri, 1 Feb 2019 at 17:47, Lukasz Luba <l.luba@partner.samsung.com> wrote:
>
> Add description of Dynamic Memory Controller and PPMU counters.
> They are used by exynos5422-dmc driver.
>
> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
> ---
>  arch/arm/boot/dts/exynos5420.dtsi             | 78 +++++++++++++++++++++++++++
>  arch/arm/boot/dts/exynos5422-odroid-core.dtsi | 22 ++++++++
>  2 files changed, 100 insertions(+)

Looks good for me. I will take it after bindings get accepted. It is
getting late in the cycle so it might end up in subsequent merge
window.

The subject prefix should be "ARM: dts: exynos:". If you are going to
send v5, please fix it. Otherwise there is no problem and I can change
it while applying.

Best regards,
Krzysztof
