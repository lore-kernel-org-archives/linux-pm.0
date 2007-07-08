From: david@lang.hm
Subject: Re: hibernation/snapshot design [was Re: [PATCH] Remove
 process freezer from suspend to RAM pathway]
Date: Sun, 8 Jul 2007 15:23:45 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0707081519210.25614@asgard.lang.hm>
References: <Pine.LNX.4.44L0.0707072224270.10912-100000@netrider.rowland.org>
	<200707082115.27363.rjw@sisk.pl>
	<1183928612.3388.289.camel@localhost.localdomain>
	<200707082345.27859.rjw@sisk.pl>
	<1183931688.3388.316.camel@localhost.localdomain>
	<20070708221315.GF5401@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070708221315.GF5401@elf.ucw.cz>
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
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-kernel@vger.kernel.org, Kyle Moffett <mrmacman_g4@mac.com>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Mon, 9 Jul 2007, Pavel Machek wrote:

>>> Actaully, I'm perfectly fine with that, as long as each task blocked by the
>>> driver due to suspend has PF_FROZEN (or something similar) set.  Then, at
>>> least theoretically, we'll be able to drop the freezer from the suspend code
>>> path and move it after device_suspend() (or the hibernation-specific
>>> equivalent) for hibernation (in that case there shouldn't be a problem with
>>> any task waiting on I/O while the freezer is running ;-)).
>>
>> I don't see the need for a freezer for snapshot but that's a different
>> issue. (stop_machine looks good enough to me).
>
> Freezer is not needed for snapshot -- it is needed so that we can
> write out the snapshot to disk without the need for special
> drivers/block/simple-ide-for-suspend.c. (We are doing snapshot, then
> write to disk from userland code in uswsusp).

instead of trying to freeze most of the system, could you do something 
like start a virtual machine sandbox to write the data out, and not let 
any userspace other then the sandbox operate?

you would need to throw away disk buffers so that you don't mix current 
pending I/O with I/O from the sandbox, and this would be a visable change 
for how suspend is setup, but wouldn't this work?

David Lang
