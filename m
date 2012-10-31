From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] cpuidle - sysfs : move declaration in the sysfs file
Date: Wed, 31 Oct 2012 01:46:09 +0100
Message-ID: <2583088.uKNgEVIRXU@vostro.rjw.lan>
References: <1351165577-32020-1-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([193.178.161.156]:47322 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932320Ab2JaAmH (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 30 Oct 2012 20:42:07 -0400
In-Reply-To: <1351165577-32020-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linaro-dev@lists.linaro.org, patches@linaro.org, linux-pm@vger.kernel.org

On Thursday, October 25, 2012 01:46:17 PM Daniel Lezcano wrote:
> The structure cpuidle_state_kobj is not used anywhere except
> in the sysfs.c file. The definition of this structure is not
> needed in the cpuidle header file. This patch moves it to the
> sysfs.c file in order to encapsulate the code a bit more.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Applied to the linux-next branch of linux-pm.git as v3.8 material.

Thanks,
Rafael


> ---
>  drivers/cpuidle/sysfs.c |    7 +++++++
>  include/linux/cpuidle.h |    7 -------
>  2 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/cpuidle/sysfs.c b/drivers/cpuidle/sysfs.c
> index ed87399..f15c1e5 100644
> --- a/drivers/cpuidle/sysfs.c
> +++ b/drivers/cpuidle/sysfs.c
> @@ -297,6 +297,13 @@ static struct attribute *cpuidle_state_default_attrs[] = {
>  	NULL
>  };
>  
> +struct cpuidle_state_kobj {
> +	struct cpuidle_state *state;
> +	struct cpuidle_state_usage *state_usage;
> +	struct completion kobj_unregister;
> +	struct kobject kobj;
> +};
> +
>  #define kobj_to_state_obj(k) container_of(k, struct cpuidle_state_kobj, kobj)
>  #define kobj_to_state(k) (kobj_to_state_obj(k)->state)
>  #define kobj_to_state_usage(k) (kobj_to_state_obj(k)->state_usage)
> diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
> index 279b1ea..7daf0e3 100644
> --- a/include/linux/cpuidle.h
> +++ b/include/linux/cpuidle.h
> @@ -82,13 +82,6 @@ cpuidle_set_statedata(struct cpuidle_state_usage *st_usage, void *data)
>  	st_usage->driver_data = data;
>  }
>  
> -struct cpuidle_state_kobj {
> -	struct cpuidle_state *state;
> -	struct cpuidle_state_usage *state_usage;
> -	struct completion kobj_unregister;
> -	struct kobject kobj;
> -};
> -
>  struct cpuidle_device {
>  	unsigned int		registered:1;
>  	unsigned int		enabled:1;

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
