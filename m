From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC][PATCH 00/11] Android PM extensions
Date: Fri, 30 Jan 2009 10:08:59 +0100
Message-ID: <20090130090859.GA7967@atrey.karlin.mff.cuni.cz>
References: <d6200be20901142042n5aa6384al936e49f5bce8256e@mail.gmail.com>
	<Pine.LNX.4.44L0.0901151005240.2490-100000@iolanthe.rowland.org>
	<20090129130424.GA1425@ucw.cz>
	<d6200be20901291716g5b6f4542r54c2ba8672961c91@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <d6200be20901291716g5b6f4542r54c2ba8672961c91@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Arve Hj?nnev?g <arve@android.com>
Cc: swetland@google.com, Nigel Cunningham <ncunningham@crca.org.au>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

> On Thu, Jan 29, 2009 at 5:04 AM, Pavel Machek <pavel@ucw.cz> wrote:
> > AFAICT, this is something very different. It is attempt to do
> > autosuspend right. Imagine burning cd... right now you can suspend,
> > and it will just stop the burn.
> >
> > Wakelocks code allows you to tell the machine 'feel free to suspend
> > when you have nothing to do'... so the machine will burn the cd and
> > then suspend.
> >
> 
> Yes, wakelocks solves this problem, but our auto-suspend code is all
> in user-space so the kernel would not have to be involved in that
> particular example.
> 
> I added an example to the document that may help illustrate why we
> added wakelock support in the kernel:
> 
> ---
> Documentation/power/wakelocks.txt
> Wakelocks
> =========
> 
> A wakelock prevents the system from entering suspend or other low-power
> states when active. If the type is set to WAKE_LOCK_SUSPEND, the wakelock
> prevents a full system suspend. If the type is WAKE_LOCK_IDLE, low-power
> states that cause large interrupt latencies or that disable a set of
> interrupts will not be entered from idle until the wakelocks are released.
> 
> Wakelocks can be used to allow user-space to decide which keys should wake
> the system. The sequence of events can look like this:
> - The Keypad driver gets an interrupt. It then locks the keypad-scan wakelock
>   and starts scanning the keypad.
> - The keypad-scan code detects a key change and reports it to the input-event
>   driver.
> - The input-event driver sees the key change, enqueues an event, and locks
>   the input-event-queue wakelock.
> - The keypad-scan code detects that no keys are held and unlocks the
>   keypad-scan wakelock.
> - The user-space input-event thread returns from select/poll, locks the
>   process-input-events wakelock and then calls read in the input-event device.
> - The input-event driver dequeues the key-event and, since the queue is now
>   empty, it unlocks the input-event-queue wakelock.
> - The user-space input-event thread returns from read. It determines that the
>   key should not wake up the system, releases the process-input-events
>   wakelock and calls select or poll.

I don't get it. So you are running userspace while system is
suspended? 
								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
