From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH 1/5] thermal: exynos: enable core tmu clk on exynos platform
Date: Tue, 17 Jul 2018 14:20:56 +0200
Message-ID: <CAJKOXPdP78VFQgSQ9z9WsgYY_YhEKPUt=0MOra6Pz6smQeiNGg@mail.gmail.com>
References: <1531822342-4293-1-git-send-email-linux.amoon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1531822342-4293-1-git-send-email-linux.amoon@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Anand Moon <linux.amoon@gmail.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Kukjin Kim <kgene@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Anand,

Thanks for patch.

On 17 July 2018 at 12:12, Anand Moon <linux.amoon@gmail.com> wrote:
> clk_summary do not show tmu_apbif clk enable, so replace
> the clk_prepare with clk_prepare_enables to enable tmu clk.

This is not valid reason to do a change. What is clk_summary does not
really matter. Your change has negative impact on power consumption as
the clock stays enabled all the time. This is not what we want... so
please explain it more - why you need the clock to be enabled all the
time? What is broken (clk_summary is not broken in this case)?

> simplify the enable of tmu_triminfo_apbif clk, also fixed
> the order of goto error for failed cases.

This has to be split into separate change.

Best regards,
Krzysztof
