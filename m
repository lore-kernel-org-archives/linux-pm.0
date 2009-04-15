From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 1/8] PM: Add suspend block api.
Date: Wed, 15 Apr 2009 11:29:01 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0904151112400.3072-100000@iolanthe.rowland.org>
References: <1239759692-28617-2-git-send-email-arve@android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1239759692-28617-2-git-send-email-arve@android.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: =?utf-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?= <arve@android.com>
Cc: ncunningham@crca.org.au, u.luckas@road.de, swetland@google.com, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Tue, 14 Apr 2009, [utf-8] Arve Hj=C3=B8nnev=C3=A5g wrote:

> +Suspend blockers can be used to allow user-space to decide which keys sh=
ould
> +wake the full system up and turn the screen on.

This sentence still grates on me.  For readers not familiar with the =

embedded/phone environment, it won't make any sense.  Furthermore the =

rest of the text below doesn't even mention the screen, which will =

cause readers to wonder why it is mentioned here.

>  Use set_irq_wake or a platform
> +specific api to make sure the keypad interrupt wakes up the cpu. Once th=
e keypad
> +driver has resumed, the sequence of events can look like this:
> +- The Keypad driver gets an interrupt. It then calls suspend_block on the
> +  keypad-scan suspend_blocker and starts scanning the keypad matrix.
> +- The keypad-scan code detects a key change and reports it to the input-=
event
> +  driver.
> +- The input-event driver sees the key change, enqueues an event, and cal=
ls
> +  suspend_block on the input-event-queue suspend_blocker.
> +- The keypad-scan code detects that no keys are held and calls suspend_u=
nblock
> +  on the keypad-scan suspend_blocker.
> +- The user-space input-event thread returns from select/poll, calls
> +  suspend_block on the process-input-events suspend_blocker and then cal=
ls read
> +  on the input-event device.
> +- The input-event driver dequeues the key-event and, since the queue is =
now
> +  empty, it calls suspend_unblock on the input-event-queue suspend_block=
er.
> +- The user-space input-event thread returns from read. It determines tha=
t the
> +  key should not wake up the full system, calls suspend_unblock on the
> +  process-input-events suspend_blocker and calls select or poll.
> +
> +                 Key pressed   Key released
> +                     |             |
> +keypad-scan          ++++++++++++++++++
> +input-event-queue        +++          +++
> +process-input-events       +++          +++

How about replacing that first sentence with something like this:

	In cell phones or other embedded systems where powering the
	screen is a significant drain on the battery, suspend blockers =

	can be used to allow user-space to decide whether a keystroke
	received while the system is suspended should cause the screen =

	to be turned back on or allow the system to go back into =

	suspend.

Then in the last section, say this:

      - The user-space input-event thread returns from read. If it =

	determines that the key should leave the screen off, it
	calls suspend_unblock on the process_input_events
	suspend_blocker and then calls select or poll.  The system
	will automatically suspend again, since now no suspend blockers
	are active.

Alan Stern
