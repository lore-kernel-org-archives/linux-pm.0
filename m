From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: mmotm 2010-06-03-16-36 uploaded
Date: Thu, 3 Jun 2010 18:54:01 -0700
Message-ID: <20100603185401.1851c94e.akpm__599.016532260244$1275616489$gmane$org@linux-foundation.org>
References: <201006040005.o5405Afw023296@imap1.linux-foundation.org>
	<AANLkTilX_Fbc_pR1jtgQJsvu7RbMfgyhJYCxqV725T18@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTilX_Fbc_pR1jtgQJsvu7RbMfgyhJYCxqV725T18@mail.gmail.com>
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
Cc: Thomas@smtp1.linux-foundation.org, mm-commits@vger.kernel.org, linux-kernel@vger.kernel.org, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Fri, 4 Jun 2010 09:41:58 +0800 Dave Young <hidave.darkstar@gmail.com> wrote:

> On Fri, Jun 4, 2010 at 7:36 AM,  <akpm@linux-foundation.org> wrote:
> > The mm-of-the-moment snapshot 2010-06-03-16-36 has been uploaded to
> >
> > __ http://userweb.kernel.org/~akpm/mmotm/
> >
> 
> Hi, intel_idle build fails:
> 
> drivers/idle/intel_idle.c: In function ___intel_idle___:
> drivers/idle/intel_idle.c:234: error: too few arguments to function ___trace_power
> _start___
> make[2]: *** [drivers/idle/intel_idle.o] Error 1
> make[1]: *** [drivers/idle] Error 2
> make[1]: *** Waiting for unfinished jobs....
> 

Caused by
x86-cpufreq-make-trace_power_frequency-cpufreq-driver-independent.patch
which changed trace_power_start().

drivers/idle/intel_idle.c wasn't there when Thomas wrote that patch.

this, I guess:

--- a/drivers/idle/intel_idle.c~x86-cpufreq-make-trace_power_frequency-cpufreq-driver-independent-fix
+++ a/drivers/idle/intel_idle.c
@@ -231,7 +231,7 @@ static int intel_idle(struct cpuidle_dev
 
 	stop_critical_timings();
 #ifndef MODULE
-	trace_power_start(POWER_CSTATE, (eax >> 4) + 1);
+	trace_power_start(POWER_CSTATE, (eax >> 4) + 1, cpu);
 #endif
 	if (!need_resched()) {
 
_


it's a bit odd that all trace_power_start() callers just pass in
smp_processor_id().  Why not do it within trace_power_start() itself?
