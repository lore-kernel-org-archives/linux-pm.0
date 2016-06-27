From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH][RFC] cpufreq: Avoid warning during resume by return EAGAIN if cpufreq is unavailable
Date: Mon, 27 Jun 2016 03:12:21 +0200
Message-ID: <2394728.0JDBHijQ6J@vostro.rjw.lan>
References: <1466872128-14566-1-git-send-email-yu.c.chen@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1466872128-14566-1-git-send-email-yu.c.chen@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Chen Yu <yu.c.chen@intel.com>
Cc: linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Sunday, June 26, 2016 12:28:48 AM Chen Yu wrote:
> Previously we saw warning during resume on some platforms,
> which use acpi-cpufreq:
> 
> smpboot: Booting Node 0 Processor 3 APIC 0x5
> cache: parent cpu3 should not be sleeping
> CPU3 is up
> ACPI: Waking up from system sleep state S3
> WARNING: CPU: 0 PID: 12546 at drivers/cpufreq/cpufreq.c:2173
> Call Trace:
> [<ffffffff81311d95>] dump_stack+0x5c/0x77
> [<ffffffff8107aef4>] __warn+0xc4/0xe0
> [<ffffffff8148c13e>] cpufreq_update_policy+0xfe/0x150
> [<ffffffff8148c190>] cpufreq_update_policy+0x150/0x150
> [<ffffffffc03e42ef>] acpi_processor_notify+0x51/0xdc [processor]
> [<ffffffff813b0d24>] acpi_ev_notify_dispatch+0x3c/0x55
> [<ffffffff81399613>] acpi_os_execute_deferred+0x10/0x1a
> [<ffffffff81093ffb>] process_one_work+0x14b/0x400
> [<ffffffff81094aa5>] worker_thread+0x65/0x4a0
> [<ffffffff81094a40>] rescuer_thread+0x340/0x340
> [<ffffffff81099dbf>] kthread+0xdf/0x100
> [<ffffffff815c7ee2>] ret_from_fork+0x22/0x40
> [<ffffffff81099ce0>] kthread_park+0x50/0x50
> 
> This is because this platforms tries to notify
> the processor to reevaluate the _PPC object in _WAK,
> however at that time the cpufreq driver's resume has
> not been invoked yet, thus cpufreq_update_current_freq
> returns zero because of cpufreq_suspended = true, which
> caused the warning.
> 
> Actually it should be unnecessary to care the update request
> at that moment, so remove the warning and change the return
> value to -EAGAIN for invokers.
> 
> Reported-and-tested-by: BzukTuk <darlor@seznam.cz>
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> ---
>  drivers/cpufreq/cpufreq.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 9009295..67a3aa1 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -2262,8 +2262,11 @@ int cpufreq_update_policy(unsigned int cpu)
>  	 */
>  	if (cpufreq_driver->get && !cpufreq_driver->setpolicy) {
>  		new_policy.cur = cpufreq_update_current_freq(policy);
> -		if (WARN_ON(!new_policy.cur)) {
> -			ret = -EIO;
> +		if (!new_policy.cur) {
> +			if (WARN_ON(!cpufreq_suspended))

If we know that cpufreq is suspended, there's no reason to call
cpufreq_update_current_freq() at all here.

> +				ret = -EIO;
> +			else
> +				ret = -EAGAIN;
>  			goto unlock;
>  		}
>  	}

Moreover, cpufreq_update_current_freq() has only two callers and the other
one already checks cpufreq_suspended before invoking it, so what about the
patch below instead?

---
 drivers/cpufreq/cpufreq.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

Index: linux-pm/drivers/cpufreq/cpufreq.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq.c
+++ linux-pm/drivers/cpufreq/cpufreq.c
@@ -1544,9 +1544,6 @@ static unsigned int cpufreq_update_curre
 {
 	unsigned int new_freq;
 
-	if (cpufreq_suspended)
-		return 0;
-
 	new_freq = cpufreq_driver->get(policy->cpu);
 	if (!new_freq)
 		return 0;
@@ -2280,6 +2277,10 @@ int cpufreq_update_policy(unsigned int c
 	 * -> ask driver for current freq and notify governors about a change
 	 */
 	if (cpufreq_driver->get && !cpufreq_driver->setpolicy) {
+		if (cpufreq_suspended) {
+			ret = -EAGAIN;
+			goto unlock;
+		}
 		new_policy.cur = cpufreq_update_current_freq(policy);
 		if (WARN_ON(!new_policy.cur)) {
 			ret = -EIO;

