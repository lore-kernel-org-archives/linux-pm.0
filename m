From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [RFC 1/4] cpuidle: define the enter function in the
	driver structure
Date: Thu, 14 Jun 2012 10:16:19 +0200
Message-ID: <4FD99DD3.6060904@linaro.org>
References: <1339171365-4098-1-git-send-email-daniel.lezcano@linaro.org>
	<87r4ti49jt.fsf@sejong.aot.lge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <87r4ti49jt.fsf@sejong.aot.lge.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Namhyung Kim <namhyung@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, linaro-dev@lists.linaro.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 06/14/2012 09:49 AM, Namhyung Kim wrote:
> Hi,
>=20
> On Fri,  8 Jun 2012 18:02:42 +0200, Daniel Lezcano wrote:
>> We have the state index passed as parameter to the 'enter' function.
>> Most of the drivers assign their 'enter' functions several times in
>> the cpuidle_state structure, as we have the index, we can delegate
>> to the driver to handle their own callback array.
>>
>> That will have the benefit of removing multiple lines of code in the
>> different drivers.
>>
>> In order to smoothly modify the driver, the 'enter' function are in
>> the driver structure and in the cpuidle state structure. That will
>> let the time to modify the different drivers one by one.
>> So the 'cpuidle_enter' function checks if the 'enter' callback is
>> assigned in the driver structure and use it, otherwise it invokes
>> the 'enter' assigned to the cpuidle_state.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> ---
>>  drivers/cpuidle/cpuidle.c |    4 +++-
>>  include/linux/cpuidle.h   |    1 +
>>  2 files changed, 4 insertions(+), 1 deletions(-)
>>
>> diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
>> index d90519c..155dee7 100644
>> --- a/drivers/cpuidle/cpuidle.c
>> +++ b/drivers/cpuidle/cpuidle.c
>> @@ -46,7 +46,9 @@ static inline int cpuidle_enter(struct cpuidle_devic=
e *dev,
>>  				struct cpuidle_driver *drv, int index)
>>  {
>>  	struct cpuidle_state *target_state =3D &drv->states[index];
>> -	return target_state->enter(dev, drv, index);
>> +
>> +	return drv->enter(dev, drv, index) ? drv->enter(dev, drv, index) :
>=20
> Do you mean:
> 	       drv->enter ? drv->enter(dev, drv, index) :
> ?
>=20
> Thanks,
> Namhyung

Right :)

--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for A=
RM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
