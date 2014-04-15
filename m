From: Stratos Karafotis <stratosk@semaphore.gr>
Subject: Re: [PATCH 08/20] cpufreq: exynos5440: Use cpufreq_for_each_entry
 macro for iteration
Date: Tue, 15 Apr 2014 14:02:26 +0300
Message-ID: <534D11C2.3080206@semaphore.gr>
References: <534C4E7E.4090806@semaphore.gr> <CAKohpokfsR3soykZbtH4-L=4TC6Oab=jyzUr=W-EfkRFfefRDQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <CAKohpokfsR3soykZbtH4-L=4TC6Oab=jyzUr=W-EfkRFfefRDQ@mail.gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kukjin Kim <kgene.kim@samsung.com>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 15/04/2014 08:44 =CF=80=CE=BC, Viresh Kumar wrote:
> On 15 April 2014 02:39, Stratos Karafotis <stratosk@semaphore.gr> wro=
te:
>=20
>> diff --git a/drivers/cpufreq/exynos5440-cpufreq.c b/drivers/cpufreq/=
exynos5440-cpufreq.c
>=20
>>  static void exynos_enable_dvfs(unsigned int cur_frequency)
>>  {
>> -       unsigned int tmp, i, cpu;
>> +       unsigned int tmp, cpu;
>>         struct cpufreq_frequency_table *freq_table =3D dvfs_info->fr=
eq_table;
>> +       struct cpufreq_frequency_table *pos;
>=20
> Merge above two.
>=20

Then the line will be 82 characters long.
Do you mind to keep it as is?


Stratos
