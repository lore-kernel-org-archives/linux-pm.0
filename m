From: Paul Menzel <pmenzel@molgen.mpg.de>
Subject: Why is suspend with s2idle available on POWER8 systems?
Date: Sat, 27 Apr 2019 12:53:59 +0200
Message-ID: <5fdabbb9-0a62-4802-f1ca-f83584f935fa@molgen.mpg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linuxppc-dev@lists.ozlabs.org, linux-pm@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Dear Linux folks,


Updating an IBM S822LC from Ubuntu 18.10 to 19.04 some user space stuff 
seems to have changed, so that going into sleep/suspend is enabled.

That raises two questions.

1.  Is suspend actually supported on a POWER8 processor?

> Apr 27 10:18:13 power NetworkManager[7534]: <info>  [1556353093.7224] manager: sleep: sleep requested (sleeping: no  e
> Apr 27 10:18:13 power systemd[1]: Reached target Sleep.
> Apr 27 10:18:13 power systemd[1]: Starting Suspend...
> Apr 27 10:18:13 power systemd-sleep[82190]: Suspending system...
> Apr 27 10:18:13 power kernel: PM: suspend entry (s2idle)
> -- Reboot --

> $ uname -m
> ppc64le
> $ more /proc/version
> Linux version 5.1.0-rc6+ (joey@power) (gcc version 8.3.0 (Ubuntu 8.3.0-6ubuntu1)) #1 SMP Sat Apr 27 10:01:48 CEST 2019
> $ more /sys/power/mem_sleep
> [s2idle]
> $ more /sys/power/state
> freeze mem
> $ grep _SUSPEND /boot/config-5.0.0-14-generic # also enabled in Ubuntu’s configuration
> CONFIG_ARCH_SUSPEND_POSSIBLE=y
> CONFIG_SUSPEND=y
> CONFIG_SUSPEND_FREEZER=y
> # CONFIG_SUSPEND_SKIP_SYNC is not set
> # CONFIG_PM_TEST_SUSPEND is not set

Should the Kconfig symbol `SUSPEND` be selectable? If yes, should their 
be some detection during runtime?

2.  If it is supported, what are the ways to getting it to resume? What 
would the IPMI command be?

For now I disabled the automatic suspend, masking the targets [1].


Kind regards,

Paul


[1]: https://wiki.debian.org/Suspend#Disable_suspend_and_hibernation
