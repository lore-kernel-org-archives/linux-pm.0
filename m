From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH] cpufreq: Simplify __cpufreq_remove_dev()
Date: Thu, 10 Jan 2013 15:54:23 +0800
Message-ID: <20130110075422.GA11458@S2101-09.ap.freescale.net>
References: <aa10abe640afed8700abf262dbfc9b9c22659b6a.1357729671.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <cpufreq-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <aa10abe640afed8700abf262dbfc9b9c22659b6a.1357729671.git.viresh.kumar@linaro.org>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: rjw@sisk.pl, robin.randhawa@arm.com, Steve.Bannister@arm.com, Liviu.Dudau@arm.com, linaro-dev@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wed, Jan 09, 2013 at 04:50:44PM +0530, Viresh Kumar wrote:
> @Shawn: I believe your driver don't require that ugly code anymore (Though i
> know there is a situation for that to happen, if we have two cpus, you remove
> second one and then add it back. With this cpufreq_add_dev() would call init()
> first and then try to match if there are any managed_policies present. But the
> issue you pointed out about unregistering the driver would be solved by this
> patch.)

Yes, just played it and it works for me.  However, I would have to keep
that little ugly code in my patch to save the dependency on your patch.
Will send a follow-up to clean that up once your patch hits mainline.

Shawn

