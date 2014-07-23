From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2] cpufreq: tests: Providing cpufreq regression test
Date: Wed, 23 Jul 2014 16:18:51 +0530
Message-ID: <CAKohpomfGsvzJUn23-u-KoyNaY8sRaMLk0S4GdQJR0DxyscJWg@mail.gmail.com>
References: <1405678985-21677-1-git-send-email-l.majewski@samsung.com>
	<1405926154-27214-1-git-send-email-l.majewski@samsung.com>
	<CAKohpondk7Cty8MhTcjyzZW8Z0o4AVupYE0rRnG4YJf+SmDyjg@mail.gmail.com>
	<20140723093824.5e51918f@amdc2363>
	<CAKohpok++gPcNk9-E4MsFdNBy8qL7oLYvatk1EvcW1OHwroZXQ@mail.gmail.com>
	<20140723121042.5b6f49e3@amdc2363>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f45.google.com ([209.85.218.45]:50392 "EHLO
	mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757907AbaGWKsv (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 23 Jul 2014 06:48:51 -0400
Received: by mail-oi0-f45.google.com with SMTP id e131so723718oig.32
        for <linux-pm@vger.kernel.org>; Wed, 23 Jul 2014 03:48:51 -0700 (PDT)
In-Reply-To: <20140723121042.5b6f49e3@amdc2363>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lukasz Majewski <l.majewski@samsung.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Thomas Abraham <ta.omasab@gmail.com>, "thomas.ab@samsung.com" <thomas.ab@samsung.com>, Lukasz Majewski <l.majewski@majess.pl>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Tomasz Figa <t.figa@samsung.com>, Sachin Kamat <spk.linux@gmail.com>, Marek Szyprowski <m.szyprowski@samsung.com>

On 23 July 2014 15:40, Lukasz Majewski <l.majewski@samsung.com> wrote:

>> Shouldn't you use userspace governor then instead of performance?
>
> Performance assures that we will have the right frequency set.

Why wouldn't userspace assure that?

> However, there can be a similar patch to use userspace governor and
> various load to fail if ondemand's frequency flipping is detected.

That's why I want to get to the motive behind this patch.
AFAIU, we are checking if its fine to switch to available frequencies
or not and if yes, do we actually switch to those. Right?

For, this testcase we just need a single test and I still don't see why
performance is better than userspace?

>> And then we don't need the gzip stuff at all. We can just set it to
>> the right freq and get current freq to see if it matches?
>
> Sometimes "interresting" things show up when you have 100% CPU load and
> you try to switch frequency.

That's a different test then. And that's how it should be presented.
So, probably another option to the script, which isn't forced on people.
