Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F600233937;
	Wed, 15 Jul 2026 20:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784148300; cv=none; b=oS6ro56MdHOTUPJVTOFJkpBa9VAL0VJ3I3k1yVueUMViKafbfaHoGXs9eHjwtDwSeyuTS/UvZqhN8+jLRvNNFK2M2w7fcc3r0SFM09xAxxFUyThJ6mjT4zOPE7gpR1bw9h4/4NaqqTw+iEIiRnhMRR7gEhnaDtQekOZjRwXPey0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784148300; c=relaxed/simple;
	bh=1bY+/qyX2LuBpanRkW7vAYLGDdzcDlgYpRZK4fiJYiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s8mb6NdoGUzxt83adNal1H2SFTEutu9uqNmIFPRiVFC9MZmaEkDIVOkxOPK//n3DNF/XQMR0l/apMdUpxv5W4a8ocVHZsxL4DHKtzkYnWKjoODYjDFxg8aqNFl0cjBTkN6HlUOJX50zSswKyxYtzv0GElkjkb0rKHL3uokhYkTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c6mvsBnM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c6mvsBnM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC4CB1F000E9;
	Wed, 15 Jul 2026 20:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784148299;
	bh=nP0r16HI0g8TlAa23nMBM941RGjBe5Aem38C/sHAXXw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=c6mvsBnMITSp/9lTkwua8C95fb+syxVGbWN7QlyXTQMGlCdEy89PJtuuklmq4Pv6i
	 T00BrxbzCwTgnrj7scdsxeQ276G9db+Q8IDbrkqQQvlxN0AGogBj8IywDjIX7jtLu7
	 Ebe/IpB7HxR1CD+CMhhNhagDpgK2iT2h+Cm4Gx+o0Ean3Krd7vlsCcKXVgfZlW68Wc
	 qkFinVYjJgePyNgMp/B4Wo1PI4hx2vvJCpMECBxFW79D01YblOG0Mh/3fPzkEmWLUz
	 h28Chkn/MREjusF9fceulMNbSgQCxV6uXrxdWw/fsPviNNiEdkho3VLlaGjectISux
	 5yv+upBmcFBpw==
Date: Wed, 15 Jul 2026 15:44:55 -0500
From: Bjorn Andersson <andersson@kernel.org>
To: Pragnesh Papaniya <pragnesh.papaniya@oss.qualcomm.com>
Cc: Sudeep Holla <sudeep.holla@kernel.org>, 
	Cristian Marussi <cristian.marussi@arm.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Sibi Sankar <sibi.sankar@oss.qualcomm.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, 
	Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, 
	Dmitry Osipenko <digetx@gmail.com>, Thierry Reding <thierry.reding@kernel.org>, 
	Jonathan Hunter <jonathanh@nvidia.com>, Konrad Dybcio <konradybcio@kernel.org>, 
	Rajendra Nayak <rajendra.nayak@oss.qualcomm.com>, Pankaj Patil <pankaj.patil@oss.qualcomm.com>, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, arm-scmi@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-tegra@vger.kernel.org, Amir Vajid <amir.vajid@oss.qualcomm.com>, 
	Ramakrishna Gottimukkula <ramakrishna.gottimukkula@oss.qualcomm.com>
Subject: Re: [PATCH RFC v7 7/9] PM / devfreq: Introduce the QCOM SCMI Memlat
 devfreq driver
Message-ID: <alfs7gOhE2D8wbVX@baldur>
References: <20260610-rfc_v7_scmi_memlat-v7-0-f3f68c608f25@oss.qualcomm.com>
 <20260610-rfc_v7_scmi_memlat-v7-7-f3f68c608f25@oss.qualcomm.com>
 <akWBtfG1j7-53fec@baldur>
 <ee407cbf-3476-4209-ad40-b381535b94ac@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ee407cbf-3476-4209-ad40-b381535b94ac@oss.qualcomm.com>

