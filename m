From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/2] cpufreq: serialize calls to __cpufreq_governor()
Date: Fri, 10 Oct 2014 14:34:41 +0530
Message-ID: <CAKohpok+z+bPySa+Kzh2zW+2L8CCG29q6wANe3jd+o80+PnASA@mail.gmail.com>
References: <CAKohpo=rEYgH+PSmkP8X8J0u69Kyp1W7JzBFOiOsiCOFSdyAiw@mail.gmail.com>
	<54353223.7080704@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f46.google.com ([209.85.218.46]:40861 "EHLO
	mail-oi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752017AbaJJJEm (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 10 Oct 2014 05:04:42 -0400
Received: by mail-oi0-f46.google.com with SMTP id h136so5957075oig.5
        for <linux-pm@vger.kernel.org>; Fri, 10 Oct 2014 02:04:41 -0700 (PDT)
In-Reply-To: <54353223.7080704@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Prarit Bhargava <prarit@redhat.com>, =?UTF-8?Q?Robert_Sch=C3=B6ne?= <robert.schoene@tu-dresden.de>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Saravana Kannan <skannan@codeaurora.org>

On 8 October 2014 18:16, Prarit Bhargava <prarit@redhat.com> wrote:
> On 10/08/2014 03:04 AM, Viresh Kumar wrote:

>> The last state of my branch: cpufreq/governor-fixes you tested had
>> few bugs in it and so you weren't able to even tests things up.
>>
>> I couldn't manage to test my patches on a multi-cluster system
>> (couldn't get it up yet :( ), but was able to do that on a dual-core
>> ARM-cortexA15 board. And could simply find the bugs there.
>>
>> I have updated my branch with the changes now and it would be
>> great if you can confirm if they fix your issues or not.
>>
>> git://git.linaro.org/people/viresh.kumar/linux.git cpufreq/governor-fixes

Robert/Prarit,

I thought you guys would test this very quickly as it had been hanging since
long time. What happened ?

> Hey Viresh, this is on my plate for today.  It does look like the panic I sent
> you yesterday in email does occur when your patches are put into the latest
> upstream kernel :(.

I have tested my patches over mainline only, i.e. v3.17 .

Even the branch I mentioned above is based on that.
