From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: AMD FX-4130 part only runs at 2.6/3.4GHz
Date: Mon, 12 Aug 2013 11:05:26 +0530
Message-ID: <CAKohpomAaeR_=J9mJLqdhm89WayePQRAGVw+rDJUayDzXDiT5A@mail.gmail.com>
References: <20130809214255.GA5893@amd.pavel.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <20130809214255.GA5893@amd.pavel.ucw.cz>
Sender: cpufreq-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>, Dirk Brandewie <dirk.j.brandewie@intel.com>
Cc: kernel list <linux-kernel@vger.kernel.org>, rjw@sisk.pl, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, andreas.herrmann3@amd.com
List-Id: linux-pm@vger.kernel.org

On 10 August 2013 03:12, Pavel Machek <pavel@ucw.cz> wrote:
> Hi!
>
> I have
>
> DMI: Gigabyte Technology Co., Ltd. GA-78LMT-S2P/GA-78LMT-S2P, BIOS F3 10/18/2012
>
> mainboard and AMD FX-4130 processor.
>
> processor : 3
> vendor_id : AuthenticAMD
> cpu family  : 21
> model         : 1
> model name    : AMD FX(tm)-4130 Quad-Core Processor
> stepping      : 2
> microcode     : 0x6000629
> cpu MHz         : 1400.000
> cache size      : 2048 KB
>
> ...but it seems to run slower than it should. According to box, stock
> frequency should be 3.8GHz, with 3.9GHz turbo, but it only goes to
> 3.4GHz (and seems to only go there in "turbo" mode -- not all cores at
> once.)
>
> Kernel is:
>
> Linux version 3.11.0-rc2 (pavel@Elf) (gcc version 4.4.5 (Debian
> 4.4.5-8) ) #320 SMP Fri Aug 9 23:22:58 CEST 2013
>
> cpufreq says:
>
> pavel@Elf:~$ cat
> /sys/devices/system/cpu/cpu0/cpufreq/scaling_available_frequencies
> 3400000 2800000 2600000 1800000 1400000

So, cpufreq doesn't have this frequency to set..

Which cpufreq driver are you using?

> pavel@Elf:~$
>
> Suspicious dmesg:
>
> ACPI Warning: \_PR_.C000._PSS: SubPackage[0,1] - suspicious power
> dissipation values (20130517/nsrepair2-710)
> acpi-cpufreq: overriding BIOS provided _PSD data
> ACPI Warning: \_PR_.C001._PSS: SubPackage[0,1] - suspicious power
> dissipation values (20130517/nsrepair2-710)
> ACPI Warning: \_PR_.C002._PSS: SubPackage[0,1] - suspicious power
> dissipation values (20130517/nsrepair2-710)
> ACPI Warning: \_PR_.C003._PSS: SubPackage[0,1] - suspicious power
> dissipation values (20130517/nsrepair2-710)
> ALSA device list:
>   #0: HDA ATI SB at 0xfe024000 irq 16
>   #1: HD-Audio Generic at 0xfdffc000 irq 19
>
> I can manually tweak multiplier in the BIOS to get to 3812 (or so)
> MHz, but the machine does not seem stable in that setting.
>
> Any idea what is going on?
>
> Thanks,
>                                                                         Pavel
>
> --
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
