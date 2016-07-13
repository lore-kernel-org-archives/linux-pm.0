From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH][RFC v2] PM / hibernate: Introduce snapshot test mode for hibernation
Date: Wed, 13 Jul 2016 14:07:03 +0200
Message-ID: <CAJZ5v0gaQ5E99KfbC-behEb1uhpZiXHmCg1abC20zT9pqse=aQ@mail.gmail.com>
References: <1468390116-957-1-git-send-email-yu.c.chen@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33408 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751058AbcGMMHp (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 13 Jul 2016 08:07:45 -0400
In-Reply-To: <1468390116-957-1-git-send-email-yu.c.chen@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Chen Yu <yu.c.chen@intel.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>, Len Brown <lenb@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Wed, Jul 13, 2016 at 8:08 AM, Chen Yu <yu.c.chen@intel.com> wrote:
> This mode is used to verify if the snapshot data written to
> the swap device can be successfully restored to the memory. It
> is useful to ease the debugging process on hibernation,
> since this mode can not only bypass the BIOSen/bootloader,
> but also the system re-initialization.
>
> For example:
> $ sudo echo snapshot > /sys/power/pm_test
> $ sudo echo disk > /sys/power/state
>
> [  267.959784] PM: Image saving progress:  80%
> [  268.038669] PM: Image saving progress:  90%
> [  268.111745] PM: Image saving progress: 100%
> [  268.129269] PM: Image saving done.
> [  268.133485] PM: Wrote 518612 kbytes in 0.75 seconds (691.48 MB/s)
> [  268.140564] PM: S|
> [  268.160067] hibernation debug: Waiting for 5 seconds.
> ...
> [  273.508638] PM: Looking for hibernation image.
> [  273.516583] PM: Image signature found, resuming
> [  273.926547] PM: Loading and decompressing image data (129653 pages)...
> [  274.122452] PM: Image loading progress:   0%
> [  274.322127] PM: Image loading progress:  10%
> ...
>
> Rebased on top of linux-next.
>
> Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> ---
>  kernel/power/hibernate.c | 10 ++++++++--
>  kernel/power/main.c      |  3 +++
>  kernel/power/power.h     |  3 +++
>  kernel/power/swap.c      |  7 +++++++
>  4 files changed, 21 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
> index 51441d8..30cc5b4 100644
> --- a/kernel/power/hibernate.c
> +++ b/kernel/power/hibernate.c
> @@ -43,6 +43,7 @@ static char resume_file[256] = CONFIG_PM_STD_PARTITION;
>  dev_t swsusp_resume_device;
>  sector_t swsusp_resume_block;
>  __visible int in_suspend __nosavedata;
> +static int software_resume(void);
>
>  enum {
>         HIBERNATION_INVALID,
> @@ -647,7 +648,7 @@ static void power_down(void)
>   */
>  int hibernate(void)
>  {
> -       int error, nr_calls = 0;
> +       int error, nr_calls = 0, snapshot_test = 0;

Why can't snapshot_test be a bool variable?

Thanks,
Rafael
