From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH v9 0/5] Add runtime PM support for clocks (on Exynos SoC
 example)
Date: Tue, 22 Aug 2017 11:27:06 +0200
Message-ID: <e53af278-061d-bc9b-6f05-65c5e5491d00@samsung.com>
References: <CGME20170821080538eucas1p1e273ef22920493ee406ef546bcc230e5@eucas1p1.samsung.com>
        <1503302703-13801-1-git-send-email-m.szyprowski@samsung.com>
        <CAMuHMdUy5hi3fLVW6J1o=D194ASjr7Vz-pjWtddHyybK4RZxxA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.w1.samsung.com ([210.118.77.11]:52538 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932205AbdHVJ1L (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 22 Aug 2017 05:27:11 -0400
In-reply-to: <CAMuHMdUy5hi3fLVW6J1o=D194ASjr7Vz-pjWtddHyybK4RZxxA@mail.gmail.com>
Content-language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-clk <linux-clk@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Stephen Boyd <sboyd@codeaurora.org>, Michael Turquette <mturquette@baylibre.com>, Ulf Hansson <ulf.hansson@linaro.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Inki Dae <inki.dae@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Hi Geert,

On 2017-08-22 11:21, Geert Uytterhoeven wrote:
> On Mon, Aug 21, 2017 at 10:04 AM, Marek Szyprowski
> <m.szyprowski@samsung.com> wrote:
>> Patches for clocks drivers change the way the clock provider is initialized.
>> Instead of CLK_OF_DECLARE based initialization, a complete platform device driver
>> infrastructure is being used. This is needed to let driver to use runtime PM
>> feature and integrate with generic power domains. The side-effect of this change
>> is a delay in clock provider registeration during system boot, so early
>> initialized drivers might get EPROBEDEFER error when requesting their clocks.
>> This was an issue for IOMMU drivers, but IOMMU deferred probe support has been
>> finally merged to v4.13-rc1 and now it is handled correctly.
> Any chances you have PHY devices falling back to polling due to this,
> cfr. https://patchwork.kernel.org/patch/9734175/?

At least in case of Exynos5433 all related PHY drivers correctly handle 
deferred
probe and don't fallback to half-functional mode.

Best regards

-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
