From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: =?UTF-8?B?562U5aSNOiBbUEFUQ0hdIGNwdWlkbGU6IHNpcmYgOiBBZGQgY3A=?=
 =?UTF-8?B?dWlkbGUgZm9yIFNpUkZwcmltYUlJIGFuZCBTaVJGYXRsYXNWSQ==?=
Date: Tue, 08 Oct 2013 12:23:56 +0200
Message-ID: <5253DD3C.90008@linaro.org>
References: <1381033577-19818-1-git-send-email-Baohua.Song@csr.com> <52526F8B.6030905@linaro.org> <86130EF012BDF348AA0D464A4F4494780129539EE4@SHAASIEXM01.ASIA.ROOT.PRI>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f51.google.com ([74.125.82.51]:62183 "EHLO
	mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756923Ab3JHKX7 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 8 Oct 2013 06:23:59 -0400
Received: by mail-wg0-f51.google.com with SMTP id c11so8455388wgh.6
        for <linux-pm@vger.kernel.org>; Tue, 08 Oct 2013 03:23:57 -0700 (PDT)
In-Reply-To: <86130EF012BDF348AA0D464A4F4494780129539EE4@SHAASIEXM01.ASIA.ROOT.PRI>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rongjun Ying <Rongjun.Ying@csr.com>, Barry Song <21cnbao@gmail.com>, "rjw@sisk.pl" <rjw@sisk.pl>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, DL-SHA-WorkGroupLinux <DL-SHA-WorkGroupLinux@internal.csr.com>, Barry Song <Barry.Song@csr.com>

On 10/08/2013 09:44 AM, Rongjun Ying wrote:
>
>
>> -----=E9=82=AE=E4=BB=B6=E5=8E=9F=E4=BB=B6-----
>> =E5=8F=91=E4=BB=B6=E4=BA=BA: Daniel Lezcano [mailto:daniel.lezcano@l=
inaro.org]
>> =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: Monday, October 07, 2013 4:24 =
PM
>> =E6=94=B6=E4=BB=B6=E4=BA=BA: Barry Song; rjw@sisk.pl
>> =E6=8A=84=E9=80=81: linux-pm@vger.kernel.org; DL-SHA-WorkGroupLinux;=
 Rongjun Ying; Barry
>> Song
>> =E4=B8=BB=E9=A2=98: Re: [PATCH] cpuidle: sirf : Add cpuidle for SiRF=
primaII and SiRFatlasVI
>>
>>
>> Hi Barry,
>>
>> On 10/06/2013 06:26 AM, Barry Song wrote:
>>> From: Rongjun Ying <Rongjun.Ying@csr.com>
>>>
>>> This patch adds support cpuidle for CSR SiRFprimaII and SiRFatlasVI
>>> unicore ARM Cortex-A9 SoCs.
>>
>> A new driver deserves a better description.
>>
>>> Signed-off-by: Rongjun Ying <Rongjun.Ying@csr.com>
>>> Signed-off-by: Barry Song <Baohua.Song@csr.com>
>>> ---
>>
>> Is there a technical reference manual accessible somewhere ?
>
> No, I have not.

You haven't one ? How can you write a cpuidle driver without it ?

You didn't answer my question:

Is there a technical reference manual accessible somewhere ?

> If system need enter idle mode, Not need operate any SoC register. Si=
RF SoC enter cpuidle mode is very simple,
> Which only set the parent clock to OSC(26MHz)  and adjust voltage to =
min.

This is up to cpufreq.

[ ... ]

>>> +static int sirf_enter_idle(struct cpuidle_device *dev,
>>> +				struct cpuidle_driver *drv,
>>> +				int index)
>>> +{
>>> +	struct clk *parent_clk;
>>> +	unsigned long volt_old =3D 0, volt_new, freq;
>>> +	struct opp *opp;
>>> +
>>> +	local_irq_disable();
>>
>> Don't use local_irq_disable in the driver it is done by the caller.
>
> Yes, I will remove it.
>
>>
>>> +	parent_clk =3D clk_get_parent(sirf_cpuidle.cpu_clk);
>>> +	clk_set_parent(sirf_cpuidle.cpu_clk, sirf_cpuidle.osc_clk);
>>> +
>>> +	if (sirf_cpuidle.vcore_regulator) {
>>> +		volt_old =3D regulator_get_voltage(sirf_cpuidle.vcore_regulator)=
;
>>> +
>>> +		freq =3D clk_get_rate(sirf_cpuidle.osc_clk);
>>> +		rcu_read_lock();
>>
>> Using rcu in the idle path is not allowed.
>
> Yes, I will remove it.
>
>>
>>> +		opp =3D opp_find_freq_ceil(sirf_cpuidle.cpu_dev, &freq);
>>> +		if (IS_ERR(opp)) {
>>> +			rcu_read_unlock();
>>> +			return -EINVAL;
>>> +		}
>>> +
>>> +		volt_new =3D opp_get_voltage(opp);
>>> +		rcu_read_unlock();
>>> +
>>> +		regulator_set_voltage(sirf_cpuidle.vcore_regulator, volt_new,
>>> +				SIRFSOC_MAX_VOLTAGE);
>>> +	}
>>> +	/* Wait for interrupt state */
>>> +	cpu_do_idle();
>>> +
>>> +	if (sirf_cpuidle.vcore_regulator)
>>> +		regulator_set_voltage(sirf_cpuidle.vcore_regulator, volt_old,
>>> +				SIRFSOC_MAX_VOLTAGE);
>>> +
>>> +	clk_set_parent(sirf_cpuidle.cpu_clk, parent_clk);
>>> +	/* Todo: other C states */
>>
>> It sounds very weird you have this freq/volt/opp code here.
>>
>> If you hit idle, the cpufreq driver didn't put the cpu in the state =
you are trying to
>> bring here ?
>>
>> There isn't a power management unit on this board ?
>>
>
> By SiRF SoC, when enter idle mode, I set the freq to 26MHz and min vo=
ltage.
> That's will save the power consume and reduce leakage current.

Really ? :)

You didn't answer the questions.

1. this code shouldn't be here but in cpufreq which is already the case=
=20
with the other patch you sent with this one. So I am convinced if you=20
remove the OPP here and let cpufreq to handle that, and keep the=20
cpu_do_idle, you won't see any difference with the current code.

2. Moreover, removing the OPP, there is only the WFI state which is the=
=20
default idle function. Hence the cpuidle driver itself has no interest=20
and you can simply remove it, except if you bring another idle state=20
with the driver.

3. More idle states are often handled through a PMU (Power Management=20
Unit) giving cpu power off, retention, cluster power down, etc ... Is=20
there one on this board ?

The TRM can help to answer these questions.

>>> +	local_irq_enable();
>>
>> Done by the caller.
>>
>
> Yes. I will remove it.
>
>>> +	return index;
>>> +}
>>> +
>>> +static struct cpuidle_driver sirf_cpuidle_driver =3D {
>>> +	.name =3D "sirf_cpuidle",
>>> +	.states =3D {
>>> +		ARM_CPUIDLE_WFI_STATE,
>>> +		{
>>> +			.name =3D "WFI-LP",
>>> +			.desc =3D "WFI low power",
>>> +			.flags =3D CPUIDLE_FLAG_TIME_VALID,
>>> +			.exit_latency =3D 10,
>>> +			.target_residency =3D 10000,

By the way, why 10000 ? Is it measured ?

>>> +			.enter =3D sirf_enter_idle,
>>> +		},
>>> +	},
>>> +	.state_count =3D 2,

[ cut ]

>>> +
>>> +	ret =3D cpuidle_register(&sirf_cpuidle_driver, NULL);
>>> +	if (!ret)
>>> +		return ret;
>>> +
>>> +out_put_clk:
>>> +	clk_put(sirf_cpuidle.cpu_clk);
>>> +out_put_osc_clk:
>>> +	clk_put(sirf_cpuidle.osc_clk);
>>> +	return ret;
>>> +}
>>> +late_initcall(sirfsoc_init_cpuidle);
>>
>> Please convert it to platform_driver as the other drivers are moving=
 to (cf.
>> cpuidle-kirkwood, cpuidle-ux500).
>>
>
> I think cpuidle is not actual device which can't be added to device t=
ree system.
> So where register this device?

I gave you a couple of examples above, you can rely on it to implement=20
something similar.

Thanks
   -- Daniel

--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

