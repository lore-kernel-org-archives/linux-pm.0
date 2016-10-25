From: Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH] PM / Domains: check for negative return from of_count_phandle_with_args
Date: Tue, 25 Oct 2016 11:14:40 -0700
Message-ID: <7htwc0thwv.fsf@baylibre.com>
References: <20161025163327.2179-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f175.google.com ([209.85.192.175]:36093 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753299AbcJYSOm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Oct 2016 14:14:42 -0400
Received: by mail-pf0-f175.google.com with SMTP id e6so123267179pfk.3
        for <linux-pm@vger.kernel.org>; Tue, 25 Oct 2016 11:14:42 -0700 (PDT)
In-Reply-To: <20161025163327.2179-1-colin.king@canonical.com> (Colin King's
        message of "Tue, 25 Oct 2016 17:33:27 +0100")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Colin King <colin.king@canonical.com>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Ulf Hansson <ulf.hansson@linaro.org>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

Colin King <colin.king@canonical.com> writes:

> From: Colin Ian King <colin.king@canonical.com>
>
> The return from of_count_phandle_with_args can be negative, so we
> should avoid kcalloc of a negative count of genpd_power_stat structs
> by sanity checking if count is zero or less.
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Acked-by: Kevin Hilman <khilman@baylibre.com>

> ---
>  drivers/base/power/domain.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index aac656a..661737c 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -2113,7 +2113,7 @@ int of_genpd_parse_idle_states(struct device_node *dn,
>  	struct of_phandle_iterator it;
>  
>  	count = of_count_phandle_with_args(dn, "domain-idle-states", NULL);
> -	if (!count)
> +	if (count <= 0)
>  		return -EINVAL;
>  
>  	st = kcalloc(count, sizeof(*st), GFP_KERNEL);
