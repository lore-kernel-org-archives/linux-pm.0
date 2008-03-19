From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: Re: suspend slow in 2.6.25-rc6 (was Re: Suspend and
 hibernation	patchset against -rc6)
Date: Wed, 19 Mar 2008 23:35:10 +0300
Message-ID: <47E178FE.6050500@suse.de>
References: <200803120129.25585.rjw@sisk.pl> <200803172317.33745.rjw@sisk.pl>
	<20080318130642.GA1609@elf.ucw.cz>
	<20080318130710.GB1609@elf.ucw.cz>
	<alpine.LFD.1.00.0803181028400.3020@woody.linux-foundation.org>
	<20080318225201.GA2115@elf.ucw.cz>
	<alpine.LFD.1.00.0803181736340.3020@woody.linux-foundation.org>
	<20080319114851.GB21270@atrey.karlin.mff.cuni.cz>
	<alpine.LFD.1.00.0803190742450.3020@woody.linux-foundation.org>
	<20080319202323.GA1811@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080319202323.GA1811@elf.ucw.cz>
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
Cc: LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Johannes Berg <johannes@sipsolutions.net>
List-Id: linux-pm@vger.kernel.org

Pavel Machek wrote:
> Hi!
> 
>>> Ok, 7c0... is innocent. Reverting not only the mdelay, but also rest
>>> of drivers/acpi/ec.c patch fixed the
>>> "rc6-breaks-backlight-in-X-over-lid-close", good.
>> Can you clarify a bit?
>>
>> Do you mean that the full revert of 2c81ce4 that already got committed is 
>> sufficient for you, or do you need to totally undo everything we've done 
>> to ec.c since -rc5, and thus also to revert the _other_ revert we did (in 
>> 4af8e10a6c57e7292862bd1703712f0565c7e429)?
> 
> I did some more testing, and realized I was wrong. We need to totally
> undo everything we've done to ec.c since -rc5... (that has small
> sideffect of brightness up/down keys no longer working -- regression
> since 2.6.24, but saves us from "backlight gone after
> closing/reopening lid" which is _NASTY_ regression from 2.6.25-rc5).
> 
> ACPI sucks.
> 
> I.e. this patch:
> 
> 
> Revert ec.c to 2.6.25-rc5 state:
> 
> * this fixes backlight after closing/reopening the lid while in X on
> thinkpad x60
> 
> * unfortunately it breaks fn-home/end keyboard brightness control
It should also break volume up/down/mute keys. Essentially all the keys on Thinkpad.
And it would also be regression to 2.6.24 level.

Regards,
Alex.
