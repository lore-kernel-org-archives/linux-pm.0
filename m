From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: 3.10-rcX: cpu governor ondemand doesn't scale well after s2ram
Date: Fri, 5 Jul 2013 10:05:22 +0530
Message-ID: <CAKohponPboo5awGj5uowrdo=e168BaRtkwQ8qte-Gj8R2FUgZg@mail.gmail.com>
References: <51C08370.4050906@gmx.de>
	<CAKohpok1gThXL925Yz5UgC54vTVQgymBA1cLGER_g-dgZu0JLA@mail.gmail.com>
	<51CF1E53.6060902@gmx.de>
	<8029836.CFiJCXmRQ0@vostro.rjw.lan>
	<51D05DF4.50704@linux.vnet.ibm.com>
	<51D06556.7080204@gmx.de>
	<51D47FB0.5090604@gmx.de>
	<51D51C63.2080702@linux.vnet.ibm.com>
	<CAKohpomfM55cRfLOohpv4nhLBcwVcD-y3-WcYOaznVhA6H2TAw@mail.gmail.com>
	<51D51F63.8080905@linux.vnet.ibm.com>
	<CAKohpom1KE=yxTi1HNoSn4cJ1mNpvZTeeVwK3A=4qSZ6Ut98gA@mail.gmail.com>
	<CAKohpok=iLyiiV5F4Q8ZK_-7ZzZqiGchHkmVWEvCRsV55z7gzA@mail.gmail.com>
	<51D5A5E5.9060302@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <51D5A5E5.9060302@gmx.de>
Sender: cpufreq-owner@vger.kernel.org
To: =?ISO-8859-1?Q?Toralf_F=F6rster?= <toralf.foerster@gmx.de>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, cpufreq@vger.kernel.org, Linux PM list <linux-pm@vger.kernel.org>, "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
List-Id: linux-pm@vger.kernel.org

On 4 July 2013 22:12, Toralf F=F6rster <toralf.foerster@gmx.de> wrote:
> On 07/04/2013 10:23 AM, Viresh Kumar wrote:
>> Ok, I did a mistake here (Thanks Srivatsa for telling me), this wasn=
't
>> there in 3.10 but 3.11-rc1
>>
>>> > c28375583b6471c1cb833a628ab6afb5b69079d0
>>> >
>>> > They are touching ondemand governor and this may be creating some
>>> > problems. But I am not sure about it, I must admit.
>> So just try reverting about commit.
>>
>> In case you are using acpi-cpufreq driver, please try reverting this=
 before
>> above one:
>>
>> 8673b83bf2f013379453b4779047bf3c6ae387e4
> I reverted  8673b83b on top of 3.10.0  - no success, then I reverted
> c2837558 too - no success.

I assume that you have applied the patch given by Srivatsa earlier over
these reverts?

In that case you can go for a revert I believe. There aren't many cpufr=
eq
patches between 3.10 and the commit where you tested successfully
earlier.

But I now also suspect that this might have been caused by something
outside cpufreq.
