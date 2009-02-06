From: mark gross <mgross@linux.intel.com>
Subject: Re: [PATCH 01/13] PM: Add wake lock api.
Date: Thu, 5 Feb 2009 17:32:00 -0800
Message-ID: <20090206013200.GF19577@linux.intel.com>
References: <1233802226-23386-1-git-send-email-arve@android.com>
	<1233802226-23386-2-git-send-email-arve@android.com>
	<20090205091132.GG2077@elf.ucw.cz>
Reply-To: mgross@linux.intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20090205091132.GG2077@elf.ucw.cz>
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
Cc: swetland@google.com, u.luckas@road.de, ncunningham@crca.org.au, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Thu, Feb 05, 2009 at 10:11:32AM +0100, Pavel Machek wrote:
> On Wed 2009-02-04 18:50:14, Arve Hj??nnev??g wrote:
> > Signed-off-by: Arve Hj??nnev??g <arve@android.com>
> > ---
> >  Documentation/power/wakelocks.txt |   91 ++++++++++++++++++++++++++++++++++++
> >  include/linux/wakelock.h          |   92 +++++++++++++++++++++++++++++++++++++
> >  2 files changed, 183 insertions(+), 0 deletions(-)
> >  create mode 100644 Documentation/power/wakelocks.txt
> >  create mode 100755 include/linux/wakelock.h
> > 
> > diff --git a/Documentation/power/wakelocks.txt b/Documentation/power/wakelocks.txt
> > new file mode 100644
> > index 0000000..219bb11
> > --- /dev/null
> > +++ b/Documentation/power/wakelocks.txt
> > @@ -0,0 +1,91 @@
> > +Wakelocks
> > +=========
> > +
> > +A locked wakelock, depending on its type, prevents the system from entering
> > +suspend or other low-power states. When creating a wakelock, you can select
> > +if it prevents suspend or low-power idle states.  If the type is
> > set to
> 
> idle states are very different from suspend. Mixing them does not look
> like good idea... and IIRC we already have API somewhere to prevent
> deep idle states. Intel did it for their wireless cards IIRC.

PM QOS does this.

> 
> 
> > +If the suspend operation has already started when locking a wakelock, it will
> > +abort the suspend operation as long it has not already reached the suspend_late
> > +stage. This means that locking a wakelock from an interrupt handler or a
> > +freezeable thread always works, but if you lock a wakelock from a suspend_late
> > +handler you must also return an error from that handler to abort suspend.
> > +
> > +Wakelocks can be used to allow user-space to decide which keys should wake the
> > +full system up and turn the screen on. Use set_irq_wake or a platform specific
> > +api to make sure the keypad interrupt wakes up the cpu. Once the keypad driver
> > +has resumed, the sequence of events can look like this:
> > +- The Keypad driver gets an interrupt. It then locks the keypad-scan wakelock
> > +  and starts scanning the keypad matrix.
> > +- The keypad-scan code detects a key change and reports it to the input-event
> > +  driver.
> > +- The input-event driver sees the key change, enqueues an event, and locks
> > +  the input-event-queue wakelock.
> > +- The keypad-scan code detects that no keys are held and unlocks the
> > +  keypad-scan wakelock.
> > +- The user-space input-event thread returns from select/poll, locks the
> > +  process-input-events wakelock and then calls read in the input-event device.
> > +- The input-event driver dequeues the key-event and, since the queue is now
> > +  empty, it unlocks the input-event-queue wakelock.
> > +- The user-space input-event thread returns from read. It determines that the
> > +  key should not wake up the full system, releases the process-input-events
> > +  wakelock and calls select or poll.
> > +
> > +                 Key pressed   Key released
> > +                     |             |
> > +keypad-scan          ++++++++++++++++++
> > +input-event-queue        +++          +++
> > +process-input-events       +++          +++
> > +
> 
> I'm not sure if keyboard scanning example is good here. It is very
> t-mobile G1 specific.
> 								Pavel
> -- 
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
> _______________________________________________
> linux-pm mailing list
> linux-pm@lists.linux-foundation.org
> https://lists.linux-foundation.org/mailman/listinfo/linux-pm
