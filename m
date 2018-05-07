From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 2/5] dt-bindings: clock: add rk3399 DDR3 standard
 speed bins.
Date: Mon, 7 May 2018 09:12:48 -0500
Message-ID: <20180507141248.GA31442@rob-hp-laptop>
References: <20180505093450.17327-1-enric.balletbo@collabora.com>
 <20180505093450.17327-3-enric.balletbo@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180505093450.17327-3-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: myungjoo.ham@samsung.com, kyungmin.park@samsung.com, devicetree@vger.kernel.org, ulf.hansson@linaro.org, heiko@sntech.de, linux-pm@vger.kernel.org, dbasehore@chromium.org, linux-kernel@vger.kernel.org, dianders@google.com, groeck@chromium.org, kernel@collabora.com, hl@rock-chips.com, Chanwoo Choi <cw00.choi@samsung.com>, Mark Rutland <mark.rutland@arm.com>
List-Id: linux-pm@vger.kernel.org

On Sat, May 05, 2018 at 11:34:47AM +0200, Enric Balletbo i Serra wrote:
> DDR3 SDRAM Standard (JESD79-3F) defines some standard speed bins for
> DDR3 memories. The rk3399_dmc driver allows you to pass these values via
> the device tree. For that purpose the devfreq/rk3399_dmc.txt binding
> refers to a ddr.h file which does not exist. This patch adds the missing
> defines in a include file called rk3399-ddr.h with the definition of
> standard speed bins according to the ARM Trusted Firmware (ATF).
> 
> Fixes: c1ceb8f7c167 (Documentation: bindings: add dt documentation for rk3399 dmc)
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
> 
> Changes in v3: None
> Changes in v2:
> - [2/6] Improved commit message.
> - [2/6] Rename ddr.h to rk3399-ddr.h because is SoC specific.
> 
>  .../bindings/devfreq/rk3399_dmc.txt           |  2 +-
>  include/dt-bindings/clock/rk3399-ddr.h        | 56 +++++++++++++++++++
>  2 files changed, 57 insertions(+), 1 deletion(-)
>  create mode 100644 include/dt-bindings/clock/rk3399-ddr.h

Reviewed-by: Rob Herring <robh@kernel.org>
