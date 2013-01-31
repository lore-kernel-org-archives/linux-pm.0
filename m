From: Fabio Baltieri <fabio.baltieri@linaro.org>
Subject: Re: [PATCH 2/2] cpufreq: governors: Remove code redundancy between
 governors
Date: Thu, 31 Jan 2013 19:50:04 +0100
Message-ID: <20130131185004.GB20164@balto.lan>
References: <09a94ff044ff6a6f7a5d953c3b1f3102c1dc50cf.1359653181.git.viresh.kumar@linaro.org>
 <118c59263751862b1750ed9f96639a4e70069e66.1359653181.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <cpufreq-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <118c59263751862b1750ed9f96639a4e70069e66.1359653181.git.viresh.kumar@linaro.org>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: rjw@sisk.pl, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-dev@lists.linaro.org, robin.randhawa@arm.com, Steve.Bannister@arm.com, Liviu.Dudau@arm.com
List-Id: linux-pm@vger.kernel.org

On Thu, Jan 31, 2013 at 10:58:02PM +0530, Viresh Kumar wrote:
> With the inclusion of following patches:
> 
> 9f4eb10 cpufreq: conservative: call dbs_check_cpu only when necessary
> 772b4b1 cpufreq: ondemand: call dbs_check_cpu only when necessary
> 
> code redundancy is introduced again. Get rid of it.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---

Hi,

Tested-by: Fabio Baltieri <fabio.baltieri@linaro.org>

Thanks,
Fabio

-- 
Fabio Baltieri
