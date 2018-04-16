From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH 03/14] thermal: exynos: Read soc_type from match data
Date: Mon, 16 Apr 2018 14:41:26 +0200
Message-ID: <5369056.eM2qptIOQZ@amdc3058>
References: <1523873525-23718-1-git-send-email-b.zolnierkie@samsung.com>
        <1523873525-23718-4-git-send-email-b.zolnierkie@samsung.com>
        <09824e4e-b60a-13eb-36a5-a6f2172b5539@linaro.org>
        <CGME20180416124129eucas1p1545c737e0feb0f9f2c327b8597c46bce@eucas1p1.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <09824e4e-b60a-13eb-36a5-a6f2172b5539@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>, Krzysztof Kozlowski <krzk@kernel.org>, Kukjin Kim <kgene@kernel.org>, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Maciej Purski <m.purski@samsung.com>
List-Id: linux-pm@vger.kernel.org

On Monday, April 16, 2018 02:19:30 PM Daniel Lezcano wrote:
> On 16/04/2018 12:11, Bartlomiej Zolnierkiewicz wrote:
> > From: Maciej Purski <m.purski@samsung.com>
> > 
> > Device context's field data->soc is currently obtained by comparing
> > of_compatible's. Provide soc_type as .data field in device's match
> > table, as it is done in most drivers.
> > 
> > Signed-off-by: Maciej Purski <m.purski@samsung.com>
> > Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> > ---
> 
> Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Zhang & Eduardo are Thermal Maintainers (+ I'm Maintainer for
Samsung Thermal) so I assume you meant "Reviewed-by:"?

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
