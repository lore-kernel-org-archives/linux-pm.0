From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 1/1] cpuidle: fix improper return value on error
Date: Thu, 08 Dec 2016 01:13:57 +0100
Message-ID: <1982823.a6RAEseNrp@aspire.rjw.lan>
References: <1480777347-7497-1-git-send-email-bianpan201602@163.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:59955 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933854AbcLHARo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 7 Dec 2016 19:17:44 -0500
In-Reply-To: <1480777347-7497-1-git-send-email-bianpan201602@163.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pan Bian <bianpan201602@163.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Pan Bian <bianpan2016@163.com>

On Saturday, December 03, 2016 11:02:27 PM Pan Bian wrote:
> From: Pan Bian <bianpan2016@163.com>
> 
> In function cpuidle_add_state_sysfs(), variable ret takes the return
> value. Its value should be negative on errors. Because ret is reset in
> the loop, its value will be 0 during the second and after repeat of the
> loop. If kzalloc() returns a NULL pointer then, it will return 0. It may
> be better to explicitly assign "-ENOMEM" when the call to kzalloc()
> fails.
> 
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=188901
> 
> Signed-off-by: Pan Bian <bianpan2016@163.com>
> ---
>  drivers/cpuidle/sysfs.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpuidle/sysfs.c b/drivers/cpuidle/sysfs.c
> index 832a2c3..c5adc8c 100644
> --- a/drivers/cpuidle/sysfs.c
> +++ b/drivers/cpuidle/sysfs.c
> @@ -403,8 +403,10 @@ static int cpuidle_add_state_sysfs(struct cpuidle_device *device)
>  	/* state statistics */
>  	for (i = 0; i < drv->state_count; i++) {
>  		kobj = kzalloc(sizeof(struct cpuidle_state_kobj), GFP_KERNEL);
> -		if (!kobj)
> +		if (!kobj) {
> +			ret = -ENOMEM;
>  			goto error_state;
> +		}
>  		kobj->state = &drv->states[i];
>  		kobj->state_usage = &device->states_usage[i];
>  		init_completion(&kobj->kobj_unregister);
> 

Applied.

Thanks,
Rafael

