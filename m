From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] power: qos: Export pm_qos_update_request_timeout()
Date: Tue, 5 Dec 2017 16:24:35 +0100
Message-ID: <CAJZ5v0hwFo2hake52oGqrLt09ivfNCmw8pJY6uwqXVQ97FchkA@mail.gmail.com>
References: <1512470739-21960-1-git-send-email-hareeshg@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f67.google.com ([209.85.218.67]:37353 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753091AbdLEPYg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 5 Dec 2017 10:24:36 -0500
Received: by mail-oi0-f67.google.com with SMTP id y75so421326oie.4
        for <linux-pm@vger.kernel.org>; Tue, 05 Dec 2017 07:24:36 -0800 (PST)
In-Reply-To: <1512470739-21960-1-git-send-email-hareeshg@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Hareesh Gundu <hareeshg@codeaurora.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Linux PM <linux-pm@vger.kernel.org>

On Tue, Dec 5, 2017 at 11:45 AM, Hareesh Gundu <hareeshg@codeaurora.org> wrote:
> Add EXPORT_SYMBOL_GPL to pm_qos_update_request_timeout,
> so that it can be usable from modules similar to the
> pm_qos_update_request().
>
> Signed-off-by: Hareesh Gundu <hareeshg@codeaurora.org>

I'd rather see a modular user of this along with the export.

> ---
>  kernel/power/qos.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/kernel/power/qos.c b/kernel/power/qos.c
> index 9d75039..3f501b4 100644
> --- a/kernel/power/qos.c
> +++ b/kernel/power/qos.c
> @@ -515,6 +515,7 @@ void pm_qos_update_request_timeout(struct pm_qos_request *req, s32 new_value,
>
>         schedule_delayed_work(&req->work, usecs_to_jiffies(timeout_us));
>  }
> +EXPORT_SYMBOL_GPL(pm_qos_update_request_timeout);
>
>  /**
>   * pm_qos_remove_request - modifies an existing qos request
> --
> 1.9.1
>
