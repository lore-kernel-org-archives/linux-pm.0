From: mark gross <mgross@linux.intel.com>
Subject: Re: [PATCH 1/8] PM: Add suspend block api.
Date: Wed, 15 Apr 2009 12:08:11 -0700
Message-ID: <20090415190811.GB3679@linux.intel.com>
References: <1239759692-28617-2-git-send-email-arve@android.com>
	<Pine.LNX.4.44L0.0904151112400.3072-100000@iolanthe.rowland.org>
Reply-To: mgross@linux.intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0904151112400.3072-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: ncunningham@crca.org.au, u.luckas@road.de, swetland@google.com, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Apr 15, 2009 at 11:29:01AM -0400, Alan Stern wrote:
> On Tue, 14 Apr 2009, [utf-8] Arve Hj=C3=B8nnev=C3=A5g wrote:
> =

> > +Suspend blockers can be used to allow user-space to decide which keys =
should
> > +wake the full system up and turn the screen on.
> =

> This sentence still grates on me.  For readers not familiar with the =

> embedded/phone environment, it won't make any sense.  Furthermore the =

> rest of the text below doesn't even mention the screen, which will =

> cause readers to wonder why it is mentioned here.
> =

> >  Use set_irq_wake or a platform
> > +specific api to make sure the keypad interrupt wakes up the cpu. Once =
the keypad
> > +driver has resumed, the sequence of events can look like this:
> > +- The Keypad driver gets an interrupt. It then calls suspend_block on =
the
> > +  keypad-scan suspend_blocker and starts scanning the keypad matrix.
> > +- The keypad-scan code detects a key change and reports it to the inpu=
t-event
> > +  driver.
> > +- The input-event driver sees the key change, enqueues an event, and c=
alls
> > +  suspend_block on the input-event-queue suspend_blocker.
> > +- The keypad-scan code detects that no keys are held and calls suspend=
_unblock
> > +  on the keypad-scan suspend_blocker.
> > +- The user-space input-event thread returns from select/poll, calls
> > +  suspend_block on the process-input-events suspend_blocker and then c=
alls read
> > +  on the input-event device.
> > +- The input-event driver dequeues the key-event and, since the queue i=
s now
> > +  empty, it calls suspend_unblock on the input-event-queue suspend_blo=
cker.
> > +- The user-space input-event thread returns from read. It determines t=
hat the
> > +  key should not wake up the full system, calls suspend_unblock on the
> > +  process-input-events suspend_blocker and calls select or poll.
> > +
> > +                 Key pressed   Key released
> > +                     |             |
> > +keypad-scan          ++++++++++++++++++
> > +input-event-queue        +++          +++
> > +process-input-events       +++          +++
> =

> How about replacing that first sentence with something like this:
> =

> 	In cell phones or other embedded systems where powering the
> 	screen is a significant drain on the battery, suspend blockers =

> 	can be used to allow user-space to decide whether a keystroke
> 	received while the system is suspended should cause the screen =

> 	to be turned back on or allow the system to go back into =

> 	suspend.
> =

> Then in the last section, say this:
> =

>       - The user-space input-event thread returns from read. If it =

> 	determines that the key should leave the screen off, it
> 	calls suspend_unblock on the process_input_events
> 	suspend_blocker and then calls select or poll.  The system
> 	will automatically suspend again, since now no suspend blockers
> 	are active.

I'm still re-reviewing the design so I probably should keep my mouth
shut, but I only see code for constraining entry into suspend state (S3
if you will)  I didn't see code that would get called to block device
entry into higher power states just constraints on entire system entry
into sleep state.  (I apologize if I missed that code and will happily
eat my words if needed.)

more comments after I finish looking over the code.

--mgross

 =
