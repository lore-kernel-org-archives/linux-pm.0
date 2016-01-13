From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 12/17] cpufreq: dt: Pass regulator name to the OPP core
 for V1 bindings
Date: Wed, 13 Jan 2016 11:17:50 +0530
Message-ID: <20160113054750.GD6050@ubuntu>
References: <cover.1450777582.git.viresh.kumar@linaro.org>
 <981905b802879bff26d839b0aab19ad67a3aa1ff.1450777582.git.viresh.kumar@linaro.org>
 <20160112015328.GQ22188@codeaurora.org>
 <20160112071159.GO1084@ubuntu>
 <20160113004335.GD22188@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f177.google.com ([209.85.192.177]:36004 "EHLO
	mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754979AbcAMFr4 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 13 Jan 2016 00:47:56 -0500
Received: by mail-pf0-f177.google.com with SMTP id n128so75292106pfn.3
        for <linux-pm@vger.kernel.org>; Tue, 12 Jan 2016 21:47:56 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20160113004335.GD22188@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, nm@ti.com, Mark Brown <broonie@kernel.org>

On 12-01-16, 16:43, Stephen Boyd wrote:
> It's far easier to implement, but not far better. In most designs
> the pin is not called <device_name>-supply, but something more
> mundane like vdd-supply, vddio-supply, vcc-supply, etc. In the
> case of CPUs, there's probably nothing in the datasheets, so cpu
> vs cpu0 is not too important to distinguish here. But for things
> like a GPU, DSP, video encoder, etc. I doubt it's going to be
> called <device_name>-supply, so making that the norm is
> misguided.

I completely agree with that, but here is the usecase:
- A OPP-user driver doesn't need to call any special OPP API and OPP
  layer can allocate the regulator for it using <device>-name. This
  will make all drivers (that follow this nomenclature in DT) very
  simple and straight-forward.
- But then there are drivers, which need special supply-name. They can
  always call opp-set-regulator API to mention that, no one is
  stopping them from that.

And so I still believe, OPP layer has only this option to do it
generically.

Comments ?

-- 
viresh
