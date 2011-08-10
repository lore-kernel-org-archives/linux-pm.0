From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v4] PM: add statistics debugfs file for
	suspend to ram
Date: Wed, 10 Aug 2011 23:44:18 +0200
Message-ID: <20110810214418.GC9320@atrey.karlin.mff.cuni.cz>
References: <6E3BC7F7C9A4BF4286DD4C043110F30B5B847F42F9@shsmsx502.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <6E3BC7F7C9A4BF4286DD4C043110F30B5B847F42F9@shsmsx502.ccr.corp.intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Liu, ShuoX" <shuox.liu@intel.com>
Cc: "Brown, Len" <len.brown@intel.com>, "Yanmin_zhang@linux.intel.com" <Yanmin_zhang@linux.intel.com>, Greg KH <gregkh@suse.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Hi!

> If not using this patch, we have other methods to get info about
> what device fails. One is to turn on  CONFIG_PM_DEBUG, but users
> would get too much info and testers need recompile the system.
> 
> In addition, dynamic debug is another good tool to dump debug info.
> But it still doesn't match our utilization scenario closely.
> 1) user need write a user space parser to process the syslog output;
> 2) Our testing scenario is we leave the mobile for at least hours.
>    Then, check its status. No serial console available during the
>    testing. One is because console would be suspended, and the other
>    is serial console connecting with spi or HSU devices would consume
>    power. These devices are powered off at suspend-2-ram.

1) yes you need parser

1a) Yes, you need CONFIG_PM_DEBUG; but that's better than forcing 200
lines of pure debugging code onto everyone

2)  You can do that. Just check and parse dmesg from userland after
each resume.

If dmesg provides too little/too much information, improve loglevels
so that it is not spammed.
 
								Pavel


> Signed-off-by: ShuoX Liu <shuox.liu@intel.com>
> ---
>  Documentation/power/basic-pm-debugging.txt |   24 +++++++
>  drivers/base/power/main.c                  |   31 +++++++--
>  include/linux/suspend.h                    |   52 ++++++++++++++
>  kernel/power/main.c                        |  102 ++++++++++++++++++++++++++++
>  kernel/power/suspend.c                     |   17 ++++-
>  5 files changed, 218 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/power/basic-pm-debugging.txt b/Documentation/power/basic-pm-debugging.txt
> index ddd7817..62eca08 100644
> --- a/Documentation/power/basic-pm-debugging.txt
> +++ b/Documentation/power/basic-pm-debugging.txt
> @@ -201,3 +201,27 @@ case, you may be able to search for failing drivers by following the procedure
>  analogous to the one described in section 1.  If you find some failing drivers,
>  you will have to unload them every time before an STR transition (ie. before
>  you run s2ram), and please report the problems with them.
> +
> +There is a debugfs entry which shows the suspend to RAM statistics. Here is an
> +example of its output.
> +	# mount -t debugfs none /sys/kernel/debug
> +	# cat /sys/kernel/debug/suspend_stats
> +	success: 20
> +	fail: 5
> +	failed_freeze: 0
> +	failed_prepare: 0
> +	failed_suspend: 5
> +	failed_suspend_noirq: 0
> +	failed_resume: 0
> +	failed_resume_noirq: 0
> +	failures:
> +	  last_failed_dev:	alarm
> +				adc
> +	  last_failed_errno:	-16
> +				-16
> +	  last_failed_step:	suspend
> +				suspend
> +Field success means the success number of suspend to RAM, and field fail means
> +the failure number. Others are the failure number of different steps of suspend
> +to RAM. suspend_stats just lists the last 2 failed devices, error number and
> +failed step of suspend.

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
