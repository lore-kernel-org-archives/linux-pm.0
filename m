From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 10/16] cpuidle: remove vestage definition of cpuidle_state_usage.driver_data
Date: Mon, 11 Feb 2013 09:48:00 +0100
Message-ID: <5118B040.9010600@linaro.org>
References: <1360372100-28482-1-git-send-email-lenb@kernel.org> <fe265459a3bbcfada267f181f00b83fb02f6d5cb.1360371180.git.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:34162 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751025Ab3BKIr7 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 11 Feb 2013 03:47:59 -0500
Received: by mail-wg0-f44.google.com with SMTP id dr12so4394267wgb.23
        for <linux-pm@vger.kernel.org>; Mon, 11 Feb 2013 00:47:58 -0800 (PST)
In-Reply-To: <fe265459a3bbcfada267f181f00b83fb02f6d5cb.1360371180.git.len.brown@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>

On 02/09/2013 02:08 AM, Len Brown wrote:
> From: Len Brown <len.brown@intel.com>
>=20
> This field is no longer used.
>=20
> Signed-off-by: Len Brown <len.brown@intel.com>

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

> ---
>  include/linux/cpuidle.h | 22 ----------------------
>  1 file changed, 22 deletions(-)
>=20
> diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
> index 24cd1037..480c14d 100644
> --- a/include/linux/cpuidle.h
> +++ b/include/linux/cpuidle.h
> @@ -32,8 +32,6 @@ struct cpuidle_driver;
>   ****************************/
> =20
>  struct cpuidle_state_usage {
> -	void		*driver_data;
> -
>  	unsigned long long	disable;
>  	unsigned long long	usage;
>  	unsigned long long	time; /* in US */
> @@ -62,26 +60,6 @@ struct cpuidle_state {
> =20
>  #define CPUIDLE_DRIVER_FLAGS_MASK (0xFFFF0000)
> =20
> -/**
> - * cpuidle_get_statedata - retrieves private driver state data
> - * @st_usage: the state usage statistics
> - */
> -static inline void *cpuidle_get_statedata(struct cpuidle_state_usage=
 *st_usage)
> -{
> -	return st_usage->driver_data;
> -}
> -
> -/**
> - * cpuidle_set_statedata - stores private driver state data
> - * @st_usage: the state usage statistics
> - * @data: the private data
> - */
> -static inline void
> -cpuidle_set_statedata(struct cpuidle_state_usage *st_usage, void *da=
ta)
> -{
> -	st_usage->driver_data =3D data;
> -}
> -
>  struct cpuidle_device {
>  	unsigned int		registered:1;
>  	unsigned int		enabled:1;
>=20


--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for=
 ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

