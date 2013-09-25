From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 07/21] cpuidle: rearrange __cpuidle_register_device()
 to keep minimal exit points
Date: Wed, 25 Sep 2013 23:49:40 +0200
Message-ID: <52435A74.3060808@linaro.org>
References: <cover.1379779777.git.viresh.kumar@linaro.org> <2dd257d9843954aaaf0cf30c7fb475daded018a5.1379779777.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:55175 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751070Ab3IYVtn (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 25 Sep 2013 17:49:43 -0400
Received: by mail-wi0-f182.google.com with SMTP id ez12so317393wid.3
        for <linux-pm@vger.kernel.org>; Wed, 25 Sep 2013 14:49:42 -0700 (PDT)
In-Reply-To: <2dd257d9843954aaaf0cf30c7fb475daded018a5.1379779777.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, rjw@sisk.pl
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On 09/22/2013 03:20 AM, Viresh Kumar wrote:
> This patch rearranges __cpuidle_register_device() a bit in order to r=
educe the
> number of exit points of this function.
>=20
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpuidle/cpuidle.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
> index 211e504..8c91bad 100644
> --- a/drivers/cpuidle/cpuidle.c
> +++ b/drivers/cpuidle/cpuidle.c
> @@ -383,13 +383,12 @@ static int __cpuidle_register_device(struct cpu=
idle_device *dev)
>  	list_add(&dev->device_list, &cpuidle_detected_devices);
> =20
>  	ret =3D cpuidle_coupled_register_device(dev);
> -	if (ret) {
> +	if (ret)
>  		__cpuidle_unregister_device(dev);
> -		return ret;
> -	}
> +	else
> +		dev->registered =3D 1;
> =20
> -	dev->registered =3D 1;
> -	return 0;
> +	return ret;
>  }

There is no accounting for taste :)

I agree the patch concentrates more the return statement into a single
place which conforms better to the kernel coding style.

--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for=
 ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

