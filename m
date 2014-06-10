From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH Resend] cpufreq: tegra: update comment for clarity
Date: Tue, 10 Jun 2014 23:15:20 +0200
Message-ID: <2122590.Au0hJVo2lP@vostro.rjw.lan>
References: <594cf0e6982c471eb314fe4a00647bfaf59a3456.1402029512.git.viresh.kumar@linaro.org> <3eb9a48877bbb208f3c1f3e121f8d78b1d306bd9.1402376112.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:52602 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753000AbaFJU54 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 10 Jun 2014 16:57:56 -0400
In-Reply-To: <3eb9a48877bbb208f3c1f3e121f8d78b1d306bd9.1402376112.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, arvind.chauhan@arm.com, swarren@nvidia.com, dianders@chromium.org

On Tuesday, June 10, 2014 10:27:12 AM Viresh Kumar wrote:
> Tegra's driver got updated a bit (00917dd cpufreq: Tegra: implement intermediate
> frequency callbacks) and implements new 'intermediate freq' infrastructure of
> core. Above commit updated comments about when to call
> clk_prepare_enable(pll_x_clk) and Doug wasn't satisfied with those comments and
> said this:
> 
> > The "Though when target-freq is intermediate freq, we don't need to
> > take this reference." makes me think that this function is actually
> > called when target-freq is intermediate freq.  I don't think it is,
> > right?
> 
> For better clarity just make that comment more explicit about when we call
> tegra_target_intermediate().
> 
> Reviewed-by: Stephen Warren <swarren@nvidia.com>
> Reported-and-reviewed-by: Doug Anderson <dianders@chromium.org>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> Resend: Improved comment as suggested by Stephen.

Applied to bleeding-edge, thanks!

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
