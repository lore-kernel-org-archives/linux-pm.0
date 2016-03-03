From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH] PM / Runtime: Only force-resume device if it has been
 force-suspended
Date: Thu, 3 Mar 2016 23:54:05 +0300
Message-ID: <56D8A46D.3030906@cogentembedded.com>
References: <1457036214-26136-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1457036214-26136-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Kevin Hilman <khilman@kernel.org>, linux-renesas-soc@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hello.

On 03/03/2016 11:16 PM, Laurent Pinchart wrote:

    Noticed a few typos as well, some alreayd reported...

> The pm_runtime_force_suspend() and pm_runtime_force_resume() helpers are
> designed to help driver being RPM-centric by offering an easy way to
> manager runtime PM state during system suspend and resume. The first

    Manage.

> function will force the device into runtime suspend at system suspend
> time, while the second one will perform the reverse operation at system
> resume time.
>
> However, the pm_runtime_force_resume() really forces resume, regarding

    Regardless.

> of whether the device was running or already suspended before the call
> to pm_runtime_force_suspend(). This results in devices being runtime
> resumed at system resume time when they shouldn't.
>
> Fix this by recording whether the device has been forcefully suspended
> in pm_runtime_force_suspend() and condition resume in
> pm_runtime_force_resume() to that state.
>
> All current users of pm_runtime_force_resume() call the function
> uncontionally in their system resume handler (some actually set it as

    Unconditionally.

> the resume handler), all after calling pm_runtime_force_suspend() at
> system suspend time. The change in behaviour should thus be safe.
>
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> ---
>   drivers/base/power/runtime.c | 12 +++++++++---
>   include/linux/pm.h           |  1 +
>   2 files changed, 10 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> index 4c7055009bd6..ad2189294c9b 100644
> --- a/drivers/base/power/runtime.c
> +++ b/drivers/base/power/runtime.c
[...]
> @@ -1483,13 +1485,13 @@ err:
>   EXPORT_SYMBOL_GPL(pm_runtime_force_suspend);
>
>   /**
> - * pm_runtime_force_resume - Force a device into resume state.
> + * pm_runtime_force_resume - Force a device into resume state if needed.
>    * @dev: Device to resume.
>    *
>    * Prior invoking this function we expect the user to have brought the device
>    * into low power state by a call to pm_runtime_force_suspend(). Here we reverse
> - * those actions and brings the device into full power. We update the runtime PM
> - * status and re-enables runtime PM.
> + * those actions and bring the device back to its runtime PM state before forced
> + * suspension. We update the runtime PM status and re-enables runtime PM.

    Re-enable.

[...]

MBR, Sergei
