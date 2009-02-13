From: Brian Swetland <swetland@google.com>
Subject: Re: [PATCH 01/13] PM: Add wake lock api.
Date: Fri, 13 Feb 2009 06:46:58 -0800
Message-ID: <20090213144658.GA29631@bulgaria.corp.google.com>
References: <1233802226-23386-1-git-send-email-arve@android.com>
	<13B9B4C6EF24D648824FF11BE89671620377169672@dlee02.ent.ti.com>
	<20090213011035.GA8664@srcf.ucam.org>
	<200902131155.07530.u.luckas@road.de>
	<20090213140654.GC26549@srcf.ucam.org>
	<20090213142409.GA29487@bulgaria.corp.google.com>
	<20090213143730.GA27365@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20090213143730.GA27365@srcf.ucam.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-pm@lists.linux-foundation.org, Uli Luckas <u.luckas@road.de>, "ncunningham@crca.org.au" <ncunningham@crca.org.au>
List-Id: linux-pm@vger.kernel.org

[Matthew Garrett <mjg59@srcf.ucam.org>]
> On Fri, Feb 13, 2009 at 06:24:09AM -0800, Brian Swetland wrote:
> 
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

It'd be nice to not have to indirect all userspace suspend inhibits.
If we had the device interface to userspace actually have INHIBIT
and STOP_INHIBIT ops, we could notice if the fd is closed without
actually returning the state to STOP_INHIBIT cleanly.  Add a mechanism
for waiting until somebody exits unexpectedly that init or your monitor
process could use, you avoid the indirection and have a mechanism for
handing over to whatever is responsible for restarting something that's
in an unhappy state.  Too convoluted?

Brian
