From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH 07/11] DT: arm64: exynos7: add support for thermal trip irq-mode
Date: Tue, 16 Oct 2018 17:10:05 +0200
Message-ID: <CAJKOXPemhDTF7moU4H=PS=6ZZZRDR7Mobo0Z+-kBd_hw0vB1kw@mail.gmail.com>
References: <CGME20181016145648eucas1p275ad5f845a04e40e5b9d0bbea624f34a@eucas1p2.samsung.com>
 <1539701782-26852-1-git-send-email-l.luba@partner.samsung.com> <20181016145648eucas1p275ad5f845a04e40e5b9d0bbea624f34a~eHqM4Yhz82489624896eucas1p25@eucas1p2.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181016145648eucas1p275ad5f845a04e40e5b9d0bbea624f34a~eHqM4Yhz82489624896eucas1p25@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: l.luba@partner.samsung.com
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, rui.zhang@intel.com, edubezval@gmail.com, daniel.lezcano@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, corbet@lwn.net, =?UTF-8?B?QmFydMWCb21pZWogxbtvxYJuaWVya2lld2ljeg==?= <b.zolnierkie@samsung.com>, kgene@kernel.org
List-Id: linux-pm@vger.kernel.org

On Tue, 16 Oct 2018 at 16:56, Lukasz Luba <l.luba@partner.samsung.com> wrote:
>
> This patch adds support for new flash which indicates
> that trip point triggers irq when temperature is met.
> Exynos5433 supports 8 trip point which will trigger irq.

Exynos7?

Beside that comments from previous email apply (no need to duplicate them).

Best regards,
Krzysztof
