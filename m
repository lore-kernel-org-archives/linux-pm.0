From: Lan Tianyu <lantianyu1986@gmail.com>
Subject: Re: [PATCH] PM/CORE: Fix using sizeof without parenthesis in the
 sysfs.c
Date: Mon, 28 Jan 2013 21:39:19 +0800
Message-ID: <51067F87.5070005@gmail.com>
References: <1359361909-28793-1-git-send-email-tianyu.lan@intel.com> <3030648.5OBcUztiBY@vostro.rjw.lan> <5106775D.1080101@gmail.com> <13740912.iO1omHu2tD@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:60498 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756268Ab3A1Nj3 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 28 Jan 2013 08:39:29 -0500
In-Reply-To: <13740912.iO1omHu2tD@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: James Courtier-Dutton <james.dutton@gmail.com>, Lan Tianyu <tianyu.lan@intel.com>, linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org

=D3=DA 2013/1/28 21:13, Rafael J. Wysocki =D0=B4=B5=C0:
> On Monday, January 28, 2013 09:04:29 PM Lan Tianyu wrote:
>> =D3=DA 2013/1/28 20:18, Rafael J. Wysocki =D0=B4=B5=C0:
>>> On Monday, January 28, 2013 09:03:28 AM James Courtier-Dutton wrote=
:
>>>> On 28 January 2013 08:31, Lan Tianyu <tianyu.lan@intel.com> wrote:
>>>>> -       if (len =3D=3D sizeof ctrl_auto - 1 && strncmp(buf, ctrl_=
auto, len) =3D=3D 0)
>>>>> +       if (len =3D=3D sizeof(ctrl_auto - 1) && strncmp(buf, ctrl=
_auto, len) =3D=3D 0)
>>>>
>>>> This looks wrong to me.
>>>> sizeof ctrl_auto - 1
>>>> is not the same value as
>>>> sizeof(ctrl_auto - 1)
>>>> because sizeof(x) is normally the same as sizeof(x - 1), unless si=
zeof
>>>> x and sizeof 1 are different.
>>>> Consider that is maybe should be:
>>>> if (len =3D=3D (sizeof(ctrl_auto) - 1)) && strncmp(buf, ctrl_auto,=
 len) =3D=3D 0)
>> Hi James:
>> 	Yes. You are correct. Thanks for your review.
>>>
>>> The outer parentheses in the comparison with len are not necessary.
>>>
>>>> I a not sure what the correct answer is for this particular bit of
>>>> code, because I have not looked at it in detail,I just wanted to p=
oint
>>>> out that the brackets might be in the wrong place here.
>>>
>>> You are right and the patch doesn't make sense.
>> Hi Rafael:
>> 	So this patch is not necessary?
>=20
> It is incorrect in the first place.
>=20
Yeah. Sorry for this and will be careful.
> Yes, you could change spaces to parentheses in those places, but firs=
t, please
> do that correctly and second, it's just going to be a cosmetic change=
=2E  The
> code works as is.
Ok. I get it.
>=20
> Thanks,
> Rafael
>=20
>=20

--=20
Best regards
Tianyu Lan
