From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V2 4/5] cpufreq: create cpu/cpufreq/policyX directories
Date: Thu, 15 Oct 2015 23:35:13 +0200
Message-ID: <2299822.iEchLYNLbS@vostro.rjw.lan>
References: <cover.1444924623.git.viresh.kumar@linaro.org> <594e7c8e74ca56cef58d29327518f5223e89e208.1444924623.git.viresh.kumar@linaro.org> <561FFDA7.3080903@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:44212 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751134AbbJOVGa (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 15 Oct 2015 17:06:30 -0400
In-Reply-To: <561FFDA7.3080903@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Saravana Kannan <skannan@codeaurora.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, open list <linux-kernel@vger.kernel.org>

On Thursday, October 15, 2015 12:25:27 PM Saravana Kannan wrote:
> On 10/15/2015 09:05 AM, Viresh Kumar wrote:
> > The cpufreq sysfs interface had been a bit inconsistent as one of the
> > CPUs for a policy had a real directory within its sysfs 'cpuX' directory
> > and all other CPUs had links to it. That also made the code a bit
> > complex as we need to take care of moving the sysfs directory if the CPU
> > containing the real directory is getting physically hot-unplugged.
> >
> > Solve this by creating 'policyX' directories (per-policy) in
> > /sys/devices/system/cpu/cpufreq/ directory, where X is the CPU for which
> > the policy was first created.
> >
> > This also removes the need of keeping kobj_cpu and we can remove it now.
> >
> > Suggested-by: Saravana Kannan <skannan@codeaurora.org>
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> 
> 
> Since you've added a separate patch for making policyX more consistent:
> Reviewed-by: Saravana Kannan <skannan@codeaurora.org>
> 
> Btw, does a Review-by have an implicit Acked-by?

Yes it does, at least as far as I'm concerned.

Thanks,
Rafael

