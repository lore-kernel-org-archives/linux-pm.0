From: Stratos Karafotis <stratosk@semaphore.gr>
Subject: Re: [PATCH 02/20] cpufreq: acpi-cpufreq: Use cpufreq_for_each_entry
 macro for iteration
Date: Tue, 15 Apr 2014 14:00:08 +0300
Message-ID: <534D1138.90409@semaphore.gr>
References: <534C4E36.9060208@semaphore.gr> <CAKohpok5+Eai=OOs9J+uYp4NaYmovXqkkg_Bvx0025_XyS4xTQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAKohpok5+Eai=OOs9J+uYp4NaYmovXqkkg_Bvx0025_XyS4xTQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 15/04/2014 08:32 =CF=80=CE=BC, Viresh Kumar wrote:
> On 15 April 2014 02:38, Stratos Karafotis <stratosk@semaphore.gr> wro=
te:
>> The cpufreq core supports the cpufreq_for_each_entry macro helper
>> for iteration over the cpufreq_frequency_table, so use it.
>>
>> It should have no functional changes.
>>
>> Signed-off-by: Stratos Karafotis <stratosk@semaphore.gr>
>> ---
>>  drivers/cpufreq/acpi-cpufreq.c | 10 +++++-----
>>  1 file changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-c=
pufreq.c
>> index 000e4e0..12a5750 100644
>> --- a/drivers/cpufreq/acpi-cpufreq.c
>> +++ b/drivers/cpufreq/acpi-cpufreq.c
>> @@ -213,7 +213,7 @@ static unsigned extract_io(u32 value, struct acp=
i_cpufreq_data *data)
>>
>>  static unsigned extract_msr(u32 msr, struct acpi_cpufreq_data *data=
)
>>  {
>> -       int i;
>> +       struct cpufreq_frequency_table *pos;
>>         struct acpi_processor_performance *perf;
>>
>>         if (boot_cpu_data.x86_vendor =3D=3D X86_VENDOR_AMD)
>> @@ -223,11 +223,11 @@ static unsigned extract_msr(u32 msr, struct ac=
pi_cpufreq_data *data)
>>
>>         perf =3D data->acpi_data;
>>
>> -       for (i =3D 0; data->freq_table[i].frequency !=3D CPUFREQ_TAB=
LE_END; i++) {
>> -               if (msr =3D=3D perf->states[data->freq_table[i].driv=
er_data].status)
>> -                       return data->freq_table[i].frequency;
>> +       cpufreq_for_each_entry(pos, data->freq_table) {
>> +               if (msr =3D=3D perf->states[pos->driver_data].status=
)
>> +                       return pos->frequency;
>>         }
>> -       return data->freq_table[0].frequency;
>> +       return data->freq_table->frequency;
>=20
> This isn't a related change, isn't it? Also it make it less readable.
> So probably
> just leave it as is.
>=20

I thought that since we use pointer notation it would be more clear.
But, I will change it according to your suggestion.


Stratos
