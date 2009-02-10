From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 01/13] PM: Add wake lock api.
Date: Tue, 10 Feb 2009 21:25:07 +0100
Message-ID: <20090210202507.GE1382@ucw.cz>
References: <1233802226-23386-1-git-send-email-arve@android.com>
	<1233802226-23386-2-git-send-email-arve@android.com>
	<20090205225158.GA19577@linux.intel.com>
	<d6200be20902051613k77ef5878v7734653749ead8a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <d6200be20902051613k77ef5878v7734653749ead8a@mail.gmail.com>
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
Cc: swetland@google.com, linux-pm@lists.linux-foundation.org, u.luckas@road.de, ncunningham@crca.org.au
List-Id: linux-pm@vger.kernel.org

On Thu 2009-02-05 16:13:27, Arve Hj?nnev?g wrote:
> On Thu, Feb 5, 2009 at 2:51 PM, mark gross <mgross@linux.intel.com> wrote:
> >> +A locked wakelock, depending on its type, prevents the system from entering
> >> +suspend or other low-power states. When creating a wakelock, you can select
> >> +if it prevents suspend or low-power idle states.  If the type is set to
> >> +WAKE_LOCK_SUSPEND, the wakelock prevents a full system suspend. If the type
> >> +is WAKE_LOCK_IDLE, low-power states that cause large interrupt latencies, or
> >> +that disable a set of interrupts, will not be entered from idle until the
> >> +wakelocks are released. Unless the type is specified, this document refers
> >> +to wakelocks with the type set to WAKE_LOCK_SUSPEND.
> >
> > How much of this can be implemented using a pm-qos approach?
> 
> WAKE_LOCK_IDLE overlaps with pm-qos, if you use it to prevent latency.

Yes. So pleaase remove wake_lock_idle and use pm-qos. Feel free to
improve pm-qos if you need to.

> > wake_lock going to block until the dives its locking is in a good power
> > state?  (I'm guessing yes) Is doing this in the context of and IRQ a
> > good idea?
> 
> wake_lock never blocks.

Wakelock is really bad name: it is not a lock and it does not protect
wake. I'd say we need better name here.
-- 

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
