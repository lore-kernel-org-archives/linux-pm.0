From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Subject: Re: Bugs on aspire one A150
Date: Sun, 09 Nov 2008 10:43:28 +0000
Message-ID: <4916BED0.4090700__26108.0433651388$1226227594$gmane$org@tuffmail.co.uk>
References: <491506DB.1070000@gmail.com> <49157E97.60503@tuffmail.co.uk>
	<49163435.20301@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <49163435.20301@gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Maxim Levitsky <maximlevitsky@gmail.com>
Cc: linux acpi <linux-acpi@vger.kernel.org>, linux-pm@lists.linux-foundation.org, Kernel Testers List <kernel-testers@vger.kernel.org>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Maxim Levitsky wrote:
> Alan Jenkins wrote:
>> Maxim Levitsky wrote:
>>> I have just bought an Aspire one A150, XP version,
>>> as it was the only available here, and installed ubuntu on it.
>>>
>>> Bugs I discovered so far:
>>>
>>>
>>> ** 1 - embedded controler works in polling mode, due to this:
>>>
>>> [    0.708571] ACPI: EC: non-query interrupt received, switching to
>>> interrupt mode
>>> [    1.224043] ACPI: EC: missing confirmations, switch off interrupt
>>> mode.
>>>
>>>
>>> Maybe this is the reason for the fact that gnome power manager
>>> freezes when I unplug
>>> the AC, and freezes often when I try to see battery status.
>>>
>>>
>>> (Note: same is seen on my acer aspire 5720)
>>
>> That sounds like a known issue.  It has been resolved by "ACPI: EC:
>> revert msleep patch".  Happily Len submitted it for mainline this
>> week.  You will also find it if you try the acpi-test git tree. 
>> We're all hoping 2.6.28 will be much improved in terms of reliable
>> operation of different ECs :).
>>
> Yes, this almost fixes all issues with that.
> Almost because, it looks like the EC changes screen brightness on his
> own when battery is plugged/unplugged,
> but so does the gnome-power-manager, and thus it still hangs as before
> on battery removal (but doesn't hang otherwise)
> I disabled that behaver in gnome-power-manager and now no more hangs.
>

Please do report it as an ACPI EC bug.  It's popular hardware, and if
nothing else it is important that upstream be aware of the workarounds
people are having to use.

> I see that this fix fixes the polled mode. Any chance to make irq mode
> work?
>

Probably not.  It doesn't seem important, it may not be possible, and
even if you could fix the EC driver for your hardware, there's the risk
of breaking other peoples hardware.

The presumption is that you have weird hardware and it genuinely needs a
polling workaround.  It's not too bad, now it uses udelay() it should
not impose any wakeups or significant latency, just some extra cpu time
in a busy loop.  EC events such as acpi hotkeys are still received as
interrupts (although we then have to query the type of event using a
polled transaction).


I assume you get something like (text not exact):

"EC: started in polling mode"
...
"EC: non-query interrupt received, switching to interrupt mode"
...
"EC: missing confirmations, switching to polling mode"

all during boot.


There's one outstanding issue on a different machine, where the
occasional EC read fails and triggers polling mode sometime _after_
boot.  It can be fixed by retrying the transaction

    http://bugzilla.kernel.org/show_bug.cgi?id=11896

but I don't really expect your machine has the same problem.

<snip non-acpi problems>

>
> Also noticed another bug:
>
>
> If I suspend/resume with compiz running, on resume I see wallpaper and
> mouse cursor, everything hangs for minute or two, and sometimes forever.
>
> 2.6.27 worked fine.

Weird.

Did you try sysrq-W during the hang?  That's supposed to dump a list of
blocked tasks to dmesg.

>
> Also hibernate doesn't work on my main notebook, but it is probably
> fixed, I update kernel to really latest -git
> and tell you.
>

But suspend to ram works?  Usually it is the other way round :).  If you
haven't already, you might read

    Documentation/power/basic-pm-debugging.txt

it suggests some tests to narrow down the problem.

>
> Big thanks for bugfixes, you saved me a lot of work and bisecting.
>

I can't take credit for actual fixes.  But I'm very happy to help people
avoid bisecting for known problems.  I hope you have time to crack the
unknown ones :).

Alan
