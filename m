From: Nigel Cunningham <ncunningham@crca.org.au>
Subject: Re: syncing the disks when entering sleep
Date: Tue, 02 Feb 2010 09:03:24 +1100
Message-ID: <4B674FAC.8020900@crca.org.au>
References: <76FA3B279DD9DA48896E2B404944957204E0B241@USA7061MS02.na.xerox.net>
	<201001272146.43660.rjw@sisk.pl> <20100131085210.GH2238@elf.ucw.cz>
	<201001311333.37620.rjw@sisk.pl>
	<20100201104922.GC5809@atrey.karlin.mff.cuni.cz>
	<4B673FA8.4050603@crca.org.au> <20100201210748.GA13638@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100201210748.GA13638@elf.ucw.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-pm@lists.linux-foundation.org, "Leisner,
	Martin" <Martin.Leisner@xerox.com>
List-Id: linux-pm@vger.kernel.org

Hi.

Pavel Machek wrote:
> On Tue 2010-02-02 07:55:04, Nigel Cunningham wrote:
>> Pavel Machek wrote:
>>>> On Sunday 31 January 2010, Pavel Machek wrote:
>>>>> On Wed 2010-01-27 21:46:43, Rafael J. Wysocki wrote:
>>>>>> On Wednesday 27 January 2010, Pavel Machek wrote:
>>>>>>>>> Per-system property, which should better be
>>>>>>>>> per-program-that-requires-suspend. You request suspend without syncing
>>>>>>>>> (you want it quick, battery is 90%), then the battery runs low, and
>>>>>>>>> system daeomn requests s2ram, not realizing that someone disabled sync
>>>>>>>>> from under him.
>>>>>>>> I really prefer a per-system setting.  The program that wants to sync anyway
>>>>>>>> can easily do that by itself.
>>>>>>> Yes, but existing apps do not know they have to sync. You are
>>>>>>> essentially adding "break back compatibility" system wide option, when
>>>>>>> better alternative exists... See above for concrete example where it
>>>>>>> may hurt.
>>>>>> I don't get what the problem is, really.
>>>>>>
>>>>>> There's _nothing_ here that breaks the existing behavior.  If the user doesn't
>>>>>> set the switch, everything works as usual.  If he does, breaking the "back
>>>>>> compatibility" is _his_ problem.
>>>>> So... you give them option to break back compatibility then blame it
>>>>> on them.... Yes, we could do it, but it is not good.
>>>>>
>>>>> And better alternative exists, where you make the option per-suspend
>>>>> so it does not have chance to break compatibility later.
>>>> I'm not sure what you mean.  Would you like it to reset itself during resume
>>>> or something like this?
>>> Yes, that or something similar would certainly help.
>> No, that would only make things more confusing. What other kernel knob
>> turns itself off like that? Even drop caches, which might be reasonably
>> expected to do so, doesn't.
> 
> IIRC drop caches only drops once...

Yes. It drops them when you set the value non zero (value is a bitflag
saying what to drop). To do the same thing  again, you need to set it to
some other value then to the value you want.

> Fine, that simply shows that we should not have the knob. Rather,
> suspend should be getting parameters; one of them is suspend type (S1,
> mem, disk), second is test mode (full, only drivers, only core, ...),
> next is whether to sync or not...
> 
> Maybe we really want sys_suspend() syscall.

I don't see why it shows that we should not have the knob, or rather,
why you're now arguing that the knob should exist, but be hidden in a
binary only interface. It seems illogical.

Regards,

Nigel
