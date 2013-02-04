From: "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>
Subject: Re: [PATCH 0/4] CPUFreq: Implement per policy instances of governors
Date: Mon, 04 Feb 2013 13:17:04 +0100
Message-ID: <5808458.pvV2iHpBWm@vostro.rjw.lan>
References: <cover.1359976493.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
In-Reply-To: <cover.1359976493.git.viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <http://lists.linaro.org/mailman/options/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/linaro-dev>
List-Post: <mailto:linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
List-Help: <mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linaro.org/mailman/listinfo/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=subscribe>
Sender: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
Errors-To: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
To: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Steve.Bannister-5wv7dgnIgG8@public.gmane.org, linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, cpufreq-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Monday, February 04, 2013 05:08:50 PM Viresh Kumar wrote:
> Currently, there can't be multiple instances of single governor_type. If we have
> a multi-package system, where we have multiple instances of struct policy (per
> package), we can't have multiple instances of same governor. i.e. We can't have
> multiple instances of ondemand governor for multiple packages.
> 
> Governors directory in sysfs is created at /sys/devices/system/cpu/cpufreq/
> governor-name/. Which again reflects that there can be only one instance of a
> governor_type in the system.
> 
> This is a bottleneck for multicluster system, where we want different packages
> to use same governor type, but with different tunables.
> 
> This patchset is inclined towards fixing this issue.
> 
> Viresh Kumar (4):
>   cpufreq: Don't check cpu_online(policy->cpu)
>   cpufreq: stats: Get rid of CPUFREQ_STATDEVICE_ATTR
>   cpufreq: Add per policy governor-init/exit infrastructure
>   cpufreq: governor: Implement per policy instances of governors

Well, [1-2/4] are things I can take for v3.9 no problem.  The other two I'd
wait for the next cycle to be honest.  We already have 30+ cpufreq patches
scheduled for v3.9 and some of them quite subtle for that matter.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
