From: Nishanth Menon <nm@ti.com>
Subject: Re: [RFC PATCH] cpufreq: cpufreq-cpu0: do not allow transitions with
 regulators suspended
Date: Fri, 15 Nov 2013 07:33:31 -0600
Message-ID: <528622AB.1050500@ti.com>
References: <1382638087-32054-1-git-send-email-nm@ti.com>	<CAKohponJOOfGX4BHn76LTBDTm58+2QxPf_rv1i4avVfrWhfkRg@mail.gmail.com>	<52824522.7020401@ti.com>	<CAKohpomB=wnct88wrTvW-qixLQPQGjVrCVF3V-BSbY7mhsSYQg@mail.gmail.com>	<20131113151645.GA17828@kahuna>	<52842671.40703@linaro.org>	<5284DDB9.7040502@ti.com>	<5284FE48.8040802@linaro.org>	<528502AC.4010604@ti.com> <CAKohpokz6YEqz8ZNmQ77y8K3qvKYu3ffgVmiEcDyh2M9FsDGPg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <CAKohpokz6YEqz8ZNmQ77y8K3qvKYu3ffgVmiEcDyh2M9FsDGPg@mail.gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Shawn Guo <shawn.guo@linaro.org>
List-Id: linux-pm@vger.kernel.org

On 11/15/2013 04:27 AM, Viresh Kumar wrote:
> On 14 November 2013 22:34, Nishanth Menon <nm@ti.com> wrote:
>> I think it is still too early to do so :(
> 
> :)
:D

> 
>> equivalent patch: http://pastebin.mozilla.org/3603467 (with minor
>> changes for build)
>>
>> Basic tests: http://pastebin.mozilla.org/3603456 (governor is
>> functional, but governor kicks in early before i2c is resumed)
>>
>> With call stack: http://pastebin.mozilla.org/3603455 to highlight call
>> sequences
>>
>> Seems like we might want to pause governor as early in the suspend
>> sequence as possible to allow SoC and regulator stuff to suspend
>> themselves without cpufreq interfering.. just my 2 cents..
> 
> You made me spend a day on this :)
> It wasn't a day's job really but I got into a really hard to crack bug with my
> patch, I was calling __cpufreq_governor() from under write_lock_irqsave
> for cpufreq_driver_lock. And __cpufreq_governor() had:
> 
>  read_lock_irqsave(&cpufreq_driver_lock, flags);
> 
> I wasn't able to suspend my system: ARM, X86.. It simply stopped
> printing anything and I didn't had a clue of what's going on.. Hacked
> everything possible, even kernel/power/suspend.c to return early
> (yeah I used freezer > pm_test as well, but I wanted to return before
> freezing userspace)...
> 
> Then somehow I got to know that this is the wrong piece of code :)

Thanks a ton for your efforts in helping come with a generic solution.

> 
> But probably I have a solution now to which you can't say:

https://patchwork.kernel.org/patch/3187511/ as a link for the records :)

> 
> "I think it is still too early to do so :("
> 
> :)
> 
> Give it a try and give a Tested-by please :)
> 
Definitely - on it.. will feedback further on the patch in proposal.

-- 
Regards,
Nishanth Menon