On Tue, Jul 14, 2026 at 01:14:23AM +0530, Pragnesh Papaniya wrote:
> 
> 
> On 02-Jul-26 10:51 PM, Bjorn Andersson wrote:
> > On Wed, Jun 10, 2026 at 02:21:34PM +0530, Pragnesh Papaniya wrote:
> >> From: Sibi Sankar <sibi.sankar@oss.qualcomm.com>
> >>
> >> On Qualcomm Glymur, Mahua and X1E/X1P (Hamoa) SoCs, the memlat governor and
> >> the mechanism to control the various caches and RAM is hosted on the CPU
> >> Control Processor (CPUCP), and configuration and control of this governor
> >> is exposed through the QCOM SCMI Generic Extension Protocol, addressed via
> >> the "MEMLAT" algorithm string.
> >>
> > 
> > This explains that there's a bunch of functionality running on CPUCP and
> > there's a "MEMLAT" string.
> > 
> 
> CPUCP does all the real work: it samples CPU perf counters, computes IPM/stall,
> and votes the DDR/LLCC/DDR_QOS buses on its own timer. The Linux driver only
> pushes static configuration (freq maps, ceilings) once at probe and
> starts/stops the CPUCP timer. I'll rewrite the message to say this plainly.
> 

Thank you, that was not clear from reading this patch.

> >> Introduce a devfreq SCMI client driver that uses the MEMLAT algorithm
> >> string to detect memory-latency-bound workloads and control the
> >> frequency/level of the memory buses (DDR, LLCC and DDR_QOS).
> > 
> > You established that there's stuff running in the firmware, now we're
> > introducing a client driver to control memory buses.
> > 
> > But where did you explain how these two "facts" are related? Why is
> > there a client driver, what is the actual distribution of roles in this
> > dance?
> > 
> 
> At runtime the driver is not in the control loop, CPUCP is. devfreq is used so
> each bus shows up as a real device with trans_stat and the remote governor's
> parameters like sample_ms and ipm_ceil are user-configurable. I'll make that
> reasoning explicit in the commit text.
> 

Are you saying that there's no actual devfreq'ing going on, we just
expose it through that framework in order to get the standardized
metrics out of sysfs?

Or that and to perform the initial configuration and start the memlat
logic? Does the firmware do memlat adjustments without this driver?

Please make sure that it's clear what role this driver has.

[..]
> >> diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
> >> index 2caa87554914..98b5a50d3189 100644
> >> --- a/drivers/devfreq/Kconfig
> >> +++ b/drivers/devfreq/Kconfig
> >> @@ -169,6 +169,19 @@ config ARM_SUN8I_A33_MBUS_DEVFREQ
> >>  	  This adds the DEVFREQ driver for the MBUS controller in some
> >>  	  Allwinner sun8i (A33 through H3) and sun50i (A64 and H5) SoCs.
> >>  
> >> +config SCMI_QCOM_MEMLAT_DEVFREQ
> >> +	tristate "Qualcomm Technologies Inc. SCMI client driver"
> >> +	depends on QCOM_SCMI_GENERIC_EXT || COMPILE_TEST
> >> +	select DEVFREQ_GOV_REMOTE
> >> +	help
> >> +	  This driver uses the MEMLAT (memory latency) algorithm string
> > 
> > Is "driver uses X algorithm string" idiomatic SCMI terms?
> > 
> 
> No, "algorithm string" is an internal term. I'll drop the jargon and describe
> it in plain SCMI vendor-protocol terms.
> 

In line with our discussion above, please make sure that the help text
is helpful for someone to understand the purpose of the driver and help
them make that y/m/n decision.

> >> +	  hosted on QCOM SCMI Vendor Protocol to detect memory latency
> >> +	  workloads and control frequency/level of the various memory
> >> +	  buses (DDR/LLCC/DDR_QOS).
> >> +
> >> +	  This driver defines/documents the parameter IDs used while configuring
> >> +	  the memory buses.
> > 
> > Imagine an person outside your team, sitting there in menuconfig
> > wondering if they should enable this driver or not.
> > 
> > There's a sentence in the middle ("control frequency/level of various
> > memory buses" - that sounds like something I want. But "detect memory
> > latency", is it just monitoring or does that part relate to the
> > controlling part? "This driver defines" so what are those parameters
> > used for, do I need some other driver for the control part? Is this last
> > paragraph adding value to my understanding for that
> > CONFIG_SCMI_QCOM_MEMLAT_DEVFREQ does?
> > 
> 
> I'll rewrite it to say what you get (memory-bus scaling on these Qualcomm
> SoCs), that CPUCP does the actual scaling, and that nothing else is required
> to enable it. The parameter-ID paragraph will go.
> 

Sounds good. I'm a bit puzzled about it being a devfreq driver, but if
you can explain the bigger picture, I think that will help to reason
about it.

