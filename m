From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 0/8] Suspend block api (version 8)
Date: Fri, 28 May 2010 10:07:26 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1005281006410.1939-100000__36430.4977505983$1275055749$gmane$org@iolanthe.rowland.org>
References: <20100528101755.7b5f6b8a@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100528101755.7b5f6b8a@lxorguk.ukuu.org.uk>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Peter Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, felipe.balbi@nokia.com
List-Id: linux-pm@vger.kernel.org

On Fri, 28 May 2010, Alan Cox wrote:

> > Since I think we've now rejected the feature, do we have a clear picture about
> > what the Android people should do _instead_ and yet keep the battery life they
> > want?  Because I don't think telling "let them do what they want, who cares"
> > is right.
> 
> Today "idle" means "no task running"
> 
> If you are prepared to rephrase that as "no task that matters is running"
> what would need to answer ?
> 
> - How do we define who matters: QoS ?

Here are the deficiencies in the current PM-QOS implementation which 
would need to be solved for Android's purposes:

	The system includes parameters for latency and throughput.
	It does not include a parameter to describe whether timers
	are enabled.  The presumption is that timers are always
	enabled.

For example, the low-power state used by Android would be described as
one in which the CPU does not run and timers are disabled, with some
appropriate latencies and zero throughput.  On some platforms even some
interrupt sources are disabled (those not marked as wakeup-enabled).

	There's no way to indicate minimum system operating 
	requirements.

For example, we may know that work needs to be done without knowing 
specifically which processes are going to carry out that work.  In such 
cases we would like to require that the CPU continues to run at a 
certain minimum speed so long as _any_ threads are runnable, even if 
those threads don't have any QOS requirements of their own.

Similarly, the requirement that timers be enabled is a system-wide sort 
of thing, not necessarily applying to a particular thread (and in fact, 
not all timers are associated with a thread anyway).

	There's no way to boost the minimum system operating
	requirements upon the arrival of an event.

For example, when an input event enters the queue, it should be
possible to prevent the system from entering its lowest power state
until the event can be consumed by userspace.  Simply boosting the QOS
requirements of the threads waiting on the input queue isn't good
enough, because there may not be any such threads when the event occurs 
(they may be busy doing something else).

The matter of _which_ events should boost the system operating
requirements is debatable.  In the Android proposal it is a fixed set:
those events which enable a suspend blocker.  In theory it could
instead be determined by requests from userspace, although I don't know
how such requests would be expressed.


Until these weaknesses are rectified, Android cannot use the PM-QOS 
system or idle-time power management to satisfy its needs.  That's why 
they have to resort to forced suspends.

Can the PM-QOS framework be enhanced to include these considerations?  
I don't see why not (but on the other hand, I know nothing about its
internal workings).

Alan Stern
