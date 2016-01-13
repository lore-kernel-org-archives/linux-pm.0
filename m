From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH 12/17] cpufreq: dt: Pass regulator name to the OPP core
 for V1 bindings
Date: Tue, 12 Jan 2016 16:43:35 -0800
Message-ID: <20160113004335.GD22188@codeaurora.org>
References: <cover.1450777582.git.viresh.kumar@linaro.org>
 <981905b802879bff26d839b0aab19ad67a3aa1ff.1450777582.git.viresh.kumar@linaro.org>
 <20160112015328.GQ22188@codeaurora.org>
 <20160112071159.GO1084@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:55032 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753162AbcAMAnh (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 12 Jan 2016 19:43:37 -0500
Content-Disposition: inline
In-Reply-To: <20160112071159.GO1084@ubuntu>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, nm@ti.com, Mark Brown <broonie@kernel.org>

On 01/12, Viresh Kumar wrote:
> On 11-01-16, 17:53, Stephen Boyd wrote:
> > On 12/22, Viresh Kumar wrote:
> > > OPP core can handle the regulators by itself, and it allocates the
> > > regulator based on device's name. But for older V1 bindings, many DT
> > > files have used names like 'cpu-supply' instead of 'cpu0-supply'.
> > > 
> > > The cpufreq-dt driver needs to tell the right name of the regulator in
> > > this case to the OPP core.
> > > 
> > > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > 
> > This whole patch is confusing to me because old style was to be
> > cpu0-supply, and new style is cpu-supply.
> 
> Long back we used to have cpu0-supply, then while I converted
> cpufreq-dt to support multiple clusters, you asked me to name it to
> cpu-supply, which I did.
> 
> Now, looking at the implementation into the generic OPP layer, it
> looks like <device>-name is a far better and reasonable choice.

It's far easier to implement, but not far better. In most designs
the pin is not called <device_name>-supply, but something more
mundane like vdd-supply, vddio-supply, vcc-supply, etc. In the
case of CPUs, there's probably nothing in the datasheets, so cpu
vs cpu0 is not too important to distinguish here. But for things
like a GPU, DSP, video encoder, etc. I doubt it's going to be
called <device_name>-supply, so making that the norm is
misguided.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
