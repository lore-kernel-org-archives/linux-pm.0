From: "Jon Medhurst (Tixy)" <tixy@linaro.org>
Subject: Re: [PATCH v4 6/8] arm64: dts: add SRAM, MHU mailbox and SCPI
 support on Juno
Date: Mon, 08 Jun 2015 14:51:19 +0100
Message-ID: <1433771479.2882.44.camel@linaro.org>
References: <1433760002-24120-1-git-send-email-sudeep.holla@arm.com>
	 <1433760002-24120-7-git-send-email-sudeep.holla@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1433760002-24120-7-git-send-email-sudeep.holla@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Liviu Dudau <Liviu.Dudau@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Arnd Bergmann <arnd@arndb.de>, Kevin Hilman <khilman@kernel.org>, Olof Johansson <olof@lixom.net>
List-Id: linux-pm@vger.kernel.org

On Mon, 2015-06-08 at 11:40 +0100, Sudeep Holla wrote:
[...]
> +
> +	scpi {
> +		compatible = "arm,scpi";
> +		mboxes = <&mailbox 1>;
> +		shmem = <&cpu_scp_hpri>;
> +
> +		clocks {
> +			compatible = "arm,scpi-clocks";
> +
> +			scpi_dvfs: scpi_clocks@0 {
> +				compatible = "arm,scpi-dvfs-clocks";
> +				#clock-cells = <1>;
> +				clock-indices = <0>, <1>, <2>;
> +				clock-output-names = "vbig", "vlittle", "vgpu";

>From where do the clock names derive? They look more like names for
voltage domains rather than clocks. My (admittedly very old) Juno docs,
have the clocks as ATLCLK, APLCLK and GPUCLK.

> +			};
> +			scpi_clk: scpi_clocks@3 {
> +				compatible = "arm,scpi-variable-clocks";
> +				#clock-cells = <1>;
> +				clock-indices = <3>, <4>;
> +				clock-output-names = "pxlclk0", "pxlclk1";

Can we also have clock index 5, name 'i2s_clk', for used by audio?
(I don't know what other clocks the SCP currently supports, but audio is
one being currently used by the out-of-tree code).

Also, I believe that both display outputs share the same clock, and so
pxlclk0 and pxlclk1 can't be controlled independently. But I guess these
device-tree entries are for the interface to the SCP firmware, not the
hardware, and if that pretends the clocks are independent...

-- 
Tixy
