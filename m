From: "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>
Subject: Re: [PATCH 1/2] cpufreq: Fix sparse warnings by updating cputime64_t
	to u64
Date: Fri, 26 Oct 2012 02:10:31 +0200
Message-ID: <19880294.YnAYKpG7dr@vostro.rjw.lan>
References: <93ed702aba4c33d9a477c7296c59cc2882e16f82.1351064553.git.viresh.kumar@linaro.org>
	<1829614.cr6YHfW4bW@vostro.rjw.lan>
	<CAKohpo=Sw6eUP6Xk3=a=rk6WMJQta=T7ReBPM+7e9E5PsvMJgg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
In-Reply-To: <CAKohpo=Sw6eUP6Xk3=a=rk6WMJQta=T7ReBPM+7e9E5PsvMJgg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
Cc: fengguang.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, cpufreq-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, pdsw-power-team-5wv7dgnIgG8@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Thursday, October 25, 2012 09:00:22 AM Viresh Kumar wrote:
> On 25 October 2012 02:44, Rafael J. Wysocki <rjw-KKrjLPT3xs0@public.gmane.org> wrote:
> > On Wednesday 24 of October 2012 13:15:58 Viresh Kumar wrote:
> >> There were few sparse warnings due to mismatch of type on function arguments.
> >> Two types were used u64 and cputime64_t. Both are actually u64, so use u64 only.
> >>
> >> Reported-by: Fengguang Wu <fengguang.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> >> Signed-off-by: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> >
> > This series appears to be based on your "cpufreq: governors: remove
> > redundant code" patch that hasn't been applied yet.
> >
> > Please rebase it on top of linux-pm/linux-next or on top of v3.7-rc2,
> > whichever is more convenient, and resend.
> 
> Please apply it after applying the latest cpufreq: governors patch i have sent.

Done.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
