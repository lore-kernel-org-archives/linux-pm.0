From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFD] Automatic suspend
Date: Thu, 19 Feb 2009 17:08:20 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0902191659020.7953-100000__28207.1460191675$1235082272$gmane$org@iolanthe.rowland.org>
References: <200902192215.18365.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200902192215.18365.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Kyle Moffett <kyle@moffetthome.net>, Uli Luckas <u.luckas@road.de>, LKML <linux-kernel@vger.kernel.org>, Nigel Cunningham <nigel@nigel.suspend2.net>, Brian Swetland <swetland@google.com>, pm list <linux-pm@lists.linux-foundation.org>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Thu, 19 Feb 2009, Rafael J. Wysocki wrote:

> > > Again, the decision to trigger automatic suspend has to be based on some
> > > well defined criteria and the (in)activity of devices seems to be one of them.
> > 
> > I don't know what criteria the system monitor would use.
> 
> I don't know either and this is the whole point.  They need to be specified
> somehow and I'm not sure if "we suspend if no one is holding a wakelock" is the
> right approach.

That isn't really a criterion; it's just a mechanism.  All it does is
push the problem back one level.  Now the question becomes: When is it
appropriate/necessary to hold a wakelock?

> > It might have to be platform-specific.  The Android people seem to have a
> > pretty good idea of what criteria will work for them.
> 
> I'd really like to know in what situations Androind is supposed to suspend
> automatically.

It might be better to ask in what situations Android is _not_ supposed
to sleep automatically.  In other words, in what situations is a
wakelock acquired?  Since the whole system is only a phone, this
question should have a reasonably well-defined answer.

> > Inactivity of devices isn't always a good criterion.  There might be a
> > background task which wakes up every few seconds to do something as
> > long as the system is awake, thereby keeping some device always active.  
> > The activity from this background task shouldn't prevent an auto-sleep.
> 
> In fact there are two problems here.  First, there may be a task preventing
> some devices from becoming inactive (like syslog).

Which means that device inactivity isn't always a good indicator for
auto-sleep.  (But then there can be different levels of activity: A
disk should always block auto-sleep while it is carrying out I/O, but
it might not block auto-sleep just because it is spinning.)

>  Second, there may be
> a task waiting for something important to happen, such that automatic suspend
> cannot be triggered while it's waiting.  In both cases, IMO, the kernel is not
> in a point to decide whether to suspend or not, because the user space knows
> better.

That's the whole point behind userspace wakelocks!  They provide a
mechanism for userspace to tell the kernel when (as far as userspace is
concerned) it is or is not okay to auto-sleep.

Alan Stern
