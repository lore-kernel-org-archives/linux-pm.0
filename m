From: Thomas Abraham <ta.omasab@gmail.com>
Subject: Re: [PATCH v8 3/6] ARM: dts: Exynos: add CPU OPP and regulator supply property
Date: Tue, 29 Jul 2014 18:05:18 +0530
Message-ID: <CAJuA9ag1xHm=vaXxXzj7ykKxYHxBndDsOTwN0vRdXvhb_DtQ2g@mail.gmail.com>
References: <1406611711-25112-1-git-send-email-thomas.ab@samsung.com>
	<1406611711-25112-4-git-send-email-thomas.ab@samsung.com>
	<53D78ED3.9090703@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-la0-f42.google.com ([209.85.215.42]:34104 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751358AbaG2MfU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 29 Jul 2014 08:35:20 -0400
In-Reply-To: <53D78ED3.9090703@suse.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Lukasz Majewski <l.majewski@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, Mike Turquette <mturquette@linaro.org>, =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, Viresh Kumar <viresh.kumar@linaro.org>, Tomasz Figa <t.figa@samsung.com>, Doug Anderson <dianders@chromium.org>, Chanwoo Choi <cw00.choi@samsung.com>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>

Hi Andreas,

On Tue, Jul 29, 2014 at 5:38 PM, Andreas F=C3=A4rber <afaerber@suse.de>=
 wrote:
> Hi Thomas,
>
> Am 29.07.2014 07:28, schrieb Thomas Abraham:
>> diff --git a/arch/arm/boot/dts/exynos5250-cros-common.dtsi b/arch/ar=
m/boot/dts/exynos5250-cros-common.dtsi
>> index 89ac90f..34bb31c 100644
>> --- a/arch/arm/boot/dts/exynos5250-cros-common.dtsi
>> +++ b/arch/arm/boot/dts/exynos5250-cros-common.dtsi
>> @@ -19,6 +19,12 @@
>>       chosen {
>>       };
>>
>> +     cpus {
>> +             cpu@0 {
>> +                     cpu0-supply =3D <&buck2_reg>;
>> +             };
>> +     };
>> +
>>       pinctrl@11400000 {
>>               /*
>>                * Disabled pullups since external part has its own pu=
llups and
>
> I've been instructed to dismantle this .dtsi file, so please place th=
is
> into exynos5250-snow.dts. It's probably wrong here anyway, since Spri=
ng
> doesn't use the max77686 but an s5m6787 PMIC.

Ok, I will move this to exynos5250-snow.dts.

>
> How do I find out which -supply to specify here for Spring?

This information can be found in the Spring board schematic.

>
> Also, wouldn't it make sense to assign a cpu0 label in exynos????.dts=
i
> to override it via &cpu0 { ... };?

Sorry, I did not understand the question.

Thanks,
Thomas.

>
> Regards,
> Andreas
>
> --
> SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
> GF: Jeff Hawn, Jennifer Guild, Felix Imend=C3=B6rffer; HRB 16746 AG N=
=C3=BCrnberg
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