[..]
> >> diff --git a/drivers/devfreq/scmi-qcom-memlat-cfg.h b/drivers/devfreq/scmi-qcom-memlat-cfg.h
> >> new file mode 100644
> >> index 000000000000..1ab8b61ea271
> >> --- /dev/null
> >> +++ b/drivers/devfreq/scmi-qcom-memlat-cfg.h
> > 
> > Are the entities declared in this header file used by anything other
> > than scmi-qcom-memlat-devfreq.c? If not why is it a separate header file?
> > 
> 
> No, only scmi-qcom-memlat-devfreq.c uses it. I split it out just to keep the
> large config tables out of the driver logic. Happy either way: do you prefer
> I fold it back into the .c, or keep it as a header?
> 

Please move it into the c-file, move things around so that you have
clear segments of "definitions", "configuration", "logic", and "driver
boilerplate".

[..]
> >> +struct scmi_qcom_monitor_cfg {
> >> +	const struct scmi_qcom_map_table *table;
> >> +	const char *name;
> >> +	u32 be_stall_floor;
> > 
> > What is a "be stall floor"? Also, it seems to be 1 in all your cases. Is
> > it boolean? Is it constant?
> > 
> 
> It's a back-end-stall percentage threshold. It happens to be 1 in all current
> configs (meaning almost any stall qualifies). I'll document it as a percent.
> 

back_end_stall_percentage is a bit log (and I'm not entirely sure that
it is). Perhaps you can provide some kernel-doc and express what it is?

[..]

> >> +static const struct scmi_qcom_memory_cfg glymur_memory_cfg[] = {
> >> +	{
> >> +		.memory_type = MEMLAT_HW_DDR,
> >> +		.name = "ddr",
> >> +		.mem_table = glymur_ddr_table,
> >> +		.num_opps = ARRAY_SIZE(glymur_ddr_table),
> >> +		.grp_ev = glymur_ddr_grp_ev,
> >> +		.monitor_cnt = 4,
> >> +		.memory_range = { .min_freq = 547000, .max_freq = 4761000},
> >> +		.monitor_cfg = (const struct scmi_qcom_monitor_cfg[]) {
> >> +			{
> >> +				.name = "mon_0",
> >> +				.cpu_mask = 0x3f,
> >> +				.ipm_ceil = 60000000,
> >> +				.be_stall_floor = 1,
> >> +				.table_len = 8,
> >> +				.table = (const struct scmi_qcom_map_table[]) {
> >> +					{ .cpu_freq = 960, .mem_freq = 547000 },
> >> +					{ .cpu_freq = 1133, .mem_freq = 1353000 },
> >> +					{ .cpu_freq = 1594, .mem_freq = 1555000 },
> >> +					{ .cpu_freq = 1920, .mem_freq = 1708000 },
> >> +					{ .cpu_freq = 2228, .mem_freq = 2736000 },
> >> +					{ .cpu_freq = 2362, .mem_freq = 3187000 },
> >> +					{ .cpu_freq = 2650, .mem_freq = 3686000 },
> >> +					{ .cpu_freq = 2938, .mem_freq = 4761000 },
> > 
> > Why are these tables hard coded in the driver? Are they constant?
> > 
> 
> These tables can be either in DT (like in earlier re-spins of the series) or in
> the driver. For the former to work well with the existing OPP framework, we
> would need a clock provider created for DDR/LLCC/DDR-QOS just to derive the
> cpufreq to memfreq map tables. Having it in the driver simplifies the overall
> implementation. 
> 

But are there not different SKUs of these SoCs which need different
tables? Information that we today would encode in e.g. OPP-tables in
DeviceTree.

> >> +				}
> >> +			},
[..]
> >> diff --git a/drivers/devfreq/scmi-qcom-memlat-devfreq.c b/drivers/devfreq/scmi-qcom-memlat-devfreq.c
[..]
> >> +	for (i = 0; i < info->memory_cnt; i++) {
> >> +		struct scmi_qcom_memory_info *memory = info->memory[i];
> >> +		struct platform_device *pdev = memory->pdev;
> >> +		struct devfreq_dev_profile *profile = &memory->profile;
> >> +
> >> +		/* sampling time should be double the devfreq observing time */
> > 
> > That's interesting, tell me more...
> > 
> 
> This follows Lukasz's earlier point on Nyquist criterion: sample about 2x
> faster than the changes you want to observe. CPUCP updates every
> cpucp_sample_ms, so the devfreq poll runs at half that (sample_ms / 2) to
> actually catch the transitions in trans_stat.
> 

While that's true for sampling in general, please make the comment
explain why it's true in this case.

Regards,
Bjorn
