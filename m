From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] PM: Fix bug in the error handling of async suspend
Date: Thu, 08 Dec 2016 01:18:59 +0100
Message-ID: <3147015.xntCBFhHqr@aspire.rjw.lan>
References: <1481121632-17466-1-git-send-email-stummala@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1481121632-17466-1-git-send-email-stummala@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sahitya Tummala <stummala@codeaurora.org>
Cc: "Rafael J. Wysocki\"" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wednesday, December 07, 2016 08:10:32 PM Sahitya Tummala wrote:
> If async_suspend is enabled for parent and child devices, then
> PM framework has to ensure that parent's async suspend gets called
> only after child's async suspend is done. In case if child's async
> suspend fails with error, then parent's async suspend must not be
> invoked. The current code uses async_error to ensure this but there
> is a problem with it in __device_suspend(). This function notifies
> the completion of child's async suspend before updating its error
> via async_error variable. As a result, parent's async suspend gets
> invoked even though it's child suspend has failed. Fix this bug by
> updating the async_error before notifying the child's completion.
> 
> Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
> ---
>  drivers/base/power/main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> index e44944f4be77..f733f50f8321 100644
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -1460,9 +1460,9 @@ static int __device_suspend(struct device *dev, pm_message_t state, bool async)
>  	dpm_watchdog_clear(&wd);
>  
>   Complete:
> -	complete_all(&dev->power.completion);
>  	if (error)
>  		async_error = error;
> +	complete_all(&dev->power.completion);
>  
>  	TRACE_SUSPEND(error);
>  	return error;

Good catch!

I'm queuing this one up (with some whitespace rearrangements).

Thanks,
Rafael
