From: Ilia Lin <ilialin@codeaurora.org>
Subject: Re: [PATCH] cpufreq: kryo: allow building as a loadable module
Date: Wed, 06 Jun 2018 07:44:39 +0300
Message-ID: <85F1CCF0-F937-4EAA-9628-D8AA6C4EDE0E@codeaurora.org>
References: <20180605114453.1381941-1-arnd@arndb.de> <20180606040929.tksvznlmb3ogtgur@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180606040929.tksvznlmb3ogtgur@vireshk-i7>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Arnd Bergmann <arnd@arndb.de>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Viresh got ahead of my answer a bit=2E :)
Sure I'll post the module exit later=2E

On June 6, 2018 7:09:29 AM GMT+03:00, Viresh Kumar <viresh=2Ekumar@linaro=
=2Eorg> wrote:
>On 05-06-18, 13:44, Arnd Bergmann wrote:
>> Building the kryo cpufreq driver while QCOM_SMEM is a loadable module
>> results in a link error:
>>=20
>> drivers/cpufreq/qcom-cpufreq-kryo=2Eo: In function
>`qcom_cpufreq_kryo_probe':
>> qcom-cpufreq-kryo=2Ec:(=2Etext+0xbc): undefined reference to
>`qcom_smem_get'
>>=20
>> The problem is that Kconfig ignores interprets the dependency as met
>> when the dependent symbol is a 'bool' one=2E By making it 'tristate',
>> it will be forced to be a module here, which builds successfully=2E
>>=20
>> Fixes: 46e2856b8e18 ("cpufreq: Add Kryo CPU scaling driver")
>> Signed-off-by: Arnd Bergmann <arnd@arndb=2Ede>
>> ---
>>  drivers/cpufreq/Kconfig=2Earm | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>=20
>> diff --git a/drivers/cpufreq/Kconfig=2Earm
>b/drivers/cpufreq/Kconfig=2Earm
>> index c7ce928fbf1f=2E=2E52f5f1a2040c 100644
>> --- a/drivers/cpufreq/Kconfig=2Earm
>> +++ b/drivers/cpufreq/Kconfig=2Earm
>> @@ -125,7 +125,7 @@ config ARM_OMAP2PLUS_CPUFREQ
>>  	default ARCH_OMAP2PLUS
>> =20
>>  config ARM_QCOM_CPUFREQ_KRYO
>> -	bool "Qualcomm Kryo based CPUFreq"
>> +	tristate "Qualcomm Kryo based CPUFreq"
>>  	depends on ARM64
>>  	depends on QCOM_QFPROM
>>  	depends on QCOM_SMEM
>
>Okay, so we really need this to be a module=2E But the driver can't
>really work as
>a module right now if we do this: insmod, rmmod, insmod=2E Because it
>doesn't free
>resources at rmmmod and will fail on second insmod=2E
>
>Because what you are fixing is a critical build error, we better get it
>merged
>right now=2E
>
>Acked-by: Viresh Kumar <viresh=2Ekumar@linaro=2Eorg>
>
>But Ilia needs to cook another patch to add the module removal code for
>the
>driver and mark your patch's commit id in the fixes tag=2E

--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
