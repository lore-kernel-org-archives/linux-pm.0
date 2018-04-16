From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 14/14] arm64: dts: exynos: remove no longer needed samsung
 thermal properties
Date: Mon, 16 Apr 2018 15:10:55 +0200
Message-ID: <a4b5bb57-6db0-4e31-b99d-4f77ba6c04f3@linaro.org>
References: <1523873525-23718-1-git-send-email-b.zolnierkie@samsung.com>
 <1523873525-23718-15-git-send-email-b.zolnierkie@samsung.com>
 <3af07b96-dd74-336e-1261-dda2cde9abaa@linaro.org>
 <CGME20180416130917eucas1p10012e5d79bf59adc677e7e2364bae589@eucas1p1.samsung.com>
 <3588882.B9zsMSkHUz@amdc3058>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3588882.B9zsMSkHUz@amdc3058>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>, Krzysztof Kozlowski <krzk@kernel.org>, Kukjin Kim <kgene@kernel.org>, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 16/04/2018 15:09, Bartlomiej Zolnierkiewicz wrote:
> On Monday, April 16, 2018 03:02:45 PM Daniel Lezcano wrote:
>> On 16/04/2018 12:12, Bartlomiej Zolnierkiewicz wrote:
>>> Remove no longer needed samsung thermal properties.
>>>
>>> There should be no functional changes caused by this patch.
>>>
>>> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
>>> ---
>> Can you add an additional patch to remove the Documentation ?
> 
> "dt-bindings: thermal: remove no longer needed samsung thermal properties"
> (https://www.spinics.net/lists/linux-samsung-soc/msg62324.html)
> is already present in linux-soc-thermal-tree (Eduardo has not dropped it)

Ah, ok. Sorry for the noise.



-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
