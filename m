From: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v7 2/4] cpufreq: ondemand: call dbs_check_cpu only when
	necessary
Date: Thu, 31 Jan 2013 14:12:29 +0530
Message-ID: <CAKohpokR7-P9BarUwW++Exh8RyHUYFHO4V80+zHqcA-zwCOurg@mail.gmail.com>
References: <1359550803-18577-1-git-send-email-fabio.baltieri@linaro.org>
	<1359550803-18577-3-git-send-email-fabio.baltieri@linaro.org>
	<CAKohpok0iDffNM31W2r97Wtq4DR+TdPwYWTAdJH7AyLqHm0UPA@mail.gmail.com>
	<20130130164614.GC30559@balto.lan>
	<CAKohponMezzus0tRW+CdC7wLq1U1pRio5q=g6F845x7iveFCAA@mail.gmail.com>
	<20130131083825.GA30667@balto.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
In-Reply-To: <20130131083825.GA30667-lYxsXyORJ9v/PtFMR13I2A@public.gmane.org>
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

On 31 January 2013 14:09, Fabio Baltieri <fabio.baltieri-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
> Ok, now I see the problem: cdbs->cpu is initialized only on the leader
> cpu and this is working by coincidence on my system, while
> cdbs->time_stamp is initialized only on the leader cpu, and that should
> be correct even when cpu hotplugging as that's reinitialized every time.
>
> That's a fix so I'll send a patch just to set ->cpu into the
> for_each_cpu cycle.

That's not enough. You need to set ->cpu to j and not policy->cpu as we
discussed it earlier (params to timer init and exit.).

And so, we need to get policy->cpu somehow and get its timestamp.
