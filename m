From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: Re: [PATCH 2/4] ARM: dts: exynos: Fix LAN9730 on Odroid U3 after
 tftpboot
Date: Mon, 9 Jan 2017 13:17:38 -0300
Message-ID: <a145363b-4c88-ed27-839e-f71c9430dcf9@osg.samsung.com>
References: <20170107085203.4431-1-krzk@kernel.org>
 <20170107085203.4431-3-krzk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170107085203.4431-3-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Krzysztof Kozlowski <krzk@kernel.org>, Kukjin Kim <kgene@kernel.org>, Anand Moon <linux.amoon@gmail.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Peter Chen <peter.chen@nxp.com>, gregkh@linuxfoundation.org, stern@rowland.harvard.edu, ulf.hansson@linaro.org, broonie@kernel.org, sre@kernel.org, robh+dt@kernel.org, linux-usb@vger.kernel.org, linux-pm@vger.kernel.org, hverkuil@xs4all.nl, Markus Reichl <m.reichl@fivetechno.de>
List-Id: linux-pm@vger.kernel.org

Hello Krzysztof,

On 01/07/2017 05:52 AM, Krzysztof Kozlowski wrote:
> The ethernet adapter LAN9730, after enabling in bootloader (e.g. for
> tftpboot) requires reset during boot.  Otherwise it won't come up.
> 
> The schematics of Odroid U3 are detailed enough but after grabbing
> knowledge also from other sources (like U-Boot) the overall design looks
> like:
> 1. LAN9730 is connected to HSIC0 and USB3503 to HSIC1 of EHCI controller.
> 2. USB3503 comes with its own reset pin: gpx3-5.
> 3. Reset pin of LAN9730 is pulled up to 3.3 V so it cannot be used.
> 4. The supply of 3.3 V for LAN9730 is delivered from buck8.
> 5. Buck8 state is a logical OR of registry value (through I2C command)
>    and ENB8 pin.  The ENB8, not described in schematics, is in fact
>    gpa1-1.
> 6. Missing or wrongly timed reset of LAN9730 might result in missing of
>    two devices: LAN9730 and USB3503. Without reset, LAN9730 will not
>    come up, if it was enabled by bootloader.
> 
> To fix the issue use the generic power sequence driver and toggle the
> ENB8 (buck8) pin.  Reset duration of 500 us was chosen by experiments
> (shortest working time was 400 us).  This is an easiest way to fix the
> long standing LAN9730 reset issue.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---

Thanks for keep pushing a fix for this long standing issue.

Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
