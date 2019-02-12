From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] PM / suspend: measure the time of filesystem syncing
Date: Wed, 13 Feb 2019 00:21:31 +0100
Message-ID: <CAJZ5v0j+JEs5G+ySmkxEc0kbomTckX=wRg_DbnQ6svnX+EZaTg@mail.gmail.com>
References: <20190203052007.27392-1-harry.pan@intel.com> <20190206144257.21464-1-harry.pan@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190206144257.21464-1-harry.pan@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Harry Pan <harry.pan@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Harry Pan <gs0622@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Linux PM <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Feb 6, 2019 at 4:57 PM Harry Pan <harry.pan@intel.com> wrote:
>
> This patch gives the reader an intuitive metric of the time cost by
> the kernel issuing a filesystem sync during suspend; although developer
> can guess by the timestamp of next log or enable the ftrace power event
> for manual calculation, this manner is easier to read and benefits the
> automatic script.
>
> v2: simplify the variables, apply the simplest form of ktime API.
>
> Signed-off-by: Harry Pan <harry.pan@intel.com>
> ---
>  kernel/power/suspend.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
> index 0bd595a0b610..87c0073f0c9d 100644
> --- a/kernel/power/suspend.c
> +++ b/kernel/power/suspend.c
> @@ -550,6 +550,8 @@ static void suspend_finish(void)
>  static int enter_state(suspend_state_t state)
>  {
>         int error;
> +       ktime_t start;
> +       unsigned int elapsed_msecs;

You only need these two if CONFIG_SUSPEND_SKIP_SYNC is set, ->

>
>         trace_suspend_resume(TPS("suspend_enter"), state, true);
>         if (state == PM_SUSPEND_TO_IDLE) {
> @@ -570,9 +572,12 @@ static int enter_state(suspend_state_t state)
>
>  #ifndef CONFIG_SUSPEND_SKIP_SYNC

-> so I would change this to

if (IS_ENABLED(CONFIG_SUSPEND_SKIP_SYNC)) {
     ktime_t start;
     unsigned int elapsed_msecs;

>         trace_suspend_resume(TPS("sync_filesystems"), 0, true);
> +       start = ktime_get();

Why don't you do this after printing the message below?

>         pr_info("Syncing filesystems ... ");
>         ksys_sync();
> -       pr_cont("done.\n");
> +       elapsed_msecs = ktime_to_ms(ktime_sub(ktime_get(), start));
> +       pr_cont("(elapsed %d.%03d seconds) done.\n", elapsed_msecs / 1000,
> +               elapsed_msecs % 1000);

Use MSEC_PER_SEC here.

>         trace_suspend_resume(TPS("sync_filesystems"), 0, false);
>  #endif
>
