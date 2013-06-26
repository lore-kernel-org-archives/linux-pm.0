From: Lan Tianyu <tianyu.lan@intel.com>
Subject: Re: [PATCH 2/2] CPUFreq: Add new sysfs attribute freqdomain_cpus
 for acpi-freq driver
Date: Wed, 26 Jun 2013 14:57:38 +0800
Message-ID: <51CA90E2.6080906@intel.com>
References: <1372126006-4950-1-git-send-email-tianyu.lan@intel.com> <51C95282.3040305@intel.com> <CAKohpokU8MEFk8RsAmdraeX-SJPTFYwjkVSFFMMSGbUNmOm=Vg@mail.gmail.com> <4163057.9R6dzfOLVQ@vostro.rjw.lan> <51CA54E8.6070805@intel.com> <CAKohponndCHUuZusx5VEStyQNpja9WR_Ok-H8YeAL-Cf1RLZgA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <CAKohponndCHUuZusx5VEStyQNpja9WR_Ok-H8YeAL-Cf1RLZgA@mail.gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, lenb@kernel.org, jean-philippe.halimi@exascale-computing.eu, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, cpufreq@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 2013=E5=B9=B406=E6=9C=8826=E6=97=A5 14:54, Viresh Kumar wrote:
> On 26 June 2013 08:11, Lan Tianyu <tianyu.lan@intel.com> wrote:
>> On 2013=E5=B9=B406=E6=9C=8826=E6=97=A5 07:03, Rafael J. Wysocki wrot=
e:
>>> On Tuesday, June 25, 2013 09:01:03 PM Viresh Kumar wrote:
>>>> On 25 June 2013 13:49, Lan Tianyu <tianyu.lan@intel.com> wrote:
>>>>> Ok. From my opinion, the new attribute is an ABI and it's better =
to add
>>>>> descriptor under Document directory. The user can be easy to find=
 how to
>>>>> use it.
>>>>
>>>> Hmm.. So maybe acpi-cpufreq file would be a good starting point. T=
hen
>>>> it can have more details about the driver in future.
>>>>
>>>>> Please see the commit which add the code. Maybe, we should overwr=
ite
>>>>> shared_cpu_map by sibling_cpus for this case?
>>>>
>>>> Not sure if changing shared_cpu_map has any other implications or =
not.
>>>
>>> Well, I wouldn't change it, then.
>=20
> Please add a blank line before and after your reply. It makes it more
> readable.

Thanks for reminder. I will notice this.

>=20
>> Ok. How about add new field "cpufreqdomain_cpus" in the  struct
>> acpi_cpufreq_data and expose its value for new attribute. For normal
>> case, copy the shared_cpu_map to it for normal case. For AMD case, c=
opy
>> sibling_cpus to it.
>=20
> This should work I guess.

Ok. I will follow this one.

>=20
>>    Another choice, just keeping what my patch has done. Wait for the=
 new
>> request since current patch can satisfy reporter and it's not clear
>> whether the patch is enough for AMD platform.(At last from my view).
>=20
> NAK. We must keep it as it was before my patch.
>=20

OK. Please ignore this one.
--=20
Best regards
Tianyu Lan
