From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 12/17] cpufreq: dt: Pass regulator name to the OPP core
 for V1 bindings
Date: Tue, 12 Jan 2016 12:41:59 +0530
Message-ID: <20160112071159.GO1084@ubuntu>
References: <cover.1450777582.git.viresh.kumar@linaro.org>
 <981905b802879bff26d839b0aab19ad67a3aa1ff.1450777582.git.viresh.kumar@linaro.org>
 <20160112015328.GQ22188@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f172.google.com ([209.85.192.172]:36552 "EHLO
	mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759441AbcALHME (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 12 Jan 2016 02:12:04 -0500
Received: by mail-pf0-f172.google.com with SMTP id n128so58198151pfn.3
        for <linux-pm@vger.kernel.org>; Mon, 11 Jan 2016 23:12:03 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20160112015328.GQ22188@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, nm@ti.com

On 11-01-16, 17:53, Stephen Boyd wrote:
> On 12/22, Viresh Kumar wrote:
> > OPP core can handle the regulators by itself, and it allocates the
> > regulator based on device's name. But for older V1 bindings, many DT
> > files have used names like 'cpu-supply' instead of 'cpu0-supply'.
> > 
> > The cpufreq-dt driver needs to tell the right name of the regulator in
> > this case to the OPP core.
> > 
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> 
> This whole patch is confusing to me because old style was to be
> cpu0-supply, and new style is cpu-supply.

Long back we used to have cpu0-supply, then while I converted
cpufreq-dt to support multiple clusters, you asked me to name it to
cpu-supply, which I did.

Now, looking at the implementation into the generic OPP layer, it
looks like <device>-name is a far better and reasonable choice.

And so I am moving back to cpu0-supply, will udpate binding doc as
well.

-- 
viresh
