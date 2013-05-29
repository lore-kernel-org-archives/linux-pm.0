From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH] cpufreq: MAINTAINERS: Add git tree path for ARM
 specific updates
Date: Wed, 29 May 2013 03:47:02 -0700
Message-ID: <1369824422.22004.101.camel@joe-AO722>
References: <aab5b5dc92b960e81e8fd1975eba81234a4ecac8.1369817795.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <aab5b5dc92b960e81e8fd1975eba81234a4ecac8.1369817795.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: rjw@sisk.pl, linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, robin.randhawa@arm.com, Steve.Bannister@arm.com, Liviu.Dudau@arm.com, charles.garcia-tobin@arm.com, arvind.chauhan@arm.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Wed, 2013-05-29 at 16:10 +0530, Viresh Kumar wrote:
> ARM specific patches would be
> Applied by me now. Rafael will pull in these changes from time to time (at
> rc's).
[]
> diff --git a/MAINTAINERS b/MAINTAINERS
[]
> @@ -2216,6 +2216,7 @@ L:	cpufreq@vger.kernel.org
[]
>  T:	git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
> +T:	git://git.linaro.org/people/vireshk/linux.git (For ARM Updates)

please prefix these with git

T:	git git://git.etc...

Every other T: git entry does.
