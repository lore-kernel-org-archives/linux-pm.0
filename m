From: Lukasz Luba <l.luba@partner.samsung.com>
Subject: Re: [PATCH v3 3/8] clk: samsung: add BPLL rate table for Exynos
 5422 SoC
Date: Fri, 1 Feb 2019 16:39:04 +0100
Message-ID: <7c28d817-84bd-c88e-de84-801fd97645ec@partner.samsung.com>
References: <1548924594-19084-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190131085007eucas1p2f16107042b8ce5638811840618bcf017@eucas1p2.samsung.com>
        <1548924594-19084-4-git-send-email-l.luba@partner.samsung.com>
        <d5b8d165-564e-b776-77de-31a069118067@samsung.com>
        <0ca15b4c-ddaa-1be5-35be-e76b008b28a8@partner.samsung.com>
        <08850f80-0cc1-8e0d-6a8a-286a750d3a8c@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <08850f80-0cc1-8e0d-6a8a-286a750d3a8c@samsung.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Sylwester Nawrocki <s.nawrocki@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, b.zolnierkie@samsung.com, krzk@kernel.org, kgene@kernel.org, kyungmin.park@samsung.com, m.szyprowski@samsung.com, myungjoo.ham@samsung.com, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Hi Sylwester,

On 2/1/19 3:19 PM, Sylwester Nawrocki wrote:
> On 2/1/19 14:56, Lukasz Luba wrote:
>>> Exynos5422 used the same PLL table for apll, kpll, bpll and so on.
>>> You don't need to make the separate pll table. Just add new entries
>>> to exynos5420_pll2550x_24mhz_tbl table.
>> OK, I will extend the exynos5420_pll2550x_24mhz_tbl table.
>>
>> In v4 patch set, it will be fixed.
> 
> I would prefer to keep the rate table separate for BPLL, until correctness
> of new rates introduced in the patch and their applicability to the other PLLs
> is confirmed by the hardware team and verified in tests.
Good point, I share the same opinion. So, this new table for BPLL will stay.
Do you agree Chanwoo?
The BPLL is only used only by DMC.

Regards,
Lukasz
> 
