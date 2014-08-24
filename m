From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v7 00/11] kernel: Add support for restart handler call
 chain
Date: Sat, 23 Aug 2014 17:17:55 -0700
Message-ID: <53F92F33.3040704@roeck-us.net>
References: <1408495538-27480-1-git-send-email-linux@roeck-us.net> <20140823163505.GA25900@roeck-us.net> <1868939.JnM9WCSHq4@diego>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1868939.JnM9WCSHq4@diego>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: =?windows-1252?Q?Heiko_St=FCbner?= <heiko@sntech.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, Russell King <linux@arm.linux.org.uk>, Wim Van Sebroeck <wim@iguana.be>, Catalin Marinas <catalin.marinas@arm.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, linux-watchdog@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-pm@vger.kernel.org

On 08/23/2014 04:00 PM, Heiko St=FCbner wrote:
> Am Samstag, 23. August 2014, 09:35:05 schrieb Guenter Roeck:
>> On Tue, Aug 19, 2014 at 05:45:27PM -0700, Guenter Roeck wrote:
>>> Various drivers implement architecture and/or device specific means
>>> to restart (reset) the system. Various mechanisms have been impleme=
nted
>>> to support those schemes. The best known mechanism is arm_pm_restar=
t,
>>> which is a function pointer to be set either from platform specific=
 code
>>> or from drivers. Another mechanism is to use hardware watchdogs to =
issue
>>> a reset; this mechanism is used if there is no other method availab=
le
>>> to reset a board or system. Two examples are alim7101_wdt, which cu=
rrently
>>> uses the reboot notifier to trigger a reset, and moxart_wdt, which
>>> registers the arm_pm_restart function. Several other restart driver=
s for
>>> arm, all directly calling arm_pm_restart, are in the process of bei=
ng
>>> integrated into the kernel. All those drivers would benefit from th=
e new
>>> API.
>>>
>>> The existing mechanisms have a number of drawbacks. Typically only =
one
>>> scheme to restart the system is supported (at least if arm_pm_resta=
rt is
>>> used). At least in theory there can be multiple means to restart th=
e
>>> system, some of which may be less desirable (for example one mechan=
ism
>>> may only reset the CPU, while another may reset the entire system).=
 Using
>>> arm_pm_restart can also be racy if the function pointer is set from=
 a
>>> driver, as the driver may be in the process of being unloaded when
>>> arm_pm_restart is called.
>>> Using the reboot notifier is always racy, as it is unknown if and w=
hen
>>> other functions using the reboot notifier have completed execution
>>> by the time the watchdog fires.
>>>
>>> Introduce a system restart handler call chain to solve the describe=
d
>>> problems. This call chain is expected to be executed from the
>>> architecture specific machine_restart() function. Drivers providing
>>> system restart functionality (such as the watchdog drivers mentione=
d
>>> above) are expected to register with this call chain. By using the
>>> priority field in the notifier block, callers can control restart h=
andler
>>> execution sequence and thus ensure that the restart handler with th=
e
>>> optimal restart capabilities for a given system is called first.
>>>
>>> Since the first revision of this patchset, a number of separate pat=
ch
>>> submissions have been made which either depend on it or could make =
use of
>>> it.
>>>
>>> http://www.spinics.net/linux/lists/arm-kernel/msg344796.html
>>>
>>> 	registers three notifiers.
>>>
>>> https://lkml.org/lkml/2014/7/8/962
>>>
>>> 	would benefit from it.
>>>
>>> Patch 1 of this series implements the restart handler function. Pat=
ches 2
>>> and 3 implement calling the restart handler chain from arm and arm6=
4
>>> restart code.
>>>
>>> Patch 4 modifies the restart-poweroff driver to no longer call
>>> arm_pm_restart directly but machine_restart. This is done to avoid
>>> calling arm_pm_restart from more than one place. The change makes t=
he
>>> driver architecture independent, so it would be possible to drop th=
e arm
>>> dependency from its Kconfig entry.
>>>
>>> Patch 5 and 6 convert existing restart handlers in the watchdog sub=
system
>>> to use the restart handler. Patch 7 unexports arm_pm_restart to ens=
ure
>>> that no one gets the idea to implement a restart handler as module.
>>>
>>> The entire patch series, including additional patches depending on =
it,
>>> is available from
>>> https://git.kernel.org/cgit/linux/kernel/git/groeck/linux-staging.g=
it/
>>> in branch 'restart-staging'.
>>
>> Hi Andrew,
>>
>> I think this series is ready for upstream integration. Question now
>> is how we should proceed to get it actually integrated.
>>
>> I can see a number of options:
>> - You take patch #1, the rest goes in through maintainer trees.
>
> I don't think you can split the patches like this. Patch1 introduces
> (un)register_restart_handler functions used by later patches in the s=
eries.
> You therefore cannot really split the series, as otherwise you would =
get build
> failures in the individual trees.
>
No, it would simply delay integration of the entire series by a release
or two. First two patches go in first, then #3 and #4, then the rest.

I don't like that option too much either, but it is better than nothing=
=2E

Guenter
