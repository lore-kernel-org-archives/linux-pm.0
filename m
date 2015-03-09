From: "Fu, Zhonghui" <zhonghui.fu@linux.intel.com>
Subject: Re: [PATCH v3] PM-Trace: add pm-trace support for suspending phase
Date: Mon, 09 Mar 2015 10:10:08 +0800
Message-ID: <54FD0100.3070107@linux.intel.com>
References: <54F5C12D.8030703@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:28479 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753219AbbCICKN (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sun, 8 Mar 2015 22:10:13 -0400
In-Reply-To: <54F5C12D.8030703@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, pavel@ucw.cz, len.brown@intel.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org


Any comments about this patch?


Thanks,
Zhonghui

On 2015/3/3 22:11, Fu, Zhonghui wrote:
> Occasionally, the system can't come back up after suspend/resume
> due to problems of device suspending phase. This patch make
> PM_TRACE infrastructure cover device suspending phase of
> suspend/resume process, and the information in RTC can tell
> developers which device suspending function make system hang.
>
> Signed-off-by: Zhonghui Fu <zhonghui.fu@linux.intel.com>
> ---
> Changes in v3:
> - Remove duplicate macro definition in arch/x86/include/asm/pm-trace.h.
>
>  .../x86/include/asm/{resume-trace.h => pm-trace.h} |   10 ++++++----
>  drivers/base/power/main.c                          |   20 ++++++++++++++++----
>  drivers/base/power/trace.c                         |    6 +++---
>  include/linux/{resume-trace.h => pm-trace.h}       |    9 +++++----
>  kernel/power/main.c                                |    2 +-
>  5 files changed, 31 insertions(+), 16 deletions(-)
>  rename arch/x86/include/asm/{resume-trace.h => pm-trace.h} (68%)
>  rename include/linux/{resume-trace.h => pm-trace.h} (75%)
>
> diff --git a/arch/x86/include/asm/resume-trace.h b/arch/x86/include/asm/pm-trace.h
> similarity index 68%
> rename from arch/x86/include/asm/resume-trace.h
> rename to arch/x86/include/asm/pm-trace.h
> index 3ff1c2c..7b7ac42 100644
> --- a/arch/x86/include/asm/resume-trace.h
> +++ b/arch/x86/include/asm/pm-trace.h
> @@ -1,5 +1,5 @@
> -#ifndef _ASM_X86_RESUME_TRACE_H
> -#define _ASM_X86_RESUME_TRACE_H
> +#ifndef _ASM_X86_PM_TRACE_H
> +#define _ASM_X86_PM_TRACE_H
>  
>  #include <asm/asm.h>
>  
> @@ -14,8 +14,10 @@ do {								\
>  			     ".previous"			\
>  			     :"=r" (tracedata)			\
>  			     : "i" (__LINE__), "i" (__FILE__));	\
> -		generate_resume_trace(tracedata, user);		\
> +		generate_pm_trace(tracedata, user);		\
>  	}							\
>  } while (0)
>  
> -#endif /* _ASM_X86_RESUME_TRACE_H */
> +#define TRACE_SUSPEND(user)	TRACE_RESUME(user)
> +
> +#endif /* _ASM_X86_PM_TRACE_H */
> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> index 9717d5f..3d874ec 100644
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -23,7 +23,7 @@
>  #include <linux/mutex.h>
>  #include <linux/pm.h>
>  #include <linux/pm_runtime.h>
> -#include <linux/resume-trace.h>
> +#include <linux/pm-trace.h>
>  #include <linux/interrupt.h>
>  #include <linux/sched.h>
>  #include <linux/async.h>
> @@ -1017,6 +1017,9 @@ static int __device_suspend_noirq(struct device *dev, pm_message_t state, bool a
>  	char *info = NULL;
>  	int error = 0;
>  
> +	TRACE_DEVICE(dev);
> +	TRACE_SUSPEND(0);
> +
>  	if (async_error)
>  		goto Complete;
>  
> @@ -1057,6 +1060,7 @@ static int __device_suspend_noirq(struct device *dev, pm_message_t state, bool a
>  
>  Complete:
>  	complete_all(&dev->power.completion);
> +	TRACE_SUSPEND(error);
>  	return error;
>  }
>  
> @@ -1078,7 +1082,7 @@ static int device_suspend_noirq(struct device *dev)
>  {
>  	reinit_completion(&dev->power.completion);
>  
> -	if (pm_async_enabled && dev->power.async_suspend) {
> +	if (is_async(dev)) {
>  		get_device(dev);
>  		async_schedule(async_suspend_noirq, dev);
>  		return 0;
> @@ -1157,6 +1161,9 @@ static int __device_suspend_late(struct device *dev, pm_message_t state, bool as
>  	char *info = NULL;
>  	int error = 0;
>  
> +	TRACE_DEVICE(dev);
> +	TRACE_SUSPEND(0);
> +
>  	__pm_runtime_disable(dev, false);
>  
>  	if (async_error)
> @@ -1198,6 +1205,7 @@ static int __device_suspend_late(struct device *dev, pm_message_t state, bool as
>  		async_error = error;
>  
>  Complete:
> +	TRACE_SUSPEND(error);
>  	complete_all(&dev->power.completion);
>  	return error;
>  }
> @@ -1219,7 +1227,7 @@ static int device_suspend_late(struct device *dev)
>  {
>  	reinit_completion(&dev->power.completion);
>  
> -	if (pm_async_enabled && dev->power.async_suspend) {
> +	if (is_async(dev)) {
>  		get_device(dev);
>  		async_schedule(async_suspend_late, dev);
>  		return 0;
> @@ -1338,6 +1346,9 @@ static int __device_suspend(struct device *dev, pm_message_t state, bool async)
>  	int error = 0;
>  	DECLARE_DPM_WATCHDOG_ON_STACK(wd);
>  
> +	TRACE_DEVICE(dev);
> +	TRACE_SUSPEND(0);
> +
>  	dpm_wait_for_children(dev, async);
>  
>  	if (async_error)
> @@ -1444,6 +1455,7 @@ static int __device_suspend(struct device *dev, pm_message_t state, bool async)
>  	if (error)
>  		async_error = error;
>  
> +	TRACE_SUSPEND(error);
>  	return error;
>  }
>  
> @@ -1465,7 +1477,7 @@ static int device_suspend(struct device *dev)
>  {
>  	reinit_completion(&dev->power.completion);
>  
> -	if (pm_async_enabled && dev->power.async_suspend) {
> +	if (is_async(dev)) {
>  		get_device(dev);
>  		async_schedule(async_suspend, dev);
>  		return 0;
> diff --git a/drivers/base/power/trace.c b/drivers/base/power/trace.c
> index d94a1f5..a311cfa 100644
> --- a/drivers/base/power/trace.c
> +++ b/drivers/base/power/trace.c
> @@ -7,7 +7,7 @@
>   * devices may be working.
>   */
>  
> -#include <linux/resume-trace.h>
> +#include <linux/pm-trace.h>
>  #include <linux/export.h>
>  #include <linux/rtc.h>
>  
> @@ -154,7 +154,7 @@ EXPORT_SYMBOL(set_trace_device);
>   * it's not any guarantee, but it's a high _likelihood_ that
>   * the match is valid).
>   */
> -void generate_resume_trace(const void *tracedata, unsigned int user)
> +void generate_pm_trace(const void *tracedata, unsigned int user)
>  {
>  	unsigned short lineno = *(unsigned short *)tracedata;
>  	const char *file = *(const char **)(tracedata + 2);
> @@ -164,7 +164,7 @@ void generate_resume_trace(const void *tracedata, unsigned int user)
>  	file_hash_value = hash_string(lineno, file, FILEHASH);
>  	set_magic_time(user_hash_value, file_hash_value, dev_hash_value);
>  }
> -EXPORT_SYMBOL(generate_resume_trace);
> +EXPORT_SYMBOL(generate_pm_trace);
>  
>  extern char __tracedata_start, __tracedata_end;
>  static int show_file_hash(unsigned int value)
> diff --git a/include/linux/resume-trace.h b/include/linux/pm-trace.h
> similarity index 75%
> rename from include/linux/resume-trace.h
> rename to include/linux/pm-trace.h
> index f31db23..ecbde7a 100644
> --- a/include/linux/resume-trace.h
> +++ b/include/linux/pm-trace.h
> @@ -1,8 +1,8 @@
> -#ifndef RESUME_TRACE_H
> -#define RESUME_TRACE_H
> +#ifndef PM_TRACE_H
> +#define PM_TRACE_H
>  
>  #ifdef CONFIG_PM_TRACE
> -#include <asm/resume-trace.h>
> +#include <asm/pm-trace.h>
>  #include <linux/types.h>
>  
>  extern int pm_trace_enabled;
> @@ -14,7 +14,7 @@ static inline int pm_trace_is_enabled(void)
>  
>  struct device;
>  extern void set_trace_device(struct device *);
> -extern void generate_resume_trace(const void *tracedata, unsigned int user);
> +extern void generate_pm_trace(const void *tracedata, unsigned int user);
>  extern int show_trace_dev_match(char *buf, size_t size);
>  
>  #define TRACE_DEVICE(dev) do { \
> @@ -28,6 +28,7 @@ static inline int pm_trace_is_enabled(void) { return 0; }
>  
>  #define TRACE_DEVICE(dev) do { } while (0)
>  #define TRACE_RESUME(dev) do { } while (0)
> +#define TRACE_SUSPEND(dev) do { } while (0)
>  
>  #endif
>  
> diff --git a/kernel/power/main.c b/kernel/power/main.c
> index 9a59d04..86e8157 100644
> --- a/kernel/power/main.c
> +++ b/kernel/power/main.c
> @@ -11,7 +11,7 @@
>  #include <linux/export.h>
>  #include <linux/kobject.h>
>  #include <linux/string.h>
> -#include <linux/resume-trace.h>
> +#include <linux/pm-trace.h>
>  #include <linux/workqueue.h>
>  #include <linux/debugfs.h>
>  #include <linux/seq_file.h>
> -- 1.7.1
>
>

