From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH 6/6] PM / devfreq: Set the min_freq and max_freq of devfreq
 device
Date: Thu, 19 Nov 2015 19:37:22 +0900
Message-ID: <564DA662.5060207@samsung.com>
References: <932082455.1194101447927858604.JavaMail.weblogic@ep2mlwas06b>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:54378 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932355AbbKSKhY (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 19 Nov 2015 05:37:24 -0500
In-reply-to: <932082455.1194101447927858604.JavaMail.weblogic@ep2mlwas06b>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: myungjoo.ham@samsung.com, =?UTF-8?B?67CV6rK966+8?= <kyungmin.park@samsung.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On 2015=EB=85=84 11=EC=9B=94 19=EC=9D=BC 19:10, MyungJoo Ham wrote:
>> After probing the devfreq device driver, the value of both min_freq =
and
>> max_freq are zero(0). So, this patch initializes the 'min_freq' and =
'max_freq'
>> field of devfreq device by using the freq_table array.
>>
>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
>> ---
>>  drivers/devfreq/devfreq.c | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
>> index c292ceb7ff19..0b24ae7b7a48 100644
>> --- a/drivers/devfreq/devfreq.c
>> +++ b/drivers/devfreq/devfreq.c
>> @@ -121,6 +121,11 @@ static void devfreq_set_freq_table(struct devfr=
eq *devfreq)
>>  		profile->freq_table[i] =3D freq;
>>  	}
>>  	rcu_read_unlock();
>> +
>> +	mutex_lock(&devfreq->lock);
>> +	devfreq->min_freq =3D profile->freq_table[0];
>> +	devfreq->max_freq =3D profile->freq_table[profile->max_state - 1];
>> +	mutex_unlock(&devfreq->lock);
>>  }
>=20
> No, you should not do this.
>=20
> It is allowed to use devfreq without both OPP and freq_table
> assuming that the devfreq device may operate with very many
> frequencies so that practically, we can virtually give it
> any frequency numbers in a given range.
> (cases where profile->max_state is 0 and it is not an error)
>=20
> The value 0 is used for min/max_freq to declare
> that min/max_freq is deactivated. Therefore, it is not
> required to do so; they are not intended to show the hardware
> configuration as well.

This case consider the devfreq device using OPP because devfreq_set_fre=
q_table()
get the number of OPP entry in OPP list before setting the min_freq/max=
_freq.
If the devfreq device don't use the OPP entry, devfreq_set_freq_table()
will return without any operation.

IMHO, when devfreq device uses the OPP table including the frequency,
min_freq/max_freq should show the correct value as CPUFREQ framework.

Regards,
Chanwoo CHoi



