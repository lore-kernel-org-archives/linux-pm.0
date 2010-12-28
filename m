From: Eduardo Valentin <eduardo.valentin@nokia.com>
Subject: Re: why  menu.c in cpuidle   continue ?
Date: Tue, 28 Dec 2010 11:44:37 +0200
Message-ID: <20101228094437.GA19877@besouro.research.nokia.com>
References: <1a05924.a870.12d288dbfca.Coremail.wkq5325@163.com>
Reply-To: eduardo.valentin@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1a05924.a870.12d288dbfca.Coremail.wkq5325@163.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: ext wkq5325 <wkq5325@163.com>
Cc: linux-pm <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Hello,

On Mon, Dec 27, 2010 at 11:58:54PM +0800, ext wkq5325 wrote:
> Hi,
> I find the code in 2.6.36 menu.c (cpuidle)
> 
>   for (i = CPUIDLE_DRIVER_STATE_START; i < dev->state_count; i++) {
> 287                 struct cpuidle_state *s = &dev->states[i];
>  289                 if (s->flags & CPUIDLE_FLAG_IGNORE)
> 290                         continue;
> 291                 if (s->target_residency > data->predicted_us)
> 292                         continue;
> 293                 if (s->exit_latency > latency_req)
> 294                         continue;
>  Why continue? Not break ?? Before  2.6.36 , break is used here, I can understand.
> But now , I don't know why continue for the remaining state??

Yeah, at first glance it looks a bit confusing. After checking who
has added the change you are referring to, you will see this patch:


commit 71abbbf856a0e70ca478782505c800891260ba84
Author: Ai Li <aili@codeaurora.org>
Date:   Mon Aug 9 17:20:13 2010 -0700

    cpuidle: extend cpuidle and menu governor to handle dynamic states

    3) add power_specified bit to struct cpuidle_device.  The menu governor
       currently assumes that the cpuidle states are arranged in the order of
       increasing latency, threshold, and power savings.  This is true or can
       be made true for static states.  Once the state parameters are dynamic,
       the latencies, thresholds, and power savings for the cpuidle states can
       increase or decrease by different amounts from idle period to idle
       period.  So the assumption of increasing latency, threshold, and power
       savings from Cn to C(n+1) can no longer be guaranteed.



And from there maybe we could understand why. The thing is that, before
that patch, the governor would assume that we provide a list of static
cstates, ordered by increasing latency, threshold, power saving. After
the patch, this assumption does not hold anymore. Meaning, from idle
to idle, all this parameters may change, so your cstate list is not ordered.
Then you have to go through all of them to find the lowest possible.
That is, if you have a driver which provides power usage numbers,
then we are good.

And if you don't use the power usage facility, cpuidle will fill them
all in a decreasing order:
+       /*
+        * cpuidle driver should set the dev->power_specified bit
+        * before registering the device if the driver provides
+        * power_usage numbers.
+        *
+        * For those devices whose ->power_specified is not set,
+        * we fill in power_usage with decreasing values as the
+        * cpuidle code has an implicit assumption that state Cn
+        * uses less power than C(n-1).
+        *
+        * With CONFIG_ARCH_HAS_CPU_RELAX, C0 is already assigned
+        * an power value of -1.  So we use -2, -3, etc, for other
+        * c-states.
+        */
+       if (!dev->power_specified) {
+               int i;
+               for (i = CPUIDLE_DRIVER_STATE_START; i < dev->state_count; i++)
+                       dev->states[i].power_usage = -1 - i;
+       }
+

Then, in the end, if your driver doesn't change power usage dynamically but do
change the latencies, it means you have to still keep the list of cstates still ordered
by increasing latencies. Otherwise, the governor could be selecting the wrong cstate.



> 
> wkq
> 
> 
> 
> 

> _______________________________________________
> linux-pm mailing list
> linux-pm@lists.linux-foundation.org
> https://lists.linux-foundation.org/mailman/listinfo/linux-pm


-- 
Eduardo Valentin
