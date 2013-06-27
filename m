From: Lan Tianyu <tianyu.lan@intel.com>
Subject: Re: [PATCH 2/2 V2] CPUFreq: Add new sysfs attribute freqdomain_cpus
 for acpi-freq driver
Date: Thu, 27 Jun 2013 13:34:05 +0800
Message-ID: <51CBCECD.6030106@intel.com>
References: <1372250304-20975-1-git-send-email-tianyu.lan@intel.com> <CAKohpokrU4LYGeL_oai+F1irHgk4y+KmO+71_MGVNOhEG6_QDw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <CAKohpokrU4LYGeL_oai+F1irHgk4y+KmO+71_MGVNOhEG6_QDw@mail.gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: rjw@sisk.pl, lenb@kernel.org, jean-philippe.halimi@exascale-computing.eu, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, cpufreq@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 2013=E5=B9=B406=E6=9C=8827=E6=97=A5 13:24, Viresh Kumar wrote:
> On 26 June 2013 18:08, Lan Tianyu <tianyu.lan@intel.com> wrote:
>> diff --git a/Documentation/cpu-freq/acpi-cpufreq.txt b/Documentation=
/cpu-freq/acpi-cpufreq.txt
>> new file mode 100644
>> index 0000000..9c59d09
>> --- /dev/null
>> +++ b/Documentation/cpu-freq/acpi-cpufreq.txt
>> @@ -0,0 +1,7 @@
>> +Sysfs interface
>> +---------------------------
>> +(Interface locates in the directory /sys/devices/system/cpu/cpuN/cp=
ufreq)
>> +
>> +freqdomain_cpus :               List of Online + Offline CPUs in sa=
me CPU dependency
>> +                                domain.
>> +
>=20
> Apart from the comments from Rafael, this must be described a bit
> more. We must write here how is it different than related_cpus.
>=20
> Write: freqdomain_cpus are the list of cpus (online+offline) that sha=
re
> same clock/freq domain at hardware level. This information might
> be hidden from cpufreq core and so related_cpus can have different
> value compared to this. This is not used by kernel but userspace
> DVFS controllers to get better power/performance values for platforms
> using acpi-cpufreq.c driver.
>=20
Thanks for your comments. I will add this in my patch.


--=20
Best regards
Tianyu Lan
