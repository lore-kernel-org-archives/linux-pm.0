From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: Re: [PATCH V4 2/8] opp: call of_node_{get|put}() from of_init_opp_table()
Date: Fri, 30 May 2014 12:03:08 +0530
Message-ID: <CAK9yfHw1HSX_idrFGO5P0bxxwf8iyd1J7MfNyqHGa45E-ZbZww@mail.gmail.com>
References: <cover.1401191054.git.viresh.kumar@linaro.org>
	<4139797fe7501ba99adf63ec8e5cf9fa9b24c197.1401191054.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f173.google.com ([209.85.214.173]:45982 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751782AbaE3GdJ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 30 May 2014 02:33:09 -0400
Received: by mail-ob0-f173.google.com with SMTP id wm4so1397184obc.32
        for <linux-pm@vger.kernel.org>; Thu, 29 May 2014 23:33:08 -0700 (PDT)
In-Reply-To: <4139797fe7501ba99adf63ec8e5cf9fa9b24c197.1401191054.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, arvind.chauhan@arm.com, inderpal.s@samsung.com, Nishanth Menon <nm@ti.com>, Chander Kashyap <chander.kashyap@linaro.org>, Pavel Machek <pavel@ucw.cz>, len.brown@intel.com, sudeep.holla@arm.com

Hi Viresh,

On 27 May 2014 17:20, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> All callers of of_init_opp_table() are required to take reference of
> dev->of_node, by initiating calls to of_node_{get|put}(), before and after
> calling of_init_opp_table().
>
> Its better to call these from within of_init_opp_table(), no fun adding
> redundant code to every caller.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/base/power/opp.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/base/power/opp.c b/drivers/base/power/opp.c
> index faae9cf..2b615b9 100644
> --- a/drivers/base/power/opp.c
> +++ b/drivers/base/power/opp.c
> @@ -622,6 +622,9 @@ int of_init_opp_table(struct device *dev)
>         const __be32 *val;
>         int nr;
>
> +       if (!of_node_get(dev->of_node))
> +               return -ENODEV;
> +
>         prop = of_find_property(dev->of_node, "operating-points", NULL);
>         if (!prop)
>                 return -ENODEV;

What about of_node_put before returning here and other places in this function?

-- 
With warm regards,
Sachin
