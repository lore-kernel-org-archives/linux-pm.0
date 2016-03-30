From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH v7 1/4] dt-bindings: power: reset: add document for
 reboot-mode driver
Date: Wed, 30 Mar 2016 12:44:16 +0900
Message-ID: <56FB4B90.4000206@samsung.com>
References: <1459304304-9713-1-git-send-email-andy.yan@rock-chips.com>
 <1459304390-9763-1-git-send-email-andy.yan@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1459304390-9763-1-git-send-email-andy.yan@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Yan <andy.yan@rock-chips.com>, robh+dt@kernel.org, sre@kernel.org, heiko@sntech.de, john.stultz@linaro.org, arnd@arndb.de
Cc: galak@codeaurora.org, ijc+devicetree@hellion.org.uk, catalin.marinas@arm.com, olof@lixom.net, alexandre.belloni@free-electrons.com, dbaryshkov@gmail.com, jun.nie@linaro.org, pawel.moll@arm.com, will.deacon@arm.com, linux-rockchip@lists.infradead.org, matthias.bgg@gmail.com, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, f.fainelli@gmail.com, linux@arm.linux.org.uk, mbrugger@suse.com, linux-arm-kernel@lists.infradead.org, lorenzo.pieralisi@arm.com, moritz.fischer@ettus.com, linux-kernel@vger.kernel.org, wxt@rock-chips.com, dwmw2@infradead.org, mark.rutland@arm.com
List-Id: linux-pm@vger.kernel.org

On 30.03.2016 11:19, Andy Yan wrote:
> Add device tree bindings document for reboot-mode driver.
> 
> Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
> Acked-by: Rob Herring <robh@kernel.org>
> 
> ---
> 
> Changes in v7:
> - fix some spelling mistakes
> - declare that the mode magic should be none-zero value
> 
> Changes in v6:
> - fix a typo with "property"
> - describe property "mask" more clear
> 
> Changes in v5:
> - delete a unnecessary blank line in syscon-reboot-mode.txt
> - rename mode-fastoboot to mode-bootloader in syscon-reboot-mode.txt
> - rename macro BOOT_LOADER to BOOT_BL_DOWNLOAD, which gives a more clear mean
> 
> Changes in v4:
> - remove mode-maskrom
> - rename mode-fastboot to mode-bootloader to keep compatible with the exiting Android device
> 
> Changes in v3:
> - descirbe all reboot mode as properity instead of subnode
> 
> Changes in v2: None
> Changes in v1: None
> 
>  .../bindings/power/reset/reboot-mode.txt           | 25 ++++++++++++++++
>  .../bindings/power/reset/syscon-reboot-mode.txt    | 35 ++++++++++++++++++++++
>  2 files changed, 60 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/reset/reboot-mode.txt
>  create mode 100644 Documentation/devicetree/bindings/power/reset/syscon-reboot-mode.txt

Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>



Best regards,

Krzysztof
