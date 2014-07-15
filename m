From: Mohammad Merajul Islam Molla <meraj.enigma@gmail.com>
Subject: Re: [PATCH] cpuidle: fix permission for driver name sysfs node
Date: Tue, 15 Jul 2014 11:16:40 +0600
Message-ID: <CAHu9=sPxG49pCn10WTErHEV3ZZSF70+7ekZWJ-1+dd3Df8i8Wg@mail.gmail.com>
References: <1405171762-31119-1-git-send-email-meraj.enigma@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f179.google.com ([209.85.192.179]:54528 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751093AbaGOFRB (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 15 Jul 2014 01:17:01 -0400
In-Reply-To: <1405171762-31119-1-git-send-email-meraj.enigma@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Mohammad Merajul Islam Molla <meraj.enigma@gmail.com>

Hi Rafael/Daniel,

Did you get a chance to review the patch?

--
Thanks,
-Meraj

On Sat, Jul 12, 2014 at 7:29 PM, Mohammad Merajul Islam Molla
<meraj.enigma@gmail.com> wrote:
> cpuidle driver name sysfs node is read-only. So permission should be 0444.
>
> Signed-off-by: Mohammad Merajul Islam Molla <meraj.enigma@gmail.com>
> ---
>  drivers/cpuidle/sysfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/cpuidle/sysfs.c b/drivers/cpuidle/sysfs.c
> index efe2f17..97c5903 100644
> --- a/drivers/cpuidle/sysfs.c
> +++ b/drivers/cpuidle/sysfs.c
> @@ -445,7 +445,7 @@ static void cpuidle_remove_state_sysfs(struct cpuidle_device *device)
>
>  #define define_one_driver_ro(_name, show)                       \
>         static struct cpuidle_driver_attr attr_driver_##_name = \
> -               __ATTR(_name, 0644, show, NULL)
> +               __ATTR(_name, 0444, show, NULL)
>
>  struct cpuidle_driver_kobj {
>         struct cpuidle_driver *drv;
> --
> 1.9.1
>
