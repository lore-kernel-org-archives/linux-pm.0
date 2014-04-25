From: Stratos Karafotis <stratosk@semaphore.gr>
Subject: Re: [PATCH v4 2/8] cpufreq: Use cpufreq_for_each_* macros for frequency
 table iteration
Date: Fri, 25 Apr 2014 18:11:20 +0300
Message-ID: <535A7B18.9070505@semaphore.gr>
References: <534DB1EB.1080401@semaphore.gr> <5355A327.3020308@semaphore.gr> <CA+V-a8swMCPkf=rwbLOjiqAgpaQ7TZPutTQTh_sSFmbJvHz-1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CA+V-a8swMCPkf=rwbLOjiqAgpaQ7TZPutTQTh_sSFmbJvHz-1Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Prabhakar Lad <prabhakar.csengg@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Kukjin Kim <kgene.kim@samsung.com>, linux-pm@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, Sudeep Holla <sudeep.holla@arm.com>, Olof Johansson <olof@lixom.net>, linuxppc-dev@lists.ozlabs.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

Hi Prabhakar,

On 25/04/2014 03:31 =CE=BC=CE=BC, Prabhakar Lad wrote:
> Hi Stratos,
>=20
> Thanks for the patch.
>=20
> On Tue, Apr 22, 2014 at 4:30 AM, Stratos Karafotis
> <stratosk@semaphore.gr> wrote:
>> The cpufreq core now supports the cpufreq_for_each_entry and
>> cpufreq_for_each_valid_entry macros helpers for iteration over the
>> cpufreq_frequency_table, so use them.
>>
>> It should have no functional changes.
>>
> This patch produces following build warning,
>=20
> drivers/cpufreq/freq_table.c: In function 'cpufreq_frequency_table_cp=
uinfo':
> drivers/cpufreq/freq_table.c:36:3: warning: format '%lu' expects
> argument of type 'long unsigned int', but argument 2 has type 'int'
> [-Wformat=3D]
>    pr_debug("table entry %lu: %u kHz\n", pos - table, freq);

Thanks for this finding.
I will fix it and resend the patch.


Stratos Karafotis
