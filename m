From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: Re: [PATCH v4 4/8] drivers: devfreq: add DMC driver for Exynos5422
Date: Thu, 07 Mar 2019 09:41:00 +0100
Message-ID: <84c06add-8375-55a6-01d6-ebbc6af011a9@samsung.com>
References: <CGME20190201164720eucas1p13aac6550399d240b261a2cbe489d3dfc@eucas1p1.samsung.com>
        <1549039612-28905-1-git-send-email-l.luba@partner.samsung.com>
        <1549039612-28905-5-git-send-email-l.luba@partner.samsung.com>
        <CAGTfZH0o6dHQj00vHwZBn05AT-Z_oAWHfBX0eATQ12NPmfw4fg@mail.gmail.com>
        <94e169cf-4dc2-82ec-1385-852bc7853931@samsung.com>
        <4bbc0f61-952e-bcdb-4645-2644a122ac99@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <4bbc0f61-952e-bcdb-4645-2644a122ac99@samsung.com>
Content-language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>
Cc: cwchoi00@gmail.com, Lukasz Luba <l.luba@partner.samsung.com>, devicetree <devicetree@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, Kukjin Kim <kgene@kernel.org>, Kyungmin Park <kyungmin.park@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

Hi Chanwoo,

On 3/7/19 02:10, Chanwoo Choi wrote:
> This patch has the another quetion about the clocks in
> exynos5_dmc_init_clks(). This functions used 'clk_set_parent'
> to make the hierarchy between clocks. I think it is possible to make
> the relation of clocks in DT by using the 'assigned-clocks'.

I'm fine either way, AFAICS it is a matter of setting parent of just
one clock - "mout_mx_mspll_ccore".  The driver needs to get that clock
anyway to enable/disable it as required.  So we will not gain much from
using assigned-clocks I'd say. I don't really have a strong opinion here
as I don't know detailed requirements of the DMC clock configuration
sequence. I'm inclined to keep it in driver as it would be more flexible.

-- 
Regards,
Sylwester
