From: Chen Gang <gang.chen.5i5j@gmail.com>
Subject: Re: [PATCH v2] kernel/power/hibernate.c: use 'u64' instead of 's64'
 to avoid warning
Date: Tue, 22 Apr 2014 15:56:55 +0800
Message-ID: <535620C7.2080700@gmail.com>
References: <5355C5F0.6020606@gmail.com> <20140422072112.GB14108@amd.pavel.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140422072112.GB14108@amd.pavel.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Guan Xuetao <gxt@mprc.pku.edu.cn>, len.brown@intel.com, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 04/22/2014 03:21 PM, Pavel Machek wrote:
> On Tue 2014-04-22 09:29:20, Chen Gang wrote:
>> For do_div(), it need 'u64' type, which means the outside must be su=
re
>> of 'start' is not bigger than 'stop', or it will report warning.
>>
>> Even if 'start' was really bigger than 'stop', it would print incorr=
ect
>> information, but for kernel, it still can continue, so use WARN_ON()=
 is
>> enough.
>>
>> The related warning (with allmodconfig for unicore32):
>>
>>     CC      kernel/power/hibernate.o
>>   kernel/power/hibernate.c: In function =E2=80=98swsusp_show_speed=E2=
=80=99:
>>   kernel/power/hibernate.c:237: warning: comparison of distinct poin=
ter types lacks a cast
>>
>>
>=20
> Certainly better, but
>=20
>> -	s64 elapsed_centisecs64;
>> +	u64 elapsed_centisecs64;
>>  	int centisecs;
>>  	int k;
>>  	int kps;
>> =20
>>  	elapsed_centisecs64 =3D timeval_to_ns(stop) - timeval_to_ns(start)=
;
>> +	WARN_ON((s64)elapsed_centisecs64 < 0);
>>  	do_div(elapsed_centisecs64, NSEC_PER_SEC / 100);
>>  	centisecs =3D elapsed_centisecs64;
>=20
> ...do we need to do the WARN_ON()? Only result of underflow will be
> very long elapsed time reported... that does not sound too
> bad. ... and it will be quite obvious what went wrong.
> 									Pavel
>=20

Hmm... that sounds reasonable to me.  If no any other reply within 2
days, I shall send patch v3 for it.

BTW: sorry, I guess I can not finish allmodconfig for unicore32 within
this month (2014-04-30) -- at present I only finish 40-50%, I
will/should try to finish it within next month.


Thanks.
--=20
Chen Gang

Open, share, and attitude like air, water, and life which God blessed
