From: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
Subject: Re: [PATCH v2 0/5] Add runtime PM support for clocks (on Exynos SoC
 example)
Date: Fri, 7 Oct 2016 13:17:39 +0200
Message-ID: <57F78453.4090201@math.uni-bielefeld.de>
References: <CGME20160919105545eucas1p1026e435bbaeb1f5c866a9abcdd051464@eucas1p1.samsung.com>
 <1474282525-30441-1-git-send-email-m.szyprowski@samsung.com>
 <57F6926F.1070707@math.uni-bielefeld.de>
 <c1cf1a1f-2d1f-7f35-3e3b-f2de90959a24@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <c1cf1a1f-2d1f-7f35-3e3b-f2de90959a24@samsung.com>
Sender: linux-clk-owner@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>, linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Stephen Boyd <sboyd@codeaurora.org>, Michael Turquette <mturquette@baylibre.com>, Ulf Hansson <ulf.hansson@linaro.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Inki Dae <inki.dae@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-Id: linux-pm@vger.kernel.org

Hey Marek,


Marek Szyprowski wrote:
> Hi Tobias,
> 
> 
> On 2016-10-06 20:05, Tobias Jakobi wrote:
>> Hello Marek,
>>
>> I'm using the patches from the v4.8-clocks-pm-v2 branch plus the ones
>> from the v4.8-clocks-pm-v2 branch on top of 4.8.0.
>>
>> I see some warnings on boot coming from driver core. It appears that the
>> warnings are actually meaningful, since IOMMUs stop working completly.
>> E.g. if I modprobe s5p-mfc later, firmware loading fails because
>> apparantly the IOMMU domain isn't online.
>>
>>> WARNING: CPU: 0 PID: 1 at drivers/base/core.c:356
>>> device_links_driver_bound+0x124/0x12c
>> I added some debug printk() to device_links_driver_bound(), to show the
>> link status. Apparantly it is always DEVICE_LINK_AVAILABLE.
> 
> Please note that some additional patches are needed to get IOMMU working
> properly with both runtime-pm patches and deferred probe, which feature
> in turn is needed to get it working after adding clocks-pm changes. I
> will send such patch soon (as a new version of IOMMU deferred probe
> support patches were posted a few days ago).
I see. I thought that this was supposed to work with the patches in
v4.8-clocks-pm-v2.

I picked the patches in this range (endpoints included).
- arm: dma-mapping: Don't override dma_ops in arch_setup_dma_ops()
- clocks: exynos5433: add runtime pm support

And this range in v4.8-iommu-pm-v4>
- driver core: Add a wrapper around __device_release_driver()
- iommu/exynos: Add proper runtime pm support


Anyway, looking forward to test the new patchset.


- Tobias


> 
>> (...)
> 
> Best regards

