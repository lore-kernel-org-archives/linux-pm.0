From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v4 8/8] ARM: exynos_defconfig: enable DMC driver
Date: Fri, 8 Feb 2019 09:15:01 +0100
Message-ID: <CAJKOXPf5_0eXt45eRmiXCvVhmKTOFwTFpJ4SkP=yG=5_qc8sMw@mail.gmail.com>
References: <CGME20190201164723eucas1p1ec009489584e1c85fd0d62270796e003@eucas1p1.samsung.com>
 <1549039612-28905-1-git-send-email-l.luba@partner.samsung.com> <1549039612-28905-9-git-send-email-l.luba@partner.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1549039612-28905-9-git-send-email-l.luba@partner.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lukasz Luba <l.luba@partner.samsung.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, =?UTF-8?B?QmFydMWCb21pZWogxbtvxYJuaWVya2lld2ljeg==?= <b.zolnierkie@samsung.com>, kgene@kernel.org, Chanwoo Choi <cw00.choi@samsung.com>, kyungmin.park@samsung.com, Marek Szyprowski <m.szyprowski@samsung.com>, s.nawrocki@samsung.com, myungjoo.ham@samsung.com, Russell King <linux@armlinux.org.uk>, Guenter Roeck <groeck@chromium.org>, Benson Leung <bleung@chromium.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Fri, 1 Feb 2019 at 17:47, Lukasz Luba <l.luba@partner.samsung.com> wrote:
>
> Enable driver for Dynamic Memory Controller dynamic frequency and
> voltage scaling in Exynos5422 SoCs.
>
> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
> ---
>  arch/arm/configs/exynos_defconfig | 1 +
>  1 file changed, 1 insertion(+)

Looks good for me. I will take it after driver gets accepted. It is
getting late in the cycle so it might end up in subsequent merge
window.

Best regards,
Krzysztof
