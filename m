From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2 Resend 37/92] cpufreq: acpi: don't initialize part of
 policy that is set by core too
Date: Fri, 11 Oct 2013 20:07:37 +0530
Message-ID: <CAKohpokjEZKhkFAWo7NPEaz-cK_zC3VCzdv8HT3Yk5kUWxa=Lg@mail.gmail.com>
References: <cover.1380783079.git.viresh.kumar@linaro.org>
	<8fa3d4a49724fc9a298c0b2f0b266b37d4a13310.1380783079.git.viresh.kumar@linaro.org>
	<1531860.snE8AY6g9s@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <1531860.snE8AY6g9s@vostro.rjw.lan>
Sender: cpufreq-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 11/10/2013, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Thursday, October 03, 2013 08:28:31 PM Viresh Kumar wrote:
>> Many common initializations of struct policy are moved to core now and
>> hence
>> this driver doesn't need to do it. This patch removes such code.
>>
>> Most recent of those changes is to call ->get() in the core after calling
>> ->init().
>>
>> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
>> ---
>>  drivers/cpufreq/acpi-cpufreq.c | 1 -
>>  1 file changed, 1 deletion(-)
>>
>> diff --git a/drivers/cpufreq/acpi-cpufreq.c
>> b/drivers/cpufreq/acpi-cpufreq.c
>> index 94a5a1d..a8dac7b 100644
>> --- a/drivers/cpufreq/acpi-cpufreq.c
>> +++ b/drivers/cpufreq/acpi-cpufreq.c
>> @@ -842,7 +842,6 @@ static int acpi_cpufreq_cpu_init(struct cpufreq_policy
>> *policy)
>>  		break;
>>  	case ACPI_ADR_SPACE_FIXED_HARDWARE:
>>  		acpi_cpufreq_driver.get = get_cur_freq_on_cpu;
>> -		policy->cur = get_cur_freq_on_cpu(cpu);
>>  		break;
>>  	default:
>>  		break;
>
> I'm wondering what happens if space_id is ACPI_ADR_SPACE_SYSTEM_IO?  I
> suppose
> that the core will set policy->cur first and then it will be overwritten
> here?

No. First ->init() is called and then core sets policy->cur. And it sets
it only if there is a valid ->get() available.. Which wouldn't be available
in case of ACPI_ADR_SPACE_SYSTEM_IO..
