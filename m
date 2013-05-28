From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [RFC v2 0/3][TESTS] LAB: Support for Legacy Application Booster
 governor - tests results
Date: Tue, 28 May 2013 15:14:26 +0530
Message-ID: <CAKohpo=6Tk3NmcJw_fqnePu_skHKNB0rFBOUzEsCDyeLqxg4xA@mail.gmail.com>
References: <1367590072-10496-1-git-send-email-jonghwa3.lee@samsung.com>
	<8856294.KaD55h4g0a@vostro.rjw.lan>
	<CAKohpom4sSwJG7r67+aNMjAdr7CToAqCbdcbd+vSCTEQkiTkcg@mail.gmail.com>
	<41528879.GuKxJgVhIe@vostro.rjw.lan>
	<20130528084035.13afa583@amdc308.digital.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oa0-f47.google.com ([209.85.219.47]:49623 "EHLO
	mail-oa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933768Ab3E1Jo0 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 28 May 2013 05:44:26 -0400
Received: by mail-oa0-f47.google.com with SMTP id m1so9550509oag.6
        for <linux-pm@vger.kernel.org>; Tue, 28 May 2013 02:44:26 -0700 (PDT)
In-Reply-To: <20130528084035.13afa583@amdc308.digital.local>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lukasz Majewski <l.majewski@samsung.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Jonghwa Lee <jonghwa3.lee@samsung.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Vicent Guittot <vincent.guittot@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, MyungJoo Ham <myungjoo.ham@samsung.com>, Lukasz Majewski <l.majewski@majess.pl>

On 28 May 2013 12:10, Lukasz Majewski <l.majewski@samsung.com> wrote:
> On 27 May 2013 17:30, Rafael J. Wysocki <rjw@sisk.pl> wrote: <manually added by viresh>
>> On Monday, May 27, 2013 06:54:49 PM Viresh Kumar wrote:
>> > On 27 May 2013 17:30, Rafael J. Wysocki <rjw@sisk.pl> wrote:
>> I was talking about /sys/devices/system/cpu/cpufreq/boost that
>> appears to have been added by commit 615b730 (acpi-cpufreq: Add
>> support for disabling dynamic overclocking).
>>
>> That's in acpi-cpufreq, but since that setting seems to be generally
>> useful, it may be a good idea to move it to the core somehow.

Problem is in breaking existing cpufreq userspace for this driver.
Is this allowed?

> I think that Viresh wanted to add "boost" option to
> /sys/devices/system/cpu/cpuX/cpufreq/ to be able to control boost
> at separate cores (policies).
>
> The localization, which you have proposed:
> /sys/devices/system/cpu/cpufreq/boost
>
> implies, that boost is a global feature (enabled for all cores and for
> all available policies).
>
> Which approach shall be used then?

We can use: get_governor_parent_kobj() to get the best location
for boost. But I had some other issues in mind:
- boost is governor dependent.. i.e. It is only required for ondemand
governor (And LAB if it makes it to mainline :) ).. Other governors
doesn't need it. So, it would be better to add it in governor's directory.
- This will break existing users of acpi-cpufreq driver.

@Rafael: Please suggest what to do here.
