From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 09/10] cpuidle: declare cpuidle_dev in cpuidle.h
Date: Thu, 20 Feb 2014 14:35:18 +0100
Message-ID: <53060496.6000303@linaro.org>
References: <1389794137-11361-1-git-send-email-paul.burton@imgtec.com> <1389794137-11361-10-git-send-email-paul.burton@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-we0-f170.google.com ([74.125.82.170]:63828 "EHLO
	mail-we0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754506AbaBTNfU (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 20 Feb 2014 08:35:20 -0500
Received: by mail-we0-f170.google.com with SMTP id w62so1476275wes.29
        for <linux-pm@vger.kernel.org>; Thu, 20 Feb 2014 05:35:19 -0800 (PST)
In-Reply-To: <1389794137-11361-10-git-send-email-paul.burton@imgtec.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Paul Burton <paul.burton@imgtec.com>, linux-mips@linux-mips.org
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org

On 01/15/2014 02:55 PM, Paul Burton wrote:
> Declaring this allows drivers which need to initialise each struct
> cpuidle_device at initialisation time to make use of the structures
> already defined in cpuidle.c, rather than having to wastefully define
> their own.
>
> Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: linux-pm@vger.kernel.org
> ---
>   include/linux/cpuidle.h | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
> index 50fcbb0..bab4f33 100644
> --- a/include/linux/cpuidle.h
> +++ b/include/linux/cpuidle.h
> @@ -84,6 +84,7 @@ struct cpuidle_device {
>   };
>
>   DECLARE_PER_CPU(struct cpuidle_device *, cpuidle_devices);
> +DECLARE_PER_CPU(struct cpuidle_device, cpuidle_dev);


Nak. When a device is registered, it is assigned to the cpuidle_devices=
=20
pointer and the backend driver should use it.



--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

