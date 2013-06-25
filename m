From: Lan Tianyu <tianyu.lan@intel.com>
Subject: Re: [PATCH 1/2] ACPI/Processor: Clear unuseful variable count in
 the acpi_processor_preregister_performance()
Date: Tue, 25 Jun 2013 16:42:09 +0800
Message-ID: <51C957E1.7080808@intel.com>
References: <1372126006-4950-1-git-send-email-tianyu.lan@intel.com> <CAKohpo=jdP-WF4D+XO=Z9cYVvJpbM9EG6hKSCgURNMVBTGut5g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <CAKohpo=jdP-WF4D+XO=Z9cYVvJpbM9EG6hKSCgURNMVBTGut5g@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: rjw@sisk.pl, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, cpufreq@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 2013=E5=B9=B406=E6=9C=8825=E6=97=A5 15:45, Viresh Kumar wrote:
> On 25 June 2013 07:36, Lan Tianyu <tianyu.lan@intel.com> wrote:
>> The variable count in the acpi_processor_preregister_performance() i=
s only initalized
>> as one for one cpu and increased by one when find another cpu that s=
hare same dependency
>> domain. Otherwise, it isn't referenced somewhere else.
>>
>> Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
>> ---
>>  drivers/acpi/processor_perflib.c |    4 +---
>>  1 file changed, 1 insertion(+), 3 deletions(-)
>=20
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
>=20
Thanks.


--=20
Best regards
Tianyu Lan
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
