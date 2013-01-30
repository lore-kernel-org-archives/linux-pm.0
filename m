From: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v7 2/4] cpufreq: ondemand: call dbs_check_cpu only when
	necessary
Date: Wed, 30 Jan 2013 22:41:08 +0530
Message-ID: <CAKohponMezzus0tRW+CdC7wLq1U1pRio5q=g6F845x7iveFCAA@mail.gmail.com>
References: <1359550803-18577-1-git-send-email-fabio.baltieri@linaro.org>
	<1359550803-18577-3-git-send-email-fabio.baltieri@linaro.org>
	<CAKohpok0iDffNM31W2r97Wtq4DR+TdPwYWTAdJH7AyLqHm0UPA@mail.gmail.com>
	<20130130164614.GC30559@balto.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
In-Reply-To: <20130130164614.GC30559-lYxsXyORJ9v/PtFMR13I2A@public.gmane.org>
List-Unsubscribe: <http://lists.linaro.org/mailman/options/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/linaro-dev>
List-Post: <mailto:linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
List-Help: <mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linaro.org/mailman/listinfo/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=subscribe>
Sender: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
Errors-To: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
To: Fabio Baltieri <fabio.baltieri-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Nicolas Pitre <nicolas.pitre-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, cpufreq-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>, Joseph Lo <josephl-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On 30 January 2013 22:16, Fabio Baltieri <fabio.baltieri-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
> Isn't that how it works now?  The current cpu ktime is not checked
> against its own, but against the "leader" cpu (dbs_info_local->cdbs.cpu),
> that's why it's initialized only for the first.
>
> Maybe I should have used dbs_info_leader/dbs_info instead of
> dbs_info_local/dbs_info.

This routine is called as wq handler. Which will recover dbs_info from work
using container_of. Which would give dbs_info_local for the cpu j.

Then we will execute below code.

+       /* use leader CPU's dbs_info */
+       dbs_info = &per_cpu(od_cpu_dbs_info, dbs_info_local->cdbs.cpu);

dbs_info_local->cdbs.cpu was uninitialized for all cpus except policy->cpu.
And so, might be initialized with 0 as its a global variable... But if you
offline cpu 0 and online it back, then policy->cpu would be 1 and this logic,
which worked by mistake will fail.

+       mutex_lock(&dbs_info->cdbs.timer_mutex);
+
+       time_now = ktime_get();
+       delta_us = ktime_us_delta(time_now, dbs_info->cdbs.time_stamp);

and so as this.

Correct?
