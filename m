From: Shaohua Li <shaohua.li@intel.com>
Subject: Re: PROBLEM: Shutdown does not poweroff due to commit
 2a2d31c8 "intel_idle: open broadcast clock event"
Date: Mon, 24 Jan 2011 09:09:35 +0800
Message-ID: <1295831375.1949.944.camel@sli10-conroe>
References: <AANLkTikDA9JqFjLRfPuPWTu3xbdfc16SzaRAwzKE3cH=@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTikDA9JqFjLRfPuPWTu3xbdfc16SzaRAwzKE3cH=@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Ari Savolainen <ari.m.savolainen@gmail.com>
Cc: "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Sat, 2011-01-22 at 02:03 +0800, Ari Savolainen wrote:
> Hi,
> 
> I have a Dell Precision WorkStation T3500. It stopped to power off
> after shutdown. Bisection revealed commit 2a2d31c8 "intel_idle: open
> broadcast clock event" to be the reason.  Below are all the dmesg
> lines containing "intel_idle":
> 
> [    2.184560] intel_idle: MWAIT substates: 0x1120
> [    2.184561] intel_idle: v0.4 model 0x1A
> [    2.184562] intel_idle: lapic_timer_reliable_states 0x2
> [    2.204056] ACPI: acpi_idle yielding to intel_idle
> 
> Please let me know what further information you need to fix the problem.
I can't reproduce it here, but can you please try below patch:

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index 7acb32e..1fa091e 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -263,7 +263,7 @@ static void __setup_broadcast_timer(void *arg)
 	clockevents_notify(reason, &cpu);
 }
 
-static int __cpuinit setup_broadcast_cpuhp_notify(struct notifier_block *n,
+static int setup_broadcast_cpuhp_notify(struct notifier_block *n,
 		unsigned long action, void *hcpu)
 {
 	int hotcpu = (unsigned long)hcpu;
@@ -273,15 +273,11 @@ static int __cpuinit setup_broadcast_cpuhp_notify(struct notifier_block *n,
 		smp_call_function_single(hotcpu, __setup_broadcast_timer,
 			(void *)true, 1);
 		break;
-	case CPU_DOWN_PREPARE:
-		smp_call_function_single(hotcpu, __setup_broadcast_timer,
-			(void *)false, 1);
-		break;
 	}
 	return NOTIFY_OK;
 }
 
-static struct notifier_block __cpuinitdata setup_broadcast_notifier = {
+static struct notifier_block setup_broadcast_notifier = {
 	.notifier_call = setup_broadcast_cpuhp_notify,
 };
 
