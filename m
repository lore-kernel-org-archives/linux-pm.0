From: Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH v4 00/13] arm64: kernel: Add support for hibernate/suspend-to-disk
Date: Tue, 02 Feb 2016 16:42:20 -0800
Message-ID: <7hmvrid3pv.fsf@baylibre.com>
References: <1453977766-20907-1-git-send-email-james.morse@arm.com>
	<7hvb6chv5e.fsf@baylibre.com> <56AF1D07.3000604@arm.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f181.google.com ([209.85.192.181]:33771 "EHLO
	mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755303AbcBCAmW (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 2 Feb 2016 19:42:22 -0500
Received: by mail-pf0-f181.google.com with SMTP id w123so3314036pfb.0
        for <linux-pm@vger.kernel.org>; Tue, 02 Feb 2016 16:42:21 -0800 (PST)
In-Reply-To: <56AF1D07.3000604@arm.com> (James Morse's message of "Mon, 01 Feb
	2016 08:53:27 +0000")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: James Morse <james.morse@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, Will Deacon <will.deacon@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Kevin Kang <kkang@intrinsyc.com>, Geoff Levand <geoff@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, AKASHI Takahiro <takahiro.akashi@linaro.org>, wangfei <w.f@huawei.com>, linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Marc Zyngier <marc.zyngier@arm.com>

James Morse <james.morse@arm.com> writes:

> On 29/01/16 22:34, Kevin Hilman wrote:
>> James Morse <james.morse@arm.com> writes:
>> I'd like to help in testing this so I'm just curious which platforms
>> you've been testing this on.  I'm assuming a Juno (r2?), anything else?
>
> That would be great - thanks!
>
> I've done most of the testing on a Juno r1, but also gave it a spin on a
> stray Seattle.

OK, I'm using a very recently arrived Juno R2, and I did get it
working.  I have a few other arm64 boards around that ar part of
kernelci.org and will try those as well.

>> Are you testing the resume from cold boot, or just from kexec?
>
> From cold boot. I haven't tried with kexec, but I doubt that's a use-case anyone
> wants as you would resume immediately. (might be interesting for testing though)
>
>
>> For cold boot on Juno, I'm assuming there would be some
>> booloader/firmware changes needed to find and boot from the hibernation
>> image?
>
> Not at all! Your firmware only needs to support some mechanism to
> turning CPUs off.
>
> If you add 'resume=/dev/sda2' (or wherever your swap partition is located), the
> kernel will check this partition for the hibernate-image signature, if found, it
> will resume from that partition. Otherwise booting is as normal. (there is one
> hoop to jump through to ensure your rootfs hasn't been mounted before the kernel
> starts resume, as you could corrupt it - an initramfs in the kernel is the best
> fix for this).
>
> No firmware changes needed.
>
>> Is that being worked on?  If not Juno, are you aware of any
>> other platforms that could be tested with resume from cold boot?
>
> Any arm64 platform with persistent storage should work. I've been using a swap
> partition on a usb drive.

>> Not knowing the answers to the above, I tested your branch using arm64
>> defconfig + CONFIG_HIBERNATION=y on my Juno and noticed that it didn't
>> stay suspended (full suspend log below) so I'm looking for
>> ideas/recommenations on how to test this.
>
> That trace looks quite normal, (one of mine below[0] for comparison). Any
> failure would have happened after the point you stopped ... did you have a swap
> partition 'on'?

I think I must have not setup swap correctly since after testing again
it's working fine.  Maybe I forgot the 'swapon'?  In any case, being a
little more careful, testing again and things are working fine on Juno.

I'm also using swap on USB storage for now.

> 'syscore' will freeze all processes and stop all devices, then create a
> copy of the minimum amount of memory it needs to save. Then it starts
> all the devices again, as it needs to write this image out to swap. This is what
> you are seeing.
>
> Once it has done this it calls poweroff or reboot.

Yeah, I wasn't seeing the call to poweroff, but most likely because it
was failing to fully write the image due to my missing/incorrect swap
setup.

Thanks for the help,

Kevin
