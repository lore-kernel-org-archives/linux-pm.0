From: Chen Gang <gang.chen.5i5j@gmail.com>
Subject: Re: [PATCH] kernel/power/hibernate.c: be sure of 'start' is not bigger
 than 'stop'
Date: Tue, 22 Apr 2014 08:58:34 +0800
Message-ID: <5355BEBA.8040001@gmail.com>
References: <53551FCB.3030109@gmail.com> <20140421200930.GA9880@amd.pavel.ucw.cz> <1597133.Gff7RjtQZQ@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f180.google.com ([209.85.192.180]:64243 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753252AbaDVA6j (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 21 Apr 2014 20:58:39 -0400
In-Reply-To: <1597133.Gff7RjtQZQ@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>
Cc: Guan Xuetao <gxt@mprc.pku.edu.cn>, len.brown@intel.com, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 04/22/2014 04:43 AM, Rafael J. Wysocki wrote:
> On Monday, April 21, 2014 10:09:30 PM Pavel Machek wrote:
>> On Mon 2014-04-21 21:40:27, Chen Gang wrote:
>>> For do_div(), it need 'u64' type, which means the outside must be s=
ure
>>> of 'start' is not bigger than 'stop', or it will report warning.
>>>
>>> The related warning (with allmodconfig for unicore32):
>>>
>>>     CC      kernel/power/hibernate.o
>>>   kernel/power/hibernate.c: In function =E2=80=98swsusp_show_speed=E2=
=80=99:
>>>   kernel/power/hibernate.c:237: warning: comparison of distinct poi=
nter types lacks a cast
>>>
>>> Signed-off-by: Chen Gang <gang.chen.5i5j@gmail.com>
>>
>>>  {
>>> -	s64 elapsed_centisecs64;
>>> +	u64 elapsed_centisecs64;
>>>  	int centisecs;
>>>  	int k;
>>>  	int kps;
>>> =20
>>>  	elapsed_centisecs64 =3D timeval_to_ns(stop) - timeval_to_ns(start=
);
>>> +	if ((s64)elapsed_centisecs64 < 0) {
>>> +		printk(KERN_ERR "PM: stop: %llu < start %llu\n",
>>> +			timeval_to_ns(stop), timeval_to_ns(start));
>>> +		return;
>>> +	}
>>>  	do_div(elapsed_centisecs64, NSEC_PER_SEC / 100);
>>>  	centisecs =3D elapsed_centisecs64;
>>>  	if (centisecs =3D=3D 0)
>>
>> Quite a lot of code to shut up warning in mostly debugging
>> function... is there alternative method of shutting it up? Have you
>> seen < 0 values in wild?
>=20
> No, I don't think so.  This is a purely theoretical problem that neve=
r
> happens in practice, because all of the callers do the right thing.
>=20
> Rafael=20
>=20

OK, it sounds fine to me, I shall send patch v2 for it.

Thanks.
--=20
Chen Gang

Open, share, and attitude like air, water, and life which God blessed
