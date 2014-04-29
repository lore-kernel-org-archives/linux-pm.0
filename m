From: Mascha Kurpicz <mascha.kurpicz@unine.ch>
Subject: Re: time_in_state on Ubuntu 13.10
Date: Tue, 29 Apr 2014 09:17:11 +0200
Message-ID: <535F51F7.5090804@unine.ch>
References: <535E6906.2090201@unine.ch> <CAOh2x==Q_oDn9v4S5ggh_e-3_=vSU_5Ko_89LfWM9ARBS9i=Rg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <CAOh2x==Q_oDn9v4S5ggh_e-3_=vSU_5Ko_89LfWM9ARBS9i=Rg@mail.gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Linux PM list <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, Maxime Colmant <maxime.colmant@inria.fr>
List-Id: linux-pm@vger.kernel.org

Hi,

Sorry for the imprecision.

Works correctly with
Ubuntu 12.04.3 LTS - kernel 3.2.0-29-generic
Ubuntu 12.04.3 LTS -  kernel 3.8.0-29
Ubuntu 13.10 - kernel 3.8.0-29-generic

0 or very small (e.g. 6) values with
Ubuntu 13.10 - kernel 3.11.0-20-generic

Thanks,
Mascha


On 04/29/2014 06:28 AM, Viresh Kumar wrote:
> On Mon, Apr 28, 2014 at 8:13 PM, Mascha Kurpicz <mascha.kurpicz@unine.ch> wrote:
>> First of all I would like to thank for the cpufreq utility that I use
>> regularly.
>>
>> Unfortunately, when upgrading our systems from Ubuntu 12.04 to 13.10, we
>> are encountering some issues with the data in
>> /sys/devices/system/cpu/cpu*/cpufreq/stats/time_in_state.
>>
>> On some of the machines, the values are all set to 0 [1], whereas on
>> other machines, values are 0 or very small [2]. In both cases, the
>> output of cpufreq-info for the cpufreq stats is not correct. When
>> running Ubuntu 12.04, we get reasonable values.
>>
>> We noticed this behavior on Intel i3 machines, and on Intel Xeon. Kernel
>> version in all cases is 3.11.0-20-generic.
> Do you mean that kernel version is same for 12.04 and 13.10? We need
> kernel versions for these two bases.

