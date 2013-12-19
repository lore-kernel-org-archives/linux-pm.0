From: Tomasz Figa <t.figa@samsung.com>
Subject: Re: [PATCH v12 4/4] ARM: dts: Exynos5420: Add device nodes for TMU
 blocks
Date: Thu, 19 Dec 2013 12:39:04 +0100
Message-ID: <1504232.pi5nrQckF4@amdc1227>
References: <1382004240-3282-1-git-send-email-l.krishna@samsung.com>
 <1387433222-7893-1-git-send-email-ch.naveen@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1387433222-7893-1-git-send-email-ch.naveen@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
Cc: linux-pm@vger.kernel.org, naveenkrishna.ch@gmail.com, rui.zhang@intel.com, eduardo.valentin@ti.com, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, amit.daniel@samsung.com, kgene.kim@samsung.com, devicetree@vger.kernel.org, b.zolnierkie@samsung.com, cpgs@samsung.com
List-Id: linux-pm@vger.kernel.org

Hi Naveen,

On Thursday 19 of December 2013 11:37:02 Naveen Krishna Chatradhi wrote:
> Exynos5420 SoC has per core thermal management unit.
> 5 TMU channels 4 for CPUs and 5th for GPU.
> 
> This patch adds the device tree nodes to the DT device list.
> 
> Nodes carry the misplaced second base address and the second
> clock to access the misplaced base address.
[snip]
>  		samsung,power-domain = <&gsc_pd>;
>  	};
> +
> +	tmu_cpu0:tmu@10060000 {

CodingStyle: Missing space after colon.
+ all the nodes below.

Since it's just a minor fixup, I think you could just reply to this
thread with corrected version of this single patch instead of
respinning the whole series.

Best regards,
Tomasz

> +		compatible = "samsung,exynos5420-tmu";
> +		reg = <0x10060000 0x100>;
> +		interrupts = <0 65 0>;
> +		clocks = <&clock 318>;
> +		clock-names = "tmu_apbif";
> +	};
> +
> +	tmu_cpu1:tmu@10064000 {
> +		compatible = "samsung,exynos5420-tmu";
> +		reg = <0x10064000 0x100>;
> +		interrupts = <0 183 0>;
> +		clocks = <&clock 318>;
> +		clock-names = "tmu_apbif";
> +	};
> +
> +	tmu_cpu2:tmu@10068000 {
> +		compatible = "samsung,exynos5420-tmu-ext-triminfo";
> +		reg = <0x10068000 0x100>, <0x1006c000 0x4>;
> +		interrupts = <0 184 0>;
> +		clocks = <&clock 318>, <&clock 318>;
> +		clock-names = "tmu_apbif", "tmu_triminfo_apbif";
> +	};
> +
> +	tmu_cpu3:tmu@1006c000 {
> +		compatible = "samsung,exynos5420-tmu-ext-triminfo";
> +		reg = <0x1006c000 0x100>, <0x100a0000 0x4>;
> +		interrupts = <0 185 0>;
> +		clocks = <&clock 318>, <&clock 319>;
> +		clock-names = "tmu_apbif", "tmu_triminfo_apbif";
> +	};
> +
> +	tmu_gpu:tmu@100a0000 {
> +		compatible = "samsung,exynos5420-tmu-ext-triminfo";
> +		reg = <0x100a0000 0x100>, <0x10068000 0x4>;
> +		interrupts = <0 215 0>;
> +		clocks = <&clock 319>, <&clock 318>;
> +		clock-names = "tmu_apbif", "tmu_triminfo_apbif";
> +	};
>  };
> 
