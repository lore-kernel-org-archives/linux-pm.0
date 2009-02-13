From: Uli Luckas <u.luckas@road.de>
Subject: Re: [PATCH 01/13] PM: Add wake lock api.
Date: Fri, 13 Feb 2009 17:46:42 +0100
Message-ID: <200902131746.42914.u.luckas@road.de>
References: <1233802226-23386-1-git-send-email-arve@android.com>
	<20090213142409.GA29487@bulgaria.corp.google.com>
	<20090213143730.GA27365@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090213143730.GA27365@srcf.ucam.org>
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
To: linux-pm@lists.linux-foundation.org
Cc: "ncunningham@crca.org.au" <ncunningham@crca.org.au>, Brian Swetland <swetland@google.com>
List-Id: linux-pm@vger.kernel.org

On Friday, 13. February 2009, Matthew Garrett wrote:
> On Fri, Feb 13, 2009 at 06:24:09AM -0800, Brian Swetland wrote:
> > I think the "what happens when a process crashes and its suspend
> > inhibits are released" issue still needs some thought -- if say a
> > background/service process crashes while holding a lock we want to
> > have the process be able to be restarted by init or whatnot without
> > having to wait for some other activity.  This is a real example we
> > ran into in the past -- telephony process crashes and the device
> > doesn't get back on the network until the user presses a key, an
> > alarm fires, etc.
>
> The easiest way to handle this would seem to be a multiplexing daemon
> that implements whatever policy a specific use case has. In your case
> this would do its own reference counting and then implement timeouts for
> specific applications, perhaps with some kind of acl so arbitrary apps
> can't take a lock and then fall down a well. If you've got a
> sufficiently advanced init then you'd be able to flag an application as
> being in restart state and then have the daemon hold the lock until the 
> application chooses to reacquire it or not, which seems more flexible
> than any purely kernel-based implementation.
That's racy. By the time the daemon notices that a process crashed, the kernel 
might already have triggered suspend. userspace might then be frozen before 
it can accuire the 'process restarting' lock.
I also wonder, if it is immanently racy to use userspcae communication 
(client/daemon) for suspend locks. What if the daemon is already frozen when 
a client sends a lock request request? 

Uli

-- 

------- ROAD ...the handyPC Company - - -  ) ) )

Uli Luckas
Head of Software Development

ROAD GmbH
Bennigsenstr. 14 | 12159 Berlin | Germany
fon: +49 (30) 230069 - 62 | fax: +49 (30) 230069 - 69
url: www.road.de

Amtsgericht Charlottenburg: HRB 96688 B
Managing director: Hans-Peter Constien
