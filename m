From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] PowerCap: Error with option -Werror=format-security
Date: Mon, 4 Nov 2013 11:51:25 -0800
Message-ID: <CAGXu5jJeixN6bAJh6KJWExyKiyJHFsFWboL7Z0Xtn2F-71zg5w@mail.gmail.com>
References: <1383583990-9618-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oa0-f44.google.com ([209.85.219.44]:39328 "EHLO
	mail-oa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751155Ab3KDTv0 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 4 Nov 2013 14:51:26 -0500
Received: by mail-oa0-f44.google.com with SMTP id l20so7708340oag.3
        for <linux-pm@vger.kernel.org>; Mon, 04 Nov 2013 11:51:25 -0800 (PST)
In-Reply-To: <1383583990-9618-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Linux-Next <linux-next@vger.kernel.org>, Fengguang Wu <fengguang.wu@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org

On Mon, Nov 4, 2013 at 8:53 AM, Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
> Fix compile error with gcc option: -Werror=format-security for
> dev_set_name(&control_type->dev, name)
> Changed to
> dev_set_name(&control_type->dev, "%s", name);
>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
>  drivers/powercap/powercap_sys.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/powercap/powercap_sys.c b/drivers/powercap/powercap_sys.c
> index 21814f9..8d0fe43 100644
> --- a/drivers/powercap/powercap_sys.c
> +++ b/drivers/powercap/powercap_sys.c
> @@ -625,7 +625,7 @@ struct powercap_control_type *powercap_register_control_type(
>         control_type->ops = ops;
>         INIT_LIST_HEAD(&control_type->node);
>         control_type->dev.class = &powercap_class;
> -       dev_set_name(&control_type->dev, name);
> +       dev_set_name(&control_type->dev, "%s", name);
>         result = device_register(&control_type->dev);
>         if (result) {
>                 if (control_type->allocated)
> --
> 1.7.11.7

Thanks for getting this fixed!

Acked-by: Kees Cook <keescook@chromium.org>

-Kees

-- 
Kees Cook
Chrome OS Security
