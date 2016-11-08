From: Chen Yu <yu.c.chen@intel.com>
Subject: Re: [PATCH 2/2][RFC v6] PM / sleep: save/restore RTC time after
 resumed if pm_trace enabled
Date: Tue, 8 Nov 2016 20:43:12 +0800
Message-ID: <20161108124312.GC7191@yu-desktop-1.sh.intel.com>
References: <cover.1478589736.git.yu.c.chen@intel.com>
 <3bf82cf55c4f5ce3286f6c3fc0b2b7e4b2e5ded3.1478589736.git.yu.c.chen@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <3bf82cf55c4f5ce3286f6c3fc0b2b7e4b2e5ded3.1478589736.git.yu.c.chen@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: x86@kernel.org
Cc: Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Thomas Gleixner <tglx@linutronix.de>, Len Brown <lenb@kernel.org>, John Stultz <john.stultz@linaro.org>, Xunlei Pang <xlpang@redhat.com>
List-Id: linux-pm@vger.kernel.org

Hi all,


On Tue, Nov 08, 2016 at 05:02:14PM +0800, Chen Yu wrote:
> Previously the bogus CMOS RTC sleep time has been ignored if pm_trace
> is enabled, however once the system successfully resumed back,
> any further read to CMOS RTC would return an error. Actually it is
> more user-friendly to bring the system back to normal after resumed.
> 
> This patch has registered an pm notifier to restore the RTC to the
> value before been overwitten by pm_trace.
> 
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Len Brown <lenb@kernel.org>
> Cc: John Stultz <john.stultz@linaro.org>
> Cc: Xunlei Pang <xlpang@redhat.com>
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> ---

Please ignore this version for now,
the atomic variable below is unnecessary since
pm_trace has disabled the async suspend.

And in order to allow the users to adjust rtc after resume,
we can clear the pm_trace_rtc_abused directly and warn users of
the broken rtc. (Without save/restore).

>  drivers/base/power/trace.c | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> diff --git a/drivers/base/power/trace.c b/drivers/base/power/trace.c
> index aa9109a..1e6c611 100644
> --- a/drivers/base/power/trace.c
> +++ b/drivers/base/power/trace.c
> @@ -10,6 +10,7 @@
>  #include <linux/pm-trace.h>
>  #include <linux/export.h>
>  #include <linux/rtc.h>
> +#include <linux/suspend.h>
>  
>  #include <linux/mc146818rtc.h>
>  
> @@ -76,6 +77,11 @@
>  
>  bool pm_trace_rtc_abused __read_mostly;
>  static unsigned int dev_hash_value;
> +struct rtc_time_save {
> +	struct rtc_time time;
> +	atomic_t saved;
> +};
>
 
