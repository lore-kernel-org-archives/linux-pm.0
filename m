From: Wei Ni <wni@nvidia.com>
Subject: Re: [PATCH] thermal: of: fix cooling_spec.args for 64bit
Date: Thu, 7 May 2015 18:21:49 +0800
Message-ID: <554B3CBD.5030308@nvidia.com>
References: <1430972952-16303-1-git-send-email-wni@nvidia.com> <9hha8xg3ecb.fsf@e105922-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hqemgate16.nvidia.com ([216.228.121.65]:3397 "EHLO
	hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753072AbbEGKVp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 7 May 2015 06:21:45 -0400
In-Reply-To: <9hha8xg3ecb.fsf@e105922-lin.cambridge.arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Punit Agrawal <punit.agrawal@arm.com>
Cc: edubezval@gmail.com, rui.zhang@intel.com, linux-pm@vger.kernel.org



On 2015=E5=B9=B405=E6=9C=8807=E6=97=A5 17:51, Punit Agrawal wrote:
> Wei Ni <wni@nvidia.com> writes:
>=20
>> The THERMAL_NO_LIMIT is defined as -1UL, when it is set in DT,
>> the of-thermal will use of_parse_phandle_with_args() to parse it.
>> Since the args is uint32_t, so in 32bit system, the of framework
>> will read it as 0xffffffff, it's the expected value "-1".
>> But in 64bit system, this value is read as 0x00000000ffffffff,
>> it's not a negative value, it will cause problems.
>>
>> This change can fix this issue.
>=20
> If I understand the issue correctly, a patch fixing this is already
> merged. Does "commit a940cb34f: thermal: Fix cdev registration with
> THERMAL_NO_LIMIT on 64bit" not work for you?

Hmm, yes, this fix can work for me.
I made a mistake, and didn't notice this change.
Sorry, please ignore my patch.

Wei.

>=20
>>
>> Signed-off-by: Wei Ni <wni@nvidia.com>
>> ---
>>  drivers/thermal/of-thermal.c | 6 ++++--
>>  1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-therm=
al.c
>> index 9e8c614103ef..8d6b4070dea3 100644
>> --- a/drivers/thermal/of-thermal.c
>> +++ b/drivers/thermal/of-thermal.c
>> @@ -613,8 +613,10 @@ static int thermal_of_populate_bind_params(stru=
ct device_node *np,
>>  	}
>>  	__tbp->cooling_device =3D cooling_spec.np;
>>  	if (cooling_spec.args_count >=3D 2) { /* at least min and max */
>> -		__tbp->min =3D cooling_spec.args[0];
>> -		__tbp->max =3D cooling_spec.args[1];
>> +		__tbp->min =3D cooling_spec.args[0] =3D=3D -1U ?
>> +			THERMAL_NO_LIMIT : cooling_spec.args[0];
>> +		__tbp->max =3D cooling_spec.args[1] =3D=3D -1U ?
>> +			THERMAL_NO_LIMIT : cooling_spec.args[1];
>>  	} else {
>>  		pr_err("wrong reference to cooling device, missing limits\n");
>>  	}
-----------------------------------------------------------------------=
------------
This email message is for the sole use of the intended recipient(s) and=
 may contain
confidential information.  Any unauthorized review, use, disclosure or =
distribution
is prohibited.  If you are not the intended recipient, please contact t=
he sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------=
------------
