From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2] cpufreq: intel_pstate: fix inconsistency in setting policy limits
Date: Thu, 07 Apr 2016 01:35:30 +0200
Message-ID: <1834397.4eHOMtmJt5@vostro.rjw.lan>
References: <1459737731-7386-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:55035 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751732AbcDFXdA (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 6 Apr 2016 19:33:00 -0400
In-Reply-To: <1459737731-7386-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: linux-pm@vger.kernel.org

On Sunday, April 03, 2016 07:42:11 PM Srinivas Pandruvada wrote:
> When user sets performance policy using cpufreq interface, it is possible
> that because of policy->max limits, the actual performance is still
> limited. But the current implementation will silently switch the
> policy to powersave and start using powersave limits. If user modifies
> any limits using intel_pstate sysfs, this is actually changing powersave
> limits.
> 
> The current implementation tracks limits under powersave and performance
> policy using two different variables. When policy->max is less than
> policy->cpuinfo.max_freq, only powersave limit variable is used.
> 
> This fix involves uses performance limits variable always when policy
> is performance.
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Applied, thanks!

