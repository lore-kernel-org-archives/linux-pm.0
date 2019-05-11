From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH - resend 1/3] thermal/drivers/cpu_cooling: Fixup the
 header and copyright
Date: Sat, 11 May 2019 12:25:00 -0700
Message-ID: <20190511192451.GA15554@localhost.localdomain>
References: <20190428095106.5171-1-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190428095106.5171-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: rui.zhang@intel.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Amit Daniel Kachhap <amit.kachhap@gmail.com>, Viresh Kumar <viresh.kumar@linaro.org>, Javi Merino <javi.merino@kernel.org>
List-Id: linux-pm@vger.kernel.org

On Sun, Apr 28, 2019 at 11:51:03AM +0200, Daniel Lezcano wrote:
> The copyright format does not conform to the format requested by
> Linaro: https://wiki.linaro.org/Copyright
>=20
> Fix it.
>=20
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Viresh Kumar <viresh.kumar@linaro.org>

Based on the series and other patches of it, I am assuming this is an
Acked-by..

Applied as Acked-by.

> ---
>  drivers/thermal/cpu_cooling.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
> index ee8419a6390c..42aeb9087cab 100644
> --- a/drivers/thermal/cpu_cooling.c
> +++ b/drivers/thermal/cpu_cooling.c
> @@ -2,9 +2,11 @@
>   *  linux/drivers/thermal/cpu_cooling.c
>   *
>   *  Copyright (C) 2012	Samsung Electronics Co., Ltd(http://www.samsung.c=
om)
> - *  Copyright (C) 2012  Amit Daniel <amit.kachhap@linaro.org>
>   *
> - *  Copyright (C) 2014  Viresh Kumar <viresh.kumar@linaro.org>
> + *  Copyright (C) 2012-2018 Linaro Limited.
> + *
> + *  Authors:	Amit Daniel <amit.kachhap@linaro.org>
> + *		Viresh Kumar <viresh.kumar@linaro.org>
>   *
>   * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~
>   *  This program is free software; you can redistribute it and/or modify
