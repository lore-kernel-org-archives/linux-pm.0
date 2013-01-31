From: Fabio Baltieri <fabio.baltieri-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/2] cpufreq: governors: Get rid of dbs_data->enable field
Date: Thu, 31 Jan 2013 19:44:49 +0100
Message-ID: <20130131184449.GA20164@balto.lan>
References: <09a94ff044ff6a6f7a5d953c3b1f3102c1dc50cf.1359653181.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <09a94ff044ff6a6f7a5d953c3b1f3102c1dc50cf.1359653181.git.viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
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
Cc: linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, cpufreq-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rjw-KKrjLPT3xs0@public.gmane.org, Steve.Bannister-5wv7dgnIgG8@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Thu, Jan 31, 2013 at 10:58:01PM +0530, Viresh Kumar wrote:
> CPUFREQ_GOV_START/STOP are called only once for all policy->cpus and hence we
> don't need to adapt cpufreq_governor_dbs() routine for multiple calls.
> 
> So, this patch removes dbs_data->enable field entirely. And rearrange code a
> bit.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> ---
> Hi Fabio,
> 
> I have fixed all the pending issues, but haven't checked these patches. Can you
> please add your tested-by (obviously after testing them) ?
> 
> Compile tested only.

Hello Viresh, thanks for getting this done... looks much cleaner now!

I tested both patches on my ux500 setup (dual Cortex-A9) and it seems to
run correctly on both CPU load changes and CPU hotplug, so:

Tested-by: Fabio Baltieri <fabio.baltieri-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

As a sidenote, I noticed just now that since:

bc92bea cpufreq: Notify governors when cpus are hot-[un]plugged

governor's sampling_rate gets reset to default every time you hotplug a
CPU (the one you read/write on
/sys/devices/system/cpu/cpufreq/ondemand/sampling_rate).

If you need further tests, I'll be back on Monday.

Thanks,
Fabio

-- 
Fabio Baltieri
