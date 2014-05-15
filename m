From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: Format of patches (was: [PATCH 1/2] speedstep-smi: enable
 interrupts when waiting)
Date: Thu, 15 May 2014 16:15:32 +0530
Message-ID: <CAKohponwxi96buPx=vYgY1jZhSUanOZ2G7g2CjoapE=stzJcXw@mail.gmail.com>
References: <alpine.LRH.2.02.1405141012040.11670@file01.intranet.prod.int.rdu2.redhat.com>
	<CAKohpo=h8cNbb2VbWzpDUPQDMK8QAs_sV=-SQyOaJWWFw4qKvA@mail.gmail.com>
	<alpine.LRH.2.02.1405150614100.19101@file01.intranet.prod.int.rdu2.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.LRH.2.02.1405150614100.19101@file01.intranet.prod.int.rdu2.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mikulas Patocka <mpatocka@redhat.com>
Cc: "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 15 May 2014 16:07, Mikulas Patocka <mpatocka@redhat.com> wrote:
> On Thu, 15 May 2014, Viresh Kumar wrote:
>> On 14 May 2014 19:54, Mikulas Patocka <mpatocka@redhat.com> wrote:
>> > Hi Viresh
>> >
>> > Some times ago, I sent these two cpufreq patches to fix frequency
>> > transition problem on speedstep-smi, but you didn't put them to the
>> > upstream kernel. I am resending the patches. If you would like a different
>> > solution to this problem, please explain it.
>>
>> Probably these are just missed by Rafael. The patches are fine but the
>> above paragraph you wrote would get into kernel logs and must have
>> been placed below the three dash lines: "---"
>
> I used "---" in the past, but some people complained that their script
> picks the text above "---" and ignores the text below "---" - thus, it
> does exactly the opposite of what it should do.

Have you added an extra line with --- ? Probably yes.
I haven't asked you to add another line, but move the part you don't want
to be commited below --- already present in patch..

Like:

> ---

Blurb here :)

>  drivers/cpufreq/speedstep-lib.c |    3 +++
>  drivers/cpufreq/speedstep-smi.c |   12 ++++++++++++
>  2 files changed, 15 insertions(+)
>


> I don't know what kind of delimiter should I use. Suppose that I want to
> send something like this:

Will go through below mail of yours once we are clear on above..
