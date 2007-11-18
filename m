From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: apm emulation driver broken ?
Date: Sun, 18 Nov 2007 23:22:40 +0100
Message-ID: <200711182322.41354.rjw__13326.7902340323$1195423586$gmane$org@sisk.pl>
References: <cda58cb80711160706l2cfac2b1p81c7a1090f228f2e@mail.gmail.com>
	<200711171346.51363.rjw@sisk.pl> <4740992D.9030906@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4740992D.9030906@gmail.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Franck Bui-Huu <vagabon.xyz@gmail.com>
Cc: linux-pm@lists.linux-foundation.org, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Sunday, 18 of November 2007, Franck Bui-Huu wrote:
> Rafael J. Wysocki wrote:
> > On Saturday, 17 of November 2007, Franck Bui-Huu wrote:
> >> ok so now we agreed on this point, can we assert that a user
> >> land thread waiting for an event in an UNINTERRUPTIBLE state
> >> will prevent a suspend to happen ?
> > 
> > Yes.
> > 
> 
> So this driver seems really broken and actually I'm wondering if
> it's used by anyone...

Well, it doesn't seem so.

> See the call to wait_even() made by apm_ioctl(). If any processes
> run this, it will prevent the system to suspend...

True, but does it actually happen in practice?

> And no, I don't know why call wait_event() is called.

I hope somebody knows. :-)

At this point the second branch of the "if (as->suspend_state == SUSPEND_READ)"
can be fixed by replacing wait_event_interruptible() with
wait_event_freezable(), but the fix for the first branch depends on whether or
not the wait_event() is really necessary.

If it can be replaced with an interruptible sleep, we can use
wait_event_freezable() in this case too.  Otherwise, the only woking fix would
be to reintroduce the PF_NOFREEZE in there.

Honestly, I'm leaning towards replacing wait_event() in apm_ioctl() with
wait_event_freezable() and seeing what happens ...

Greetings,
Rafael
