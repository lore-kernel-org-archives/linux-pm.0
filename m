From: david@lang.hm
Subject: Re: Hibernation considerations
Date: Tue, 17 Jul 2007 14:04:13 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0707171354240.2467__25877.0962631845$1184706747$gmane$org@asgard.lang.hm>
References: <Pine.LNX.4.44L0.0707171416120.3728-100000@iolanthe.rowland.org>
	<200707172217.01890.rjw@sisk.pl>
	<Pine.LNX.4.64.0707171328450.2467@asgard.lang.hm>
	<87fy3mg39r.fsf@jbms.ath.cx>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <87fy3mg39r.fsf@jbms.ath.cx>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Jeremy Maitin-Shepard <jbms@cmu.edu>
Cc: LKML <linux-kernel@vger.kernel.org>, Kyle Moffett <mrmacman_g4@mac.com>, Al Boldi <a1426z@gawab.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Pavel Machek <pavel@ucw.cz>, "Huang, Ying" <ying.huang@intel.com>, Andrew Morton <akpm@linux-foundation.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Tue, 17 Jul 2007, Jeremy Maitin-Shepard wrote:

> david@lang.hm writes:
>
> [snip]
>
>> this is where we disagree.
>
>> why not? if all that the hibernated kernel does is to suspend-to-ram and makes
>> no changes to disks or TCP connections anything that it does do would be lost if
>> power were to fail and you instead did a restore from disk.
>
> It would be okay to switch the "hibernated" kernel in order to
> e.g. initiate a suspend to ram provided that everything is done
> atomically with interrupts off, for instance.  It is not clear, though,
> that it is possible to suspend to ram atomically like that.

why would it neeed to be with interrupts off?

I am arguing that it wouldn't matter if the "hibernated" kernel changed 
every bit of ram, as long as it didn't change anything that would be 
visable when the ram is overwritten by the saved image.

> There is also the question of what state the devices will be in when
> switching back from the "save image" kernel to the "hibernated" kernel.

yes, this is a key factor.

if the saved image assumes that the hardware is in some ACPI mode instead 
of re-initializeing the hardware then the suspend-to-ram operation could 
leave them in a different mode.

but if the saved image doesn't make assumptions about the hardware modes 
and initializes the hardware then it shouldn't matter.

David Lang
