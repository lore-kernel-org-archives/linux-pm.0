From: Chen Gang <gang.chen.5i5j@gmail.com>
Subject: Re: [PATCH v2] kernel/power/hibernate.c: use 'u64' instead of 's64'
 to avoid warning
Date: Tue, 22 Apr 2014 20:10:45 +0800
Message-ID: <53565C45.10101@gmail.com>
References: <5355C5F0.6020606@gmail.com> <535620C7.2080700@gmail.com> <53563BE4.6070703@gmail.com> <2615793.oZSY6rO6uY@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pb0-f52.google.com ([209.85.160.52]:47477 "EHLO
	mail-pb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932386AbaDVMKx (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 22 Apr 2014 08:10:53 -0400
In-Reply-To: <2615793.oZSY6rO6uY@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Pavel Machek <pavel@ucw.cz>, Guan Xuetao <gxt@mprc.pku.edu.cn>, len.brown@intel.com, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>



On 04/22/2014 07:29 PM, Rafael J. Wysocki wrote:
> On Tuesday, April 22, 2014 05:52:36 PM Chen Gang wrote:
>> On 04/22/2014 03:56 PM, Chen Gang wrote:
>>> On 04/22/2014 03:21 PM, Pavel Machek wrote:
>>>> On Tue 2014-04-22 09:29:20, Chen Gang wrote:
>>>>> For do_div(), it need 'u64' type, which means the outside must be=
 sure
>>>>> of 'start' is not bigger than 'stop', or it will report warning.
>>>>>
>>>>> Even if 'start' was really bigger than 'stop', it would print inc=
orrect
>>>>> information, but for kernel, it still can continue, so use WARN_O=
N() is
>>>>> enough.
>>>>>
>>>>> The related warning (with allmodconfig for unicore32):
>>>>>
>>>>>     CC      kernel/power/hibernate.o
>>>>>   kernel/power/hibernate.c: In function =E2=80=98swsusp_show_spee=
d=E2=80=99:
>>>>>   kernel/power/hibernate.c:237: warning: comparison of distinct p=
ointer types lacks a cast
>>>>>
>>>>>
>>>>
>>>> Certainly better, but
>>>>
>>>>> -	s64 elapsed_centisecs64;
>>>>> +	u64 elapsed_centisecs64;
>>>>>  	int centisecs;
>>>>>  	int k;
>>>>>  	int kps;
>>>>> =20
>>>>>  	elapsed_centisecs64 =3D timeval_to_ns(stop) - timeval_to_ns(sta=
rt);
>>>>> +	WARN_ON((s64)elapsed_centisecs64 < 0);
>>
>> How about to use one line comments instead of WARN_ON()?
>>
>> 	/*
>> 	 * If "(s64)elapsed_centisecs64 < 0", it will print long elapsed
>> 	 * time, it is obvious enough to user for what went wrong.
>> 	 */
>=20
> And will the users actually read this comment?
>=20

=46or subtractions, normally, need signed number, or may let code reade=
rs
notice about it. When the code readers read this comment, they will
understand, and save their time to think of.

Normally, it is not good to add comment within a function, except the
code is not written in a normal way, and need some comments to avoid
wasting readers' time.

> Please just change the type to silence the warning.  And you can chan=
ge all of
> the other local variables in that function to unsigned int when you'r=
e at it.
>=20

It is fine to me -- change all of the other local variables to unsigned=
 int.


Thanks.
--=20
Chen Gang

Open, share, and attitude like air, water, and life which God blessed
