From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [RFC] cpuidle - remove the power_specified field in the driver
Date: Sun, 18 Nov 2012 10:17:47 +0100
Message-ID: <50A8A7BB.2070809@linaro.org>
References: <50831CA3.2020602@linaro.org> <1352752016-3136-1-git-send-email-daniel.lezcano@linaro.org> <50A89F08.7020307@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <50A89F08.7020307@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Francesco Lavra <francescolavra.fl@gmail.com>
Cc: linux-pm@vger.kernel.org, khilman@ti.com, deepthi@linux.vnet.ibm.com, g.trinabh@gmail.com, linaro-dev@lists.linaro.org, len.brown@intel.com, linux-kernel@vger.kernel.org, rjw@sisk.pl, jwerner@chromium.org, akpm@linux-foundation.org, snanda@chromium.org
List-Id: linux-pm@vger.kernel.org

On 11/18/2012 09:40 AM, Francesco Lavra wrote:
> Hi,
>=20
> On 11/12/2012 09:26 PM, Daniel Lezcano wrote:
>> This patch follows the discussion about reinitializing the power usa=
ge
>> when a C-state is added/removed.
>>
>>  https://lkml.org/lkml/2012/10/16/518
>>
>> We realized the power usage field is never filled and when it is
>> filled for tegra, the power_specified flag is not set making all the=
se
>> values to be resetted when the driver is initialized with the set_po=
wer_state
>> function.
>>
>> Julius and I feel this is over-engineered and the power_specified
>> flag could be simply removed and continue assuming the states are
>> backward sorted.
>>
>> The menu governor select function is simplified as the power is orde=
red.
>> Actually the condition is always true with the current code.
>>
>> The cpuidle_play_dead function is also simplified by doing a reverse=
 lookup
>> on the array.
>>
>> The set_power_states function is removed as it does no make sense an=
ymore.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> ---
>>  drivers/cpuidle/cpuidle.c        |   17 ++++-------------
>>  drivers/cpuidle/driver.c         |   25 -------------------------
>>  drivers/cpuidle/governors/menu.c |    8 ++------
>>  include/linux/cpuidle.h          |    2 +-
>>  4 files changed, 7 insertions(+), 45 deletions(-)
>>
>> diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
>> index 711dd83..f983262 100644
>> --- a/drivers/cpuidle/cpuidle.c
>> +++ b/drivers/cpuidle/cpuidle.c
>> @@ -69,24 +69,15 @@ int cpuidle_play_dead(void)
>>  {
>>  	struct cpuidle_device *dev =3D __this_cpu_read(cpuidle_devices);
>>  	struct cpuidle_driver *drv =3D cpuidle_get_cpu_driver(dev);
>> -	int i, dead_state =3D -1;
>> -	int power_usage =3D -1;
>> +	int i;
>> =20
>>  	if (!drv)
>>  		return -ENODEV;
>> =20
>>  	/* Find lowest-power state that supports long-term idle */
>> -	for (i =3D CPUIDLE_DRIVER_STATE_START; i < drv->state_count; i++) =
{
>> -		struct cpuidle_state *s =3D &drv->states[i];
>> -
>> -		if (s->power_usage < power_usage && s->enter_dead) {
>> -			power_usage =3D s->power_usage;
>> -			dead_state =3D i;
>> -		}
>> -	}
>> -
>> -	if (dead_state !=3D -1)
>> -		return drv->states[dead_state].enter_dead(dev, dead_state);
>> +	for (i =3D drv->state_count; i >=3D CPUIDLE_DRIVER_STATE_START; i-=
-)
>> +		if (drv->states[i].play_dead)
>=20
> I guess you meant drv->states[i].enter_dead

Yep :)



--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for=
 ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
