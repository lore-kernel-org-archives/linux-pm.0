From: "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>
Subject: Re: [PATCH 1/2] cpufreq: return early from __cpufreq_driver_getavg()
Date: Thu, 25 Oct 2012 00:02:17 +0200
Message-ID: <112621141.CGPLIkkgz1@vostro.rjw.lan>
References: <32e5bed743cc6cc4e614291a7080299f5f0d0933.1350677395.git.viresh.kumar@linaro.org>
	<2737823.2JYE7UmLRN@vostro.rjw.lan>
	<CAKohponGwhC_zmk1Whq56vmZMvjcxXKiSpdvMk4ZU8z0Wa2TBw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
In-Reply-To: <CAKohponGwhC_zmk1Whq56vmZMvjcxXKiSpdvMk4ZU8z0Wa2TBw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
Cc: linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, cpufreq-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, pdsw-power-team-5wv7dgnIgG8@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Saturday 20 of October 2012 10:12:07 Viresh Kumar wrote:
> On Oct 20, 2012 3:37 AM, "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org> wrote:
> >
> > On Saturday 20 of October 2012 01:42:05 Viresh Kumar wrote:
> > > There is no need to do cpufreq_get_cpu() and cpufreq_put_cpu() for
> drivers that
> > > don't support getavg() routine.
> > >
> > > Signed-off-by: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> >
> > The patch doesn't seem to follow the changelog or the other way around.
> 
> Sorry if my log isn't clear enough.
> But i could still see it matching the code :)
> 
> I have moved the check for drivers capabilities at the top
> of routine, so that there is no need to call mentioned routines.

OK

Applied to linux-pm.git/linux-next as v3.8 material.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
