From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 1/2] PM / sleep: ensure deferred probe workqueue is finished in wait_for_device_probe
Date: Thu, 08 Oct 2015 22:50:02 +0200
Message-ID: <2181899.pIHuaJgxyC@vostro.rjw.lan>
References: <1444323427-6822-1-git-send-email-grygorii.strashko@ti.com> <1444323427-6822-2-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:45408 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751589AbbJHUV3 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 8 Oct 2015 16:21:29 -0400
In-Reply-To: <1444323427-6822-2-git-send-email-grygorii.strashko@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Stern <stern@rowland.harvard.edu>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>

On Thursday, October 08, 2015 11:57:06 AM Grygorii Strashko wrote:
> Now wait_for_device_probe() waits for currently executing probes to finish,
> but it doesn't take into account deferred probing mechanism. As result,
> nothing prevents deferred probe workqueue to continue probing devices right
> after wait_for_device_probe() is finished.
> 
> Hence, lest ensure deferred probe workqueue is finished in

s/lest/let's/

> wait_for_device_probe() before proceeding.
> 
> Cc: Alan Stern <stern@rowland.harvard.edu>
> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> ---
>  drivers/base/dd.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index be0eb46..98de1a5 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -391,6 +391,10 @@ int driver_probe_done(void)
>   */
>  void wait_for_device_probe(void)
>  {
> +	/* wait for the deferred probe workqueue to finish */
> +	if (driver_deferred_probe_enable)
> +		flush_workqueue(deferred_wq);
> +
>  	/* wait for the known devices to complete their probing */
>  	wait_event(probe_waitqueue, atomic_read(&probe_count) == 0);
>  	async_synchronize_full();

I'm not sure if this is sufficient.

Something may be added to the workqueue right after you've flushed it and
then be reporobed after the wait_event() in theory.  Or am I missing anything?

Thanks,
Rafael

