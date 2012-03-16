From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v4] cpuidle: Add a sysfs entry to disable
 specific C state for debug purpose.
Date: Fri, 16 Mar 2012 15:23:23 -0700
Message-ID: <20120316152323.3c629e5c.akpm@linux-foundation.org>
References: <CAGF5oy_BUytjeDa8Oc62pRabaEqwqKCFuVJuzLd-XNZg34ne2w@mail.gmail.com>
	<1330998885.1916.89.camel@ymzhang>
	<20120306052236.GA19416@kroah.com>
	<1331013078.1916.103.camel@ymzhang>
	<20120306143935.GA23346@kroah.com>
	<20120312181151.GE14020@sirena.org.uk>
	<20120312192936.GC24873@kroah.com>
	<1331602594.1916.155.camel@ymzhang>
	<20120313192949.GA8568@kroah.com>
	<1331686500.1916.172.camel@ymzhang>
	<20120314024619.GC22955@kroah.com> <4F600F78.2060902@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4F600F78.2060902@intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: shuox.liu@intel.com
Cc: "Brown, Len" <len.brown@intel.com>, Yanmin Zhang <yanmin_zhang@linux.intel.com>, Greg KH <gregkh@linuxfoundation.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, "H. Peter Anvin" <hpa@zytor.com>, andi.kleen@intel.com, Ingo Molnar <mingo@elte.hu>, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-pm@vger.kernel.org

On Wed, 14 Mar 2012 11:24:40 +0800
ShuoX Liu <shuox.liu@intel.com> wrote:

> From: ShuoX Liu <shuox.liu@intel.com>
> 
> Some C states of new CPU might be not good. One reason is BIOS might configure
> them incorrectly. To help developers root cause it quickly, the patch adds a
> new sysfs entry, so developers could disable specific C state manually.
> 
> In addition, C state might have much impact on performance tuning, as it takes
> much time to enter/exit C states, which might delay interrupt processing. With
> the new debug option, developers could check if a deep C state could  impact
> performance and how much impact it could cause.
> 
> ...
>
> +#define define_store_state_function(_name) \
> +static ssize_t store_state_##_name(struct cpuidle_state *state, \
> +		const char *buf, size_t size) \
> +{ \
> +	long value; \
> +	if (!capable(CAP_SYS_ADMIN)) \
> +		return -EPERM; \
> +	kstrtol(buf, 0, &value); \
> +	if (value) \
> +		state->disable = 1; \
> +	else \
> +		state->disable = 0; \
> +	return size; \
> +}

drivers/cpuidle/sysfs.c: In function 'store_state_disable':
drivers/cpuidle/sysfs.c:274: warning: ignoring return value of 'kstrtol', declared with attribute warn_unused_result

The check is there for a reason - the kernel shouldn't silently accept
random garbage inputs.

--- a/drivers/cpuidle/sysfs.c~cpuidle-add-a-sysfs-entry-to-disable-specific-c-state-for-debug-purpose-fix
+++ a/drivers/cpuidle/sysfs.c
@@ -238,9 +238,12 @@ static ssize_t store_state_##_name(struc
 		const char *buf, size_t size) \
 { \
 	long value; \
+	int err; \
 	if (!capable(CAP_SYS_ADMIN)) \
 		return -EPERM; \
-	kstrtol(buf, 0, &value); \
+	err = kstrtol(buf, 0, &value); \
+	if (err) \
+		return err; \
 	if (value) \
 		state->disable = 1; \
 	else \
_
