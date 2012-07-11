From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: use of pm_runtime_disable() from driver probe?
Date: Wed, 11 Jul 2012 10:20:14 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1207111017010.1559-100000@iolanthe.rowland.org>
References: <201207110031.06662.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201207110031.06662.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Kevin Hilman <khilman@ti.com>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Wed, 11 Jul 2012, Rafael J. Wysocki wrote:

> > This opens up the possibility of calling probe while a runtime resume
> > or suspend is in progress.  (On the other hand, the existing code
> > doesn't prevent a concurrent runtime resume.)  Maybe it would be best
> > to leave the pm_runtime_barrier().
> 
> That wouldn't close the race, though, because the suspend/resume may still
> be started right after _barrier has returned.

True, but see below.

> The race is only possible if runtime PM is enabled by a subsystem or PM domain
> code before the first eligible driver is registered and if that code is not
> careful enough to get ready for driver registration.  I'm not sure how likely
> it is to happen in practice.

It's not just the first eligible driver.  Drivers can be bound and 
unbound dynamically, and suspends/resume operations can sit on the wait 
queue or wait until a timer expires.  We don't want an old request 
suddenly to take effect in the middle of a probe.

The barrier will get rid of any old requests.  New ones would have to 
be added after the probe starts, which as you say, is unlikely.

Alan Stern
