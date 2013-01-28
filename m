From: Lan Tianyu <lantianyu1986@gmail.com>
Subject: Re: [PATCH] PM/CORE: Fix using sizeof without parenthesis in the
 sysfs.c
Date: Mon, 28 Jan 2013 21:04:29 +0800
Message-ID: <5106775D.1080101@gmail.com>
References: <1359361909-28793-1-git-send-email-tianyu.lan@intel.com> <CAAMvbhEx69V026n4uhyPrq2aOXcx_vR1PQ-1-k2245JvSXQ=6A@mail.gmail.com> <3030648.5OBcUztiBY@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <3030648.5OBcUztiBY@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: James Courtier-Dutton <james.dutton@gmail.com>, Lan Tianyu <tianyu.lan@intel.com>, linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

=E4=BA=8E 2013/1/28 20:18, Rafael J. Wysocki =E5=86=99=E9=81=93:
> On Monday, January 28, 2013 09:03:28 AM James Courtier-Dutton wrote:
>> On 28 January 2013 08:31, Lan Tianyu <tianyu.lan@intel.com> wrote:
>>> -       if (len =3D=3D sizeof ctrl_auto - 1 && strncmp(buf, ctrl_au=
to, len) =3D=3D 0)
>>> +       if (len =3D=3D sizeof(ctrl_auto - 1) && strncmp(buf, ctrl_a=
uto, len) =3D=3D 0)
>>
>> This looks wrong to me.
>> sizeof ctrl_auto - 1
>> is not the same value as
>> sizeof(ctrl_auto - 1)
>> because sizeof(x) is normally the same as sizeof(x - 1), unless size=
of
>> x and sizeof 1 are different.
>> Consider that is maybe should be:
>> if (len =3D=3D (sizeof(ctrl_auto) - 1)) && strncmp(buf, ctrl_auto, l=
en) =3D=3D 0)
Hi James:
	Yes. You are correct. Thanks for your review.
>
> The outer parentheses in the comparison with len are not necessary.
>
>> I a not sure what the correct answer is for this particular bit of
>> code, because I have not looked at it in detail,I just wanted to poi=
nt
>> out that the brackets might be in the wrong place here.
>
> You are right and the patch doesn't make sense.
Hi Rafael:
	So this patch is not necessary?
>
> Thanks,
> Rafael
>
>

--=20
Best regards
Tianyu Lan
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
