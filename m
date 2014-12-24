From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 2/4] PM / OPP: fix warning in of_free_opp_table
Date: Wed, 24 Dec 2014 10:42:19 -0600
Message-ID: <549AECEB.7020505@ti.com>
References: <1418771379-24369-1-git-send-email-dtor@chromium.org>	<1418771379-24369-3-git-send-email-dtor@chromium.org> <CAKohpok+_wee9HwvQqpn7HRj_9zH3EifNn0MX_1yXx=WJuK0RQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:50709 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752013AbaLXQmd (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 24 Dec 2014 11:42:33 -0500
In-Reply-To: <CAKohpok+_wee9HwvQqpn7HRj_9zH3EifNn0MX_1yXx=WJuK0RQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Dmitry Torokhov <dtor@chromium.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Stefan Wahren <stefan.wahren@i2se.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

$subject:
PM / OPP: Do not warn when no OPP was ever registered in of_free_opp_ta=
ble

might be more appropriate?

On 12/16/2014 10:28 PM, Viresh Kumar wrote:
> On 17 December 2014 at 04:39, Dmitry Torokhov <dtor@chromium.org> wro=
te:
>> Not having OPP defined for a device is not a crime, we should not sp=
lat
>> warning in this case. Also, it seems that we are ready to accept inv=
alid
>> dev (find_device_opp will return ERR_PTR(-EINVAL) then) so let's not
>> crash in dev_name() in such case.
>>
>> Signed-off-by: Dmitry Torokhov <dtor@chromium.org>
>> ---
>>  drivers/base/power/opp.c | 10 ++++++++--
>>  1 file changed, 8 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/base/power/opp.c b/drivers/base/power/opp.c
>> index b78c14d..413c7fe 100644
>> --- a/drivers/base/power/opp.c
>> +++ b/drivers/base/power/opp.c
>> @@ -799,9 +799,15 @@ void of_free_opp_table(struct device *dev)
>>
>>         /* Check for existing list for 'dev' */
>>         dev_opp =3D find_device_opp(dev);
>> -       if (WARN(IS_ERR(dev_opp), "%s: dev_opp: %ld\n", dev_name(dev=
),
>> -                PTR_ERR(dev_opp)))
>> +       if (IS_ERR(dev_opp)) {
>> +               int error =3D PTR_ERR(dev_opp);
>> +               if (error !=3D -ENODEV)
>> +                       WARN(1, "%s: dev_opp: %ld\n",
>> +                            IS_ERR_OR_NULL(dev) ?
>> +                                       "Invalid device" : dev_name(=
dev),
>> +                            error);
>>                 return;
>=20
> What about this:
>=20
>         if (IS_ERR(dev_opp)) {
>                 int error =3D PTR_ERR(dev_opp);
>                 WARN(error !=3D -ENODEV, "%s: dev_opp: %ld\n",
>                      IS_ERR_OR_NULL(dev) ?  "Invalid device" : dev_na=
me(dev),
>                      error);
>                 return;
>         }
Adds the following build warning: I suggest changing the %ld to %d

"warning: format =E2=80=98%ld=E2=80=99 expects argument of type =E2=80=98=
long int=E2=80=99, but
argument 5 has type =E2=80=98int=E2=80=99 [-Wformat]"


This also fixes the warning I got on AM437x based platforms. test resul=
ts:
1: am437x-sk: BOOT: PASS: crit=3D2 err=3D13 warn=3D25, CPUFreq: N/A,
CPUIdle: N/A: http://slexy.org/raw/s20MAtNEbt
 2: am437x-sk-before: BOOT: PASS: crit=3D2 err=3D13 warn=3D57, CPUFreq:=
 N/A,
CPUIdle: N/A: http://slexy.org/raw/s21rZCo4cD

With the suggested changes,

Acked-by: Nishanth Menon <nm@ti.com>

>=20
> We can get rid of the extra indentation level and an extra comparison=
 check.
>=20
> Otherwise:
>=20
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>


PS: I am sure you have already done some level of checks, but I
suggest using something like aiaiai or
https://github.com/nmenon/kernel_patch_verify or other solutions like
those discussed in
https://plus.google.com/112464029509057661457/posts/5LTuHHMyXLT to
help do some initial clean up of the patches..


--=20
Regards,
Nishanth Menon
