From: Chen Yu <yu.c.chen@intel.com>
Subject: Re: [PATCH] x86 / hibernate: Use hlt_play_dead() when resuming from
 hibernation
Date: Wed, 13 Jul 2016 18:29:57 +0800
Message-ID: <57861825.90805@intel.com>
References: <1467105403-5085-1-git-send-email-yu.c.chen@intel.com>
 <12570565.xIMhLmhDgj@vostro.rjw.lan> <20160713095617.GB27870@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160713095617.GB27870@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-pm@vger.kernel.org, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@suse.de>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org, James Morse <james.morse@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, varun koyyalagunta <cpudebug@centtech.com>
List-Id: linux-pm@vger.kernel.org

Hi Pavel,

On 2016=E5=B9=B407=E6=9C=8813=E6=97=A5 17:56, Pavel Machek wrote:
> On Sun 2016-07-10 03:49:25, Rafael J. Wysocki wrote:
>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>
>> On Intel hardware, native_play_dead() uses mwait_play_dead() by
>> default and only falls back to the other methods if that fails.
>> That also happens during resume from hibernation, when the restore
>> (boot) kernel runs disable_nonboot_cpus() to take all of the CPUs
>> except for the boot one offline.
>>
>> However, that is problematic, because the address passed to
>> __monitor() in mwait_play_dead() is likely to be written to in the
>> last phase of hibernate image restoration and that causes the "dead"
>> CPU to start executing instructions again.  Unfortunately, the page
>> containing the address in that CPU's instruction pointer may not be
>> valid any more at that point.
>>
>> First, that page may have been overwritten with image kernel memory
>> contents already, so the instructions the CPU attempts to execute ma=
y
>> simply be invalid.  Second, the page tables previously used by that
>> CPU may have been overwritten by image kernel memory contents, so th=
e
>> address in its instruction pointer is impossible to resolve then.
>>
>> A report from Varun Koyyalagunta and investigation carried out by
>> Chen Yu show that the latter sometimes happens in practice.
>>
>> To prevent it from happening, modify native_play_dead() to make
>> it use hlt_play_dead() instead of mwait_play_dead() during resume
>> from hibernation which avoids the inadvertent "revivals" of "dead"
>> CPUs.
>>
>> A slightly unpleasant consequence of this change is that if the
>> system is hibernated with one or more CPUs offline, it will generall=
y
>> draw more power after resume than it did before hibernation, because
>> the physical state entered by CPUs via hlt_play_dead() is higher-pow=
er
>> than the mwait_play_dead() one in the majority of cases.  It is
>> possible to work around this, but it is unclear how much of a proble=
m
>> that's going to be in practice, so the workaround will be implemente=
d
>> later if it turns out to be necessary.
>>
>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D106371
>> Reported-by: Varun Koyyalagunta <cpudebug@centtech.com>
>> Original-by: Chen Yu <yu.c.chen@intel.com>
>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> I notice that it changes even i386, where it should not be
> neccessary. But we probably should switch i386 to support similar to
> x86-64 one day (and I have patches) so no problem there.
>
> But I wonder if simpler solution is to place the mwait semaphore into
> known address? (Nosave region comes to mind?)

Previously we tried to change the monitor
address from task.flag to the zero page, because no one would write
data to zero page. But there is still problem because of a possible
ping-pong wake up scenario in mwait_play_dead:

As Varun Koyyalagunta said(on his x86 platform) one possible implementa=
tion of
a clflush is a read-invalidate snoop, which is what a store might look =
like,
so cflush might wake up the cpu from mwait.

1. CPU1 waits at zero page
2. CPU2 cflush zero page, wake CPU1 up, then CPU2 waits at zero page
3. CPU1 is woken up, and invoke cflush zero page, thus wake up CPU2 aga=
in.
then the nonboot CPUs never sleep for long.

So it's better to monitor different address for each
nonboot CPUs, however since there is only one zero page, at most:
PAGE_SIZE/L1_CACHE_LINE CPUs are satisfied, which is usually 64
on a x86_64, apparently it's not enough for servers, maybe more
zero pages are required. So we  tried to use hlt, which looks simpler.
Using Nosave region might also have this problem IMO.

thanks,
Yu
