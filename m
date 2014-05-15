From: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: Format of patches
Date: Thu, 15 May 2014 09:37:53 -0700
Message-ID: <5374ED61.8050804@infradead.org>
References: <alpine.LRH.2.02.1405141012040.11670@file01.intranet.prod.int.rdu2.redhat.com>	<CAKohpo=h8cNbb2VbWzpDUPQDMK8QAs_sV=-SQyOaJWWFw4qKvA@mail.gmail.com>	<alpine.LRH.2.02.1405150614100.19101@file01.intranet.prod.int.rdu2.redhat.com>	<CAKohponwxi96buPx=vYgY1jZhSUanOZ2G7g2CjoapE=stzJcXw@mail.gmail.com>	<alpine.LRH.2.02.1405150843180.8791@file01.intranet.prod.int.rdu2.redhat.com> <CAKohpokGQSuts5rr4XeFb1dsykfNX-A--NXapkgJ2g0fUjVmQQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <CAKohpokGQSuts5rr4XeFb1dsykfNX-A--NXapkgJ2g0fUjVmQQ@mail.gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Mikulas Patocka <mpatocka@redhat.com>
Cc: "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 05/15/2014 07:00 AM, Viresh Kumar wrote:
> On 15 May 2014 18:15, Mikulas Patocka <mpatocka@redhat.com> wrote:
>>>> ---
>>>
>>> Blurb here :)
>>
>> Sure - but if I want you to read "Blurb here :)" before reading the git
>> message, I need to place it at the top of the email, before the git
>> message.
> 
> You can't, git will pick it up :)

Right.  The patch description goes at the top of the email.
If you want to include text that should not be part of the patch
description, you can put it after the --- or you can put it into
an introductory email (like [PATCH 0/5]).

> And people are trained enough to read stuff at this place as it was
> present over the top of mail :)


-- 
~Randy
