From: Stratos Karafotis <stratosk@semaphore.gr>
Subject: Re: [PATCH v2 0/8] Introduce new cpufreq helper macros
Date: Wed, 16 Apr 2014 10:04:13 +0300
Message-ID: <534E2B6D.1000902@semaphore.gr>
References: <534DB1CC.60407@semaphore.gr> <CAKohpomvmpiYkQAP7Yb=TNxNsXMVh1_MLuK7KQrdEkf15MyvMg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAKohpomvmpiYkQAP7Yb=TNxNsXMVh1_MLuK7KQrdEkf15MyvMg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Jesper Nilsson <jesper.nilsson@axis.com>, Hans-Christian Egtvedt <egtvedt@samfundet.no>, Dirk Brandewie <dirk.j.brandewie@intel.com>, linux-doc@vger.kernel.org, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Randy Dunlap <rdunlap@infradead.org>, "David S. Miller" <davem@davemloft.net>
List-Id: linux-pm@vger.kernel.org

On 16/04/2014 07:01 =CF=80=CE=BC, Viresh Kumar wrote:
> On 16 April 2014 03:55, Stratos Karafotis <stratosk@semaphore.gr> wro=
te:
>> Hi all,
>>
>> This patch set introduces two freq_table helper macros which
>> can be used for iteration over cpufreq_frequency_table and
>> makes the necessary changes to cpufreq core and drivers that
>> use such an iteration procedure.
>>
>> The motivation was a usage of common procedure to iterate over
>> cpufreq_frequency_table across all drivers and cpufreq core.
>>
>> This was tested on a x86_64 platform.
>> Most files compiled successfully but unfortunately I was not
>> able to compile sh_sir.c pasemi_cpufreq.c and ppc_cbe_cpufreq.c
>> due to lack of cross compiler.
>>
>> Changes v1 -> v2
>>         - Rearrange patches
>>         - Remove redundant braces
>>         - Fix a newly introduced bug in exynos5440
>>         - Use cpufreq_for_each_valid_entry instead of
>> cpufreq_for_each_entry in cpufreq_frequency_table_get_index()
>>         - Drop redundant double ! operator in longhaul and change
>=20
> You dropped this !! in thermal stuff and not longhaul :)
>=20
>> the pos loop cursor variable to freq_pos.
>>         - Declare pos variable on a separate line
>>
>> Stratos Karafotis (8):
>>   cpufreq: Introduce macros for cpufreq_frequency_table iteration
>>   cpufreq: Use cpufreq_for_each_* macros for frequency table iterati=
on
>>   davinci: da850: Use cpufreq_for_each_entry macro for iteration
>>   mips: lemote 2f: se cpufreq_for_each_entry macro for iteration
>>   mfd: db8500-prcmu: Use cpufreq_for_each_entry macro for iteration
>>   thermal: cpu_cooling: Use cpufreq_for_each_valid_entry macro for
>>     iteration
>>   irda: sh_sir: Use cpufreq_for_each_valid_entry macro for iteration
>>   sh: clk: Use cpufreq_for_each_valid_entry macro for iteration
>=20
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
>=20

Thanks!

Stratos
