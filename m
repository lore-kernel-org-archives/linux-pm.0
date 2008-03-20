From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: suspend slow in 2.6.25-rc6 (was Re: Suspend and
	hibernation	patchset against -rc6)
Date: Thu, 20 Mar 2008 19:26:33 -0300
Message-ID: <20080320222633.GA20788__30051.0250767276$1206052172$gmane$org@khazad-dum.debian.net>
References: <200803120129.25585.rjw@sisk.pl> <200803172317.33745.rjw@sisk.pl>
	<20080318130642.GA1609@elf.ucw.cz>
	<20080318130710.GB1609@elf.ucw.cz>
	<alpine.LFD.1.00.0803181028400.3020@woody.linux-foundation.org>
	<20080318232037.GA1670@elf.ucw.cz>
	<20080320151931.GD5615@khazad-dum.debian.net>
	<47E287D4.3060906@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <47E287D4.3060906@gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alexey Starikovskiy <aystarik@gmail.com>
Cc: Alexey Starikovskiy <astarikovskiy@suse.de>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Pavel Machek <pavel@suse.cz>, pm list <linux-pm@lists.linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Johannes Berg <johannes@sipsolutions.net>
List-Id: linux-pm@vger.kernel.org

On Thu, 20 Mar 2008, Alexey Starikovskiy wrote:
> Henrique de Moraes Holschuh wrote:
>> On Wed, 19 Mar 2008, Pavel Machek wrote:
>>   
>>>     Also, for polling mode to work on Acers, we need
>>>     to insert a delay.
>>
>> Can we, in the future, always trigger any such performance damaging "fixups"
>> based on DMI white/black lists?  As a rule?
>>   
> Poll mode is not supposed to be entered on any non-broken HW.

We have seen just how much we can trust that, haven't we?

The truth is that even secondary last-resort paths like this need to work
well, and as fast as possible.  As things stand, we DO excercise them a lot
more than we'd expect...

> The fact that it happens now with Thinkpads at suspend is a bug.

Sure, and one we should fix.  That doesn't change the fact that any broken
HW (or one hit by a kernel bug) that is not as broken as some Acers don't
need to take that 5ms hit on every EC transaction, in an EC mode that is
already way too slow without extra help.

> EC region should not be accessed with interrupts of GPEs disabled.

Looks like something we should tack a WARN_ONCE to, at least when in a debug
mode compile?

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
