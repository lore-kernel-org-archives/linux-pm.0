From: =?ISO-8859-1?Q?Felix_M=F6ller?= <felix@derklecks.de>
Subject: Re: [PATCH] ACPI PM: Restore the 2.6.24 suspend ordering
Date: Tue, 01 Apr 2008 16:38:34 +0200
Message-ID: <47F248EA.6070705@derklecks.de>
References: <200803300319.08398.rjw@sisk.pl> <200803301358.39831.rjw@sisk.pl>
	<20080330122838.GA7093@elf.ucw.cz> <200803301515.33922.rjw@sisk.pl>
	<20080401084523.GA25278@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080401084523.GA25278@atrey.karlin.mff.cuni.cz>
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
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Carlos Corbacho <carlos@strangeworlds.co.uk>, LKML <linux-kernel@vger.kernel.org>, Arthur Erhardt <erhardt@pit.physik.uni-tuebingen.de>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, pm list <linux-pm@lists.linux-foundation.org>, Felix M?ller <fm@opensuse.org>
List-Id: linux-pm@vger.kernel.org

Hi,
>>>>>> For the reasons outlined above, the change of the suspend ordering
>>>>>> should be reverted, which is done by the patch below.
>>>>> But this will break those few nvidia-based systems, no?
>>>>>
>>>>> this may have been a good idea in -rc1 days, but we are in -rc7
>>>>> now... and the patch is slightly big.
>>>> It's quite obvious, though.
>>> Yes, but breaking systems between -rc7 and final is _very_ unnice.
>> Breaking systems between 2.6.24 and 2.6.25 is even worse, which is why
>> I've posted this patch.
>>
>> IOW, we tried to fix systems that were broken with 2.6.24, but it didn't=
 work,
>> because our "fix" broke systems that were OK with 2.6.24.  Solution: rev=
ert
>> the "fix" and go back to the design board.  That's all we can do so late=
 in
>> the release cycle, IMO.
> =

> Well, I agree that regression from 2.6.24 is worse, but it is
> _slightly_ worse... -rcs are really expected to improve...
> =

> ...plus it no longer looks like macbook regression is caused by _PTS
> ordering?
I am the reporter from the original Novell Bug: =

https://bugzilla.novell.com/show_bug.cgi?id=3D374217

I just tried current git head (two hours ago) with the patch (the one =

from the beginning of this thread) from Rafael and without it. With the =

patch my MacBook does suspend without it does not.

HTH
Felix M=F6ller
