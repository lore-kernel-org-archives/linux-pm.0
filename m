From: david@lang.hm
Subject: Re: Hibernation considerations
Date: Sat, 21 Jul 2007 12:35:50 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0707211232580.6577@asgard.lang.hm>
References: <Pine.LNX.4.44L0.0707171010490.3551-100000@iolanthe.rowland.org>
	<200707171802.30903.rjw@sisk.pl>
	<Pine.LNX.4.64.0707170959160.2467@asgard.lang.hm>
	<200707172150.44417.rjw@sisk.pl>
	<Pine.LNX.4.64.0707171302430.2467@asgard.lang.hm>
	<20070721102520.GE1902@elf.ucw.cz> <87ps2lojlc.fsf@jbms.ath.cx>
	<20070721175639.GA3701@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070721175639.GA3701@elf.ucw.cz>
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
Cc: LKML <linux-kernel@vger.kernel.org>, Kyle Moffett <mrmacman_g4@mac.com>, Al Boldi <a1426z@gawab.com>, "Eric W. Biederman" <ebiederm@xmission.com>, "Huang,
	Ying" <ying.huang@intel.com>, Andrew Morton <akpm@linux-foundation.org>, pm list <linux-pm@lists.linux-foundation.org>, Jeremy Maitin-Shepard <jbms@cmu.edu>
List-Id: linux-pm@vger.kernel.org

On Sat, 21 Jul 2007, Pavel Machek wrote:

> Hi!
>
>> Pavel Machek <pavel@ucw.cz> writes:
>>
>> [snip]
>>
>>> So it will be break at least battery status and "AC plugged in"
>>> status, because those are handled by ACPI and we do not know how to
>>> control them by hand.
>>
>> It seems that it should be possible to initialize ACPI as if the system
>> just booted up normally.  Then battery status and such should be
>> correct, since they are correct after normal initialization.
>>
>> It should be possible to make hibernate look just like a reboot to all
>> of the devices, including ACPI stuff.
>
> Patch to make that work with swsusp/shutdown method would be indeed
> welcome. It does not work today.

is this a problem in the restore path?

with the kexec approach (and ignoring suspend to ram and disk for the 
moment) the system will actually get shutdown completely after the image 
is written. on resume it gets cold booted. at this point the ACPI stuff 
should have no problem

now if the ACPI drivers are storing something in ram about the battery 
status and AC power status, but don't re-check after the resume, it seems 
to me that they can't possibly be reliable anyway. if they do re-check 
after the resume then where's the problem?

David Lang
