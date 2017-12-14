From: Andy Tang <andy.tang@nxp.com>
Subject: RE: Ask for help on governor
Date: Thu, 14 Dec 2017 02:42:03 +0000
Message-ID: <HE1PR0402MB2828076F9049436EFE149A29F30A0@HE1PR0402MB2828.eurprd04.prod.outlook.com>
References: <HE1PR0402MB282866171A847AE244A9F76CF3340@HE1PR0402MB2828.eurprd04.prod.outlook.com>
 <000801d37364$d48f6ed0$7dae4c70$@net> <000f01d373bf$deacca10$9c065e30$@net>
 <20171213061759.GT25177@vireshk-i7> P0QweRTHbuQ9TP0R1eouYx
 <000701d37479$e0570320$a1050960$@net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-he1eur01on0058.outbound.protection.outlook.com ([104.47.0.58]:10704
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751625AbdLNCmJ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 13 Dec 2017 21:42:09 -0500
In-Reply-To: <000701d37479$e0570320$a1050960$@net>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Doug Smythies <dsmythies@telus.net>, 'Viresh Kumar' <viresh.kumar@linaro.org>, 'Stratos Karafotis' <stratosk@semaphore.gr>
Cc: "'Rafael J. Wysocki'" <rafael@kernel.org>, "'Rafael J. Wysocki'" <rjw@rjwysocki.net>, 'Linux PM' <linux-pm@vger.kernel.org>



> -----Original Message-----
> From: Doug Smythies [mailto:dsmythies@telus.net]
> Sent: Thursday, December 14, 2017 9:21 AM
> To: Andy Tang <andy.tang@nxp.com>; 'Viresh Kumar'
> <viresh.kumar@linaro.org>; 'Stratos Karafotis' <stratosk@semaphore.gr>
> Cc: 'Rafael J. Wysocki' <rafael@kernel.org>; 'Rafael J. Wysocki'
> <rjw@rjwysocki.net>; 'Linux PM' <linux-pm@vger.kernel.org>; Doug
> Smythies <dsmythies@telus.net>
> Subject: RE: Ask for help on governor
>=20
> diff --git a/drivers/cpufreq/cpufreq_governor.c
> b/drivers/cpufreq/cpufreq_governor.c
> index 58d4f4e..3493ca7 100644
> --- a/drivers/cpufreq/cpufreq_governor.c
> +++ b/drivers/cpufreq/cpufreq_governor.c
> @@ -222,6 +222,7 @@ unsigned int dbs_update(struct cpufreq_policy
> *policy)
>                         max_load =3D load;
>         }
>=20
> +       idle_periods =3D 0;

With this line added, conservative governor works well.

Ondemand governor still can't work well.
As I mentioned in earlier email, load varies from different sampling_rate.

Regards,
Andy

>         policy_dbs->idle_periods =3D idle_periods;
>=20
>         return max_load;
>=20
> And everything is fine.
>=20
> ... Doug
>=20
