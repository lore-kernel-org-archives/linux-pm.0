From: Rob Herring <robh@kernel.org>
Subject: Re: [RFCv2 2/2] rpi: add support to enable usb power domain
Date: Thu, 5 Nov 2015 07:35:10 -0600
Message-ID: <20151105133510.GA12530@rob-hp-laptop>
References: <1446590711-18928-1-git-send-email-alex.aring@gmail.com>
 <1446590711-18928-3-git-send-email-alex.aring@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:59441 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1031373AbbKENfQ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 5 Nov 2015 08:35:16 -0500
Content-Disposition: inline
In-Reply-To: <1446590711-18928-3-git-send-email-alex.aring@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-rpi-kernel@lists.infradead.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, swarren@wwwdotorg.org, lee@kernel.org, eric@anholt.net, linux@arm.linux.org.uk, f.fainelli@gmail.com, rjui@broadcom.com, sbranden@broadcom.com, rjw@rjwysocki.net, khilman@kernel.org, ulf.hansson@linaro.org, len.brown@intel.com, pavel@ucw.cz, gregkh@linuxfoundation.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com, kernel@pengutronix.de

On Tue, Nov 03, 2015 at 11:45:11PM +0100, Alexander Aring wrote:
> This patch adds support for RPi several Power Domains and enable support
> to enable the USB Power Domain when it's not enabled before.
> 
> This patch based on Eric Anholt's patch to support Power Domains. He had
> an issue about -EPROBE_DEFER inside the power domain subsystem, this
> issue was solved by commit <311fa6a> ("PM / Domains: Return -EPROBE_DEFER
> if we fail to init or turn-on domain").
> 
> It was tested with barebox and the following scripts before booting
> linux:
> 
> /env/a_off:
> 
>  # cat /env/a_off
>  #turn off which are enabled by default
>  regulator -n bcm2835_mci0 -s disable
>  regulator -n uart0-pl0110 -s disable
> 
> /env/a_on:
> 
>  # cat /env/a_on
>  #turn off which are enabled by default
>  regulator -n bcm2835_mci0 -s disable
>  regulator -n uart0-pl0110 -s disable
> 
>  regulator -n bcm2835_mci0 -s enable
>  regulator -n uart0-pl0110 -s enable
>  regulator -n uart0-pl0111 -s enable
>  regulator -n bcm2835_usb -s enable
>  regulator -n bcm2835_i2c0 -s enable
>  regulator -n bcm2835_i2c1 -s enable
>  regulator -n bcm2835_i2c2 -s enable
>  regulator -n bcm2835_spi -s enable
>  regulator -n bcm2835_ccp2tx -s enable
>  regulator -n bcm2835_dsi -s enable
> 
> /env/b:
> 
>  # cat /env/b
>  sh /env/a_on
> 
>  regulator -n bcm2835_mci0 -s disable
>  regulator -n uart0-pl0110 -s disable
>  regulator -n uart0-pl0111 -s disable
>  regulator -n bcm2835_usb -s disable
>  regulator -n bcm2835_i2c0 -s disable
>  regulator -n bcm2835_i2c1 -s disable
>  regulator -n bcm2835_i2c2 -s disable
>  regulator -n bcm2835_spi -s disable
>  regulator -n bcm2835_ccp2tx -s disable
>  regulator -n bcm2835_dsi -s disable
> 
> /env/c:
> 
>  # cat /env/c
>  sh ./env/b
> 
>  regulator -n bcm2835_mci0 -s enable
>  regulator -n uart0-pl0110 -s enable
>  regulator -n uart0-pl0111 -s enable
>  regulator -n bcm2835_usb -s enable
>  regulator -n bcm2835_i2c0 -s enable
>  regulator -n bcm2835_i2c1 -s enable
>  regulator -n bcm2835_i2c2 -s enable
>  regulator -n bcm2835_spi -s enable
>  regulator -n bcm2835_ccp2tx -s enable
>  regulator -n bcm2835_dsi -s enable
> 
> These scripts enables/disable all regulators inside the bootloader. It
> was running with a "hard" and "soft" reset without any issues. These
> testcases should fit to Stephen Warren suggestions:
> 
> "(a) before having explicitly turned the power domain on or off at all (b)
> after having turned it on (c) after having turned it off, and for all
> power domains."
> 
> Cc: Stephen Warren <swarren@wwwdotorg.org>
> Cc: Lee Jones <lee@kernel.org>
> Cc: Eric Anholt <eric@anholt.net>
> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> ---
> changes since v2:
>  - add pm_genpd_uninit to handle probing failure.
>  - move power domain drive to his own driver in arch/arm/mach-bcm/
>    Also add own devicetree node for this driver, "raspberrypi,bcm2835-power".
>  - Removing all power domains which might exists for the firmware API but
>    we currently have no use-case for it. I tried to keep the same domain
>    numbering in generic power domains subsystem like they are offered from
>    the firmware API. This works, all power_domains which are NULL inside
>    the array of genpd_onecell_data.domains[#] will be ignored.
>  - Adding Eric Anholt and me to the authors.
>  - Creating devicetree documentation for the power domain driver.
>  - fix error handling in raspberrypi_firmware_set_power.
>  - Remove comment about mapping between power domains array, this is not
>    necessary anymore. I add a "enabled" attribute to raspberrypi_power_domain
>    which indicates if a domain should be registered or not (zeroed values
>    does not indicate such handling, but enabled is false then).
>  - remove "goto mbox" not necessary anymore because an own driver
>    implementation.
>  - Update devicetrees for changes in v2.
> 
>  .../bindings/arm/bcm/raspberrypi,bcm2835-power.txt |  25 +++
>  arch/arm/boot/dts/bcm2835-rpi.dtsi                 |  11 ++
>  arch/arm/boot/dts/bcm2835.dtsi                     |   2 +-
>  arch/arm/mach-bcm/Kconfig                          |  10 ++
>  arch/arm/mach-bcm/Makefile                         |   1 +
>  arch/arm/mach-bcm/raspberrypi-power.c              | 180 +++++++++++++++++++++
>  include/dt-bindings/arm/raspberrypi-power.h        |  14 ++
>  7 files changed, 242 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-power.txt
>  create mode 100644 arch/arm/mach-bcm/raspberrypi-power.c
>  create mode 100644 include/dt-bindings/arm/raspberrypi-power.h
> 
> diff --git a/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-power.txt b/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-power.txt
> new file mode 100644
> index 0000000..c3abc24
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-power.txt
> @@ -0,0 +1,25 @@
> +Raspberry Pi power domain driver
> +
> +Required properties:
> +
> +- compatible:		Should be "raspberrypi,bcm2835-power".

These are board or chip level power domains? If the latter, the vendor 
should not be raspberrypi, but Broadcom. If the former, then it should 
describe the board rather than the chip.

Rob
