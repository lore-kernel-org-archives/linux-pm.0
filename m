From: Dmitry Osipenko <digetx@gmail.com>
Subject: Re: [RFC PATCH v2 01/17] OPP: Allow to request stub voltage
 regulators
Date: Mon, 22 Oct 2018 14:29:16 +0300
Message-ID: <e4027793-9436-413d-2a7b-34cf519218c3@gmail.com>
References: <20181021205501.23943-1-digetx@gmail.com>
 <20181021205501.23943-2-digetx@gmail.com>
 <20181022053636.ag62j3rj3vovbz53@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181022053636.ag62j3rj3vovbz53@vireshk-i7>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Rob Herring <robh+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, Marcel Ziswiler <marcel.ziswiler@toradex.com>, linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 10/22/18 8:36 AM, Viresh Kumar wrote:
> On 21-10-18, 23:54, Dmitry Osipenko wrote:
>> Voltage regulators may be not available on some variations of HW, allow to
>> request stub voltage regulators by OPP core in a such case to reduce code
>> churning within drivers.
>>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  drivers/cpufreq/cpufreq-dt.c | 2 +-
>>  drivers/cpufreq/ti-cpufreq.c | 3 ++-
>>  drivers/opp/core.c           | 9 +++++++--
>>  include/linux/pm_opp.h       | 4 ++--
>>  4 files changed, 12 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
>> index e58bfcb1169e..6ebca472ec76 100644
>> --- a/drivers/cpufreq/cpufreq-dt.c
>> +++ b/drivers/cpufreq/cpufreq-dt.c
>> @@ -196,7 +196,7 @@ static int cpufreq_init(struct cpufreq_policy *policy)
>>  	 */
>>  	name = find_supply_name(cpu_dev);
>>  	if (name) {
>> -		opp_table = dev_pm_opp_set_regulators(cpu_dev, &name, 1);
>> +		opp_table = dev_pm_opp_set_regulators(cpu_dev, &name, 1, false);
>>  		if (IS_ERR(opp_table)) {
>>  			ret = PTR_ERR(opp_table);
>>  			dev_err(cpu_dev, "Failed to set regulator for cpu%d: %d\n",
> 
> Have you actually tested this stuff ? The cpufreq-dt driver will
> probably fail to probe if the CPU node has a "-supply" property, but
> no regulator matching that.
> 

Please notice that this patch doesn't change the original behaviour and I suppose that failing in a case of missing regulator is the expected behaviour for cpufreq-dt. Hence can't see any problem here.
