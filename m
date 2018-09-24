From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH] thermal: power_allocator: remove early break
Date: Mon, 24 Sep 2018 09:45:32 -0700
Message-ID: <20180924164531.GB4988@localhost.localdomain>
References: <20180921130609.j3esni6xwhi2ew7d@inc028000032.lancs.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180921130609.j3esni6xwhi2ew7d@inc028000032.lancs.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Willy Wolff <willy.mh.wolff.ml@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hey,

On Fri, Sep 21, 2018 at 02:06:09PM +0100, Willy Wolff wrote:
> If a trip of type critical is defined before any trip of passive
> or active type, power_allocator governor will not switch on.


But, if a critical trip is reached, the expectation is to perform a
thermal shutdown. Why would you expect to have power allocator
to be activated during the process of a shutdown?

>=20
> Signed-off-by: Willy Wolff <willy.mh.wolff.ml@gmail.com>
> ---
>  drivers/thermal/power_allocator.c | 2 --
>  1 file changed, 2 deletions(-)
>=20
> diff --git a/drivers/thermal/power_allocator.c b/drivers/thermal/power_al=
locator.c
> index 3055f9a12a17..6544b68e3ebf 100644
> --- a/drivers/thermal/power_allocator.c
> +++ b/drivers/thermal/power_allocator.c
> @@ -496,8 +496,6 @@ static void get_governor_trips(struct thermal_zone_de=
vice *tz,
>  			}
>  		} else if (type =3D=3D THERMAL_TRIP_ACTIVE) {
>  			last_active =3D i;
> -		} else {
> -			break;
>  		}
>  	}
> =20
> --=20
> 2.11.0
>=20
