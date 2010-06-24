From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [update] Re: [RFC][PATCH] PM: Avoid losing wakeup
 events during suspend
Date: Thu, 24 Jun 2010 10:45:09 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1006241037080.1654-100000__42494.406985543$1277390928$gmane$org@iolanthe.rowland.org>
References: <4C2368C8.7020708@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4C2368C8.7020708@mit.edu>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Andy Lutomirski <luto@mit.edu>
Cc: mark gross <640e9920@gmail.com>, Florian Mickler <florian@mickler.org>, Neil Brown <neilb@suse.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Arve@smtp1.linux-foundation.org, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Thu, 24 Jun 2010, Andy Lutomirski wrote:

> How does userspace handle this without races?  (I don't see an example 
> in a driver that talks to userspace in your code...)
> 
> For example, if I push a button on my keyboard, the driver calls 
> pm_wakeup_begin().  Then userspace reads the key from the evdev device 
> and tells the userspace suspend manager not to go to sleep.
> 
> But there's a race: the keyboard driver (or input subsystem) could call 
> pm_wakeup_end() before the userspace program has a chance to tell the 
> suspend manager not to sleep.

The assumption is that the user program will poll the evdev device.  
When the poll indicates data is available, the program will tell the 
userspace power manager not to go to sleep before reading the data.  
This avoids the race.

> One possibility would be for poll to report that events are pending 
> without calling pm_wakeup_end(), giving userspace a chance to prevent 
> itself from suspending before actually reading the event.

Exactly.  The critical section doesn't end until the events have been 
read.  Polling alone doesn't affect the critical section.

> (Also, should "echo mem >/sys/power/state" be different from "echo 
> mem_respect_suspend_blockers >/sys/power/state?"  If I physically press 
> the suspend key on my laptop, I want it to go to sleep even though I'm 
> still holding the Fn key that was part of the suspend hotkey.)

With Rafael's scheme, the difference is not in the write to
/sys/power/state but rather in the write to /sys/power/wakeup_count.  
If the power manager program doesn't write to /sys/power/wakeup_count
first then /sys/power/state takes effect immediately, just as it does
now.

Alan Stern
