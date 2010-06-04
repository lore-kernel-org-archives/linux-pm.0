From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: mmotm 2010-06-03-16-36 uploaded
Date: Thu, 3 Jun 2010 19:10:23 -0700
Message-ID: <20100603191023.96d74346.akpm__18779.538307763$1275617481$gmane$org@linux-foundation.org>
References: <201006040005.o5405Afw023296@imap1.linux-foundation.org>
	<AANLkTilX_Fbc_pR1jtgQJsvu7RbMfgyhJYCxqV725T18@mail.gmail.com>
	<20100603185401.1851c94e.akpm@linux-foundation.org>
	<AANLkTikDzAHHH62Wti1D-iV7pqa6u24BDgigIYO5JZJR@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTikDzAHHH62Wti1D-iV7pqa6u24BDgigIYO5JZJR@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Dave Young <hidave.darkstar@gmail.com>
Cc: pm list <linux-pm@lists.linux-foundation.org>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Fri, 4 Jun 2010 10:02:57 +0800 Dave Young <hidave.darkstar@gmail.com> wrote:

> On Fri, Jun 4, 2010 at 9:54 AM, Andrew Morton <akpm@linux-foundation.org> wrote:
> > On Fri, 4 Jun 2010 09:41:58 +0800 Dave Young <hidave.darkstar@gmail.com> wrote:
> >
> >> On Fri, Jun 4, 2010 at 7:36 AM, __<akpm@linux-foundation.org> wrote:
> >> > The mm-of-the-moment snapshot 2010-06-03-16-36 has been uploaded to
> >> >
> >> > __ http://userweb.kernel.org/~akpm/mmotm/
> >> >
> >>
> >> Hi, intel_idle build fails:
> >>
> >> drivers/idle/intel_idle.c: In function ___intel_idle___:
> >> drivers/idle/intel_idle.c:234: error: too few arguments to function ___trace_power
> >> _start___
> >> make[2]: *** [drivers/idle/intel_idle.o] Error 1
> >> make[1]: *** [drivers/idle] Error 2
> >> make[1]: *** Waiting for unfinished jobs....
> >>
> >
> > Caused by
> > x86-cpufreq-make-trace_power_frequency-cpufreq-driver-independent.patch
> > which changed trace_power_start().
> >
> > drivers/idle/intel_idle.c wasn't there when Thomas wrote that patch.
> >
> > this, I guess:
> >
> > --- a/drivers/idle/intel_idle.c~x86-cpufreq-make-trace_power_frequency-cpufreq-driver-independent-fix
> > +++ a/drivers/idle/intel_idle.c
> > @@ -231,7 +231,7 @@ static int intel_idle(struct cpuidle_dev
> >
> > __ __ __ __stop_critical_timings();
> > __#ifndef MODULE
> > - __ __ __ trace_power_start(POWER_CSTATE, (eax >> 4) + 1);
> > + __ __ __ trace_power_start(POWER_CSTATE, (eax >> 4) + 1, cpu);
> > __#endif
> > __ __ __ __if (!need_resched()) {
> >
> 
> With one more param "cpu", fails with "too many arguments":
> 
>   CC      drivers/idle/intel_idle.o
> drivers/idle/intel_idle.c: In function ___intel_idle___:
> drivers/idle/intel_idle.c:234: error: too many arguments to function
> ___trace_power_start___
> make[2]: *** [drivers/idle/intel_idle.o] Error 1
> make[1]: *** [drivers/idle] Error 2
> make[1]: *** Waiting for unfinished jobs....

hm, It Works For Me.  I suspect you applied my patch to mainline, not
to -mm.
