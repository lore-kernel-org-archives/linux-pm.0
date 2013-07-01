From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [Query]: CPUFREQ: Affected and related cpus in cpufreq
Date: Mon, 1 Jul 2013 11:50:10 +0530
Message-ID: <CAKohpon=ATUP5jN9cAmGsuTQGBFm9mDSK1qLV2qewtUopxKQ8A@mail.gmail.com>
References: <CAOh2x=mJUkRxwwTRh89-Xpm1WwB9ciDOXVohqoTu6B5k6meHdw@mail.gmail.com>
	<50756396.9040705@arm.com>
	<CAKohponw2kGOewdnyicPiup5pa1bqdSo2mWicHiuLM0F0_OREg@mail.gmail.com>
	<50757BC1.3050401@arm.com>
	<CAKohpono18oYGDJg7h0EZ6E6Uqo_v40ofRNQOG5VLwwGMO8pTw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <CAKohpono18oYGDJg7h0EZ6E6Uqo_v40ofRNQOG5VLwwGMO8pTw@mail.gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Cc: "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>
List-Id: linux-pm@vger.kernel.org

On 10 October 2012 19:37, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 10 October 2012 19:14, Sudeep KarkadaNagesha
> <Sudeep.KarkadaNagesha@arm.com> wrote:
>> Here is my understanding on this patch. This change is closely related
>> to ACPI cpufreq driver(used mostly on Intel cores). This change was
>> introduced to keep track of the related cpus as returned by ACPI
>> firmware along with affected cpus as imposed by SW. I don't understand
>> the exact difference in Intel cores.
>> I believe it's just for tracking and not used much in the driver.
>
> Then i believe we shouldn't fill the related_cpus field for ARM cores. As anyway
> the show_related_cpus will pick affected cpus in that case.

Ahh, I was searching for something in my Archives and found this old
unanswered mail. As I have understood the difference between between
these two variables (affected and related cpus) now until this happened:
951fc5f4 (in v3.9). I thought it would be good to bury the actual answers
somewhere in Archives so that somebody looking for the answer can find
it easily.


What it was:

Affected CPUs: List of CPUs which share clock domain and s/w was responsible
to managing these.

Related CPUs: List of CPUs which share clock domain and only h/w was
responsible for managing these.

What do we mean by software and hardware managed stuff?

It was specific for acpi-cpufreq driver and nobody else :)

The firmware below kernel layer for hardware using this driver wanted to
manage cpus (sharing clock domain) by itself. i.e. It wanted the actual freq
request to go to it, it will then pick the highest freq requested for a clock
domain and set it for all cpus under policy->cpus. But kernel wouldn't know
these details at all. CPUFreq core would think that these cores don't
actually share clock line and so are independent.

Then there were some user space applications (like DVFS controllers),
which wanted to know the exact hardware coordination details rather than
what is present with cpufreq core. And so related_cpus was created for
them with this commit: e8628dd06d66f2e3965ec9742029b401d63434f1

related_cpus wasn't used in making kernel decisions at all and was only
for the applications who want to know exact hardware details.

As it didn't make sense to keep acpi-cpufreq specific stuff in CPUFreq core,
it was eventually moved into acpi-cpufreq driver with the name:
freqdomain_cpus in 3.11. related_cpus was kept in kernel but its meaning
is now changed.

affected_cpus: List of Online CPUs that require software coordination
of frequency.

related_cpus: List of Online + Offline CPUs that need software
coordination of frequency.

--
viresh
