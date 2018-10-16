From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH 09/11] DT: arm: exynos: add support for thermal trip irq-mode
Date: Tue, 16 Oct 2018 17:13:03 +0200
Message-ID: <CAJKOXPdKoxB3aN+1y48WD9Gv2P6KvSFSiD6aCk+PimBooE3YWg@mail.gmail.com>
References: <CGME20181016145651eucas1p1ea84684e37e67b4161548e6cff489cb8@eucas1p1.samsung.com>
 <1539701782-26852-1-git-send-email-l.luba@partner.samsung.com> <20181016145651eucas1p1ea84684e37e67b4161548e6cff489cb8~eHqPK-tM31616816168eucas1p1y@eucas1p1.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181016145651eucas1p1ea84684e37e67b4161548e6cff489cb8~eHqPK-tM31616816168eucas1p1y@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: l.luba@partner.samsung.com
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, rui.zhang@intel.com, edubezval@gmail.com, daniel.lezcano@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, corbet@lwn.net, =?UTF-8?B?QmFydMWCb21pZWogxbtvxYJuaWVya2lld2ljeg==?= <b.zolnierkie@samsung.com>, kgene@kernel.org
List-Id: linux-pm@vger.kernel.org

On Tue, 16 Oct 2018 at 16:56, Lukasz Luba <l.luba@partner.samsung.com> wrote:
>
> This patch adds support for new flash which indicates
> that trip point triggers irq when temperature is met.
> Exynos5433 supports 8 trip point which will trigger irq.

Exynos5420? 4 trip points?

BTW, I just noted that you skipped samsung-soc mailing list.

DTS patches always should go through arm-soc so in case of Exynos -
linux-samsung-soc mailing list. The list should be also CC-ed if you
touch other Exynos or Samsung related code and get_maintainers.pl
always point it. Because you skipped it, some people might miss your
patches and definitely Patchwork which I am using won't see them
(https://patchwork.kernel.org/project/linux-samsung-soc/list/).

Best regards,
Krzysztof
