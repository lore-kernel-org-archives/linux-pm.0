From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 0/2 v3] cpufreq, intel_pstate, Fix rounding errors
Date: Mon, 23 Nov 2015 23:46:52 +0100
Message-ID: <2027172.WjPytztbaV@vostro.rjw.lan>
References: <1448063277-12446-1-git-send-email-prarit@redhat.com> <20151121023111.GG3957@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:58186 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752102AbbKWWRP (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 23 Nov 2015 17:17:15 -0500
In-Reply-To: <20151121023111.GG3957@ubuntu>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Prarit Bhargava <prarit@redhat.com>, Srinivas Pandruvada <srinivas.pandruvada@intel.com>
Cc: Len Brown <len.brown@intel.com>, Alexandra Yates <alexandra.yates@intel.com>, Kristen Carlson Accardi <kristen@linux.intel.com>, linux-pm@vger.kernel.org

On Saturday, November 21, 2015 08:01:11 AM Viresh Kumar wrote:
> On 20-11-15, 18:47, Prarit Bhargava wrote:
> > [v2]: Separate into two patches, and rebase onto git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
> > [v3]: calculate limits->max_policy_pct once
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Both patches applied, thanks!

Rafael

