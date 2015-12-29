From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH v2] Documentation: cpufreq: intel_pstate: enhance documentation
Date: Mon, 28 Dec 2015 16:44:16 -0800
Message-ID: <5681D760.6090309@linux.intel.com>
References: <1451326526-6367-1-git-send-email-srinivas.pandruvada@linux.intel.com> <36DF59CE26D8EE47B0655C516E9CE6402869140A@shsmsx102.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:13430 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751257AbbL2Aoh (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 28 Dec 2015 19:44:37 -0500
In-Reply-To: <36DF59CE26D8EE47B0655C516E9CE6402869140A@shsmsx102.ccr.corp.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Chen, Yu C" <yu.c.chen@intel.com>, "dsmythies@telus.net" <dsmythies@telus.net>
Cc: "Brown, Len" <len.brown@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "rafael@kernel.org" <rafael@kernel.org>



On 12/28/2015 04:17 PM, Chen, Yu C wrote:
> Hi,
>
>> -----Original Message-----
>> From: linux-pm-owner@vger.kernel.org [mailto:linux-pm-
>> owner@vger.kernel.org] On Behalf Of Srinivas Pandruvada
>> Sent: Tuesday, December 29, 2015 2:15 AM
>> To: rafael@kernel.org; dsmythies@telus.net
>> Cc: Brown, Len; linux-pm@vger.kernel.org; Srinivas Pandruvada
>> Subject: [PATCH v2] Documentation: cpufreq: intel_pstate: enhance
>> documentation
>>
>> This is an attempt to make documentation more user friendly.
>>
>> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.=
com>
>> ---
>> Changes in v2:
>> 	Suggested by Doug Smythies
>> 		- Grammar correction
>> 		- Use default PID and impact of setpoint on ramp up times
>>
>>
>>   Documentation/cpu-freq/intel-pstate.txt | 193
>> +++++++++++++++++++++++++-------
>>   1 file changed, 151 insertions(+), 42 deletions(-)
>>
>> diff --git a/Documentation/cpu-freq/intel-pstate.txt b/Documentation=
/cpu-
>> freq/intel-pstate.txt
>> index be8d400..5398a66 100644
>> --- a/Documentation/cpu-freq/intel-pstate.txt
>> +++ b/Documentation/cpu-freq/intel-pstate.txt
>> @@ -1,61 +1,131 @@
>> -Intel P-state driver
>> +Intel P-State driver
>>   --------------------
>>
>> +For the same load at setpoint =3D 60, this will result in the next
>> +P-State =3D 0x08 - ((60 - 100) * 0.2) =3D 16 So by changing the set=
point
>> +from 97 to 60, there is an increase of the next P-State from 9 to 1=
6.
>> +So this will make processor execute at higher P-State for the same =
CPU
>> +load. If the load continues to be more than the setpoint during nex=
t
>> +sample intervals, then P-State will go up again till the maximum
>> +P-State is reached. But the ramp up time to reach the maximum P-Sta=
te
>> +will be much faster when the setpoint is 60 compared to 97.
>> --
> Just inspired by another thread in the maillist, how about adding a d=
escription
> on suggesting  enable the ftrace  when user is trying to do some debu=
g/tuning?
>

Good idea. Will add to next version.

Thanks,
Srinivas


> thanks,
> yu
> N=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDr=EF=BF=BD=EF=BF=BDy=EF=
=BF=BD=EF=BF=BD=EF=BF=BDb=EF=BF=BDX=EF=BF=BD=EF=BF=BD=C7=A7v=EF=BF=BD^=EF=
=BF=BD)=DE=BA{.n=EF=BF=BD+=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD{=EF=BF=BD=
=EF=BF=BDh=EF=BF=BD=EF=BF=BD=17=EF=BF=BD=EF=BF=BD=DC=A8}=EF=BF=BD=EF=BF=
=BD=EF=BF=BD=C6=A0z=EF=BF=BD&j:+v=EF=BF=BD=EF=BF=BD=EF=BF=BD=07=EF=BF=BD=
=EF=BF=BD=EF=BF=BD=EF=BF=BDzZ+=EF=BF=BD=EF=BF=BD+zf=EF=BF=BD=EF=BF=BD=EF=
=BF=BDh=EF=BF=BD=EF=BF=BD=EF=BF=BD~=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=
i=EF=BF=BD=EF=BF=BD=EF=BF=BDz=EF=BF=BD=1E=EF=BF=BDw=EF=BF=BD=EF=BF=BD=EF=
=BF=BD?=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD&=EF=BF=BD)=DF=A2=1Bfl=3D=3D=
=3D
>
