From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v4 2/7] cpufreq: Add boost frequency support in core
Date: Wed, 17 Jul 2013 13:28:29 +0530
Message-ID: <CAKohpokw-bSWEgKvx0jd2QZ0RCz5dORHM9z+VYbTdKoCmKFvsg@mail.gmail.com>
References: <1370502472-7249-1-git-send-email-l.majewski@samsung.com>
	<51C1EF05.90402@gmail.com>
	<20130619223102.70c2e359@jawa>
	<6633375.dICiDrHJgK@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <6633375.dICiDrHJgK@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Lukasz Majewski <l.majewski@majess.pl>, Dirk Brandewie <dirk.brandewie@gmail.com>, "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Lukasz Majewski <l.majewski@samsung.com>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Jonghwa Lee <jonghwa3.lee@samsung.com>, Myungjoo Ham <myungjoo.ham@samsung.com>, linux-kernel <linux-kernel@vger.kernel.org>, Andre Przywara <andre.przywara@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Kukjin Kim <kgene.kim@samsung.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <eduardo.valentin@ti.com>
List-Id: linux-pm@vger.kernel.org

On 20 June 2013 03:55, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Wednesday, June 19, 2013 10:31:02 PM Lukasz Majewski wrote:
>> On Wed, 19 Jun 2013 10:48:53 -0700
>> Dirk Brandewie <dirk.brandewie@gmail.com> wrote:
>>
>> > On 06/19/2013 10:12 AM, Lukasz Majewski wrote:

>> > > @@ -1936,6 +2019,16 @@ int cpufreq_register_driver(struct
>> > > + if (!cpufreq_driver->boost_supported)
>> > > +         boost.attr.mode = 0444;
>> > > +
>> > > + ret = cpufreq_sysfs_create_file(&(boost.attr));
>> > > + if (ret) {
>> > > +         pr_err("%s: cannot register global boost sysfs
>> > > file\n",
>> > > +                __func__);
>> > > +         goto err_null_driver;
>> > > + }
>> > > +
>> >
>> > I do not think the boost sysfs should be created at all if boost is
>> > not supported.
>>
>> This was my first thought. But unfortunately this "boost" attribute is
>> always exported at acpi-cpufreq.c and in my opinion is part of a
>> legacy API.
>>
>> I totally agree with the idea of exporting boost only when supported,
>> but I would like to know the community opinion about this (especially
>> Viresh and Rafael shall speak up).
>
> Simple: Export it only when supported.

Guys,

I got confused here. We originally decided to keep this feature as is
for acpi-cpufreq.

So, For acpi-cpufreq:
- when boost isn't supported: create sysfs boost with ro permissions
- when boost is supported: create sysfs boost with rw permissions

So, For others:
- create sysfs boost with rw permissions only when boost is supported

.

Do you want something else? or do you want to change behavior of
acpi-cpufreq driver? I don't why it was designed this way and what
applications use it.
