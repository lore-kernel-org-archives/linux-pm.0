From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 01/13] PM: Add wake lock api.
Date: Fri, 13 Feb 2009 15:07:23 +0000
Message-ID: <20090213150723.GA28042@srcf.ucam.org>
References: <1233802226-23386-1-git-send-email-arve@android.com>
	<13B9B4C6EF24D648824FF11BE89671620377169672@dlee02.ent.ti.com>
	<20090213011035.GA8664@srcf.ucam.org>
	<200902131155.07530.u.luckas@road.de>
	<20090213140654.GC26549@srcf.ucam.org>
	<20090213142409.GA29487@bulgaria.corp.google.com>
	<20090213143730.GA27365@srcf.ucam.org>
	<20090213144658.GA29631@bulgaria.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20090213144658.GA29631@bulgaria.corp.google.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Brian Swetland <swetland@google.com>
Cc: linux-pm@lists.linux-foundation.org, Uli Luckas <u.luckas@road.de>, "ncunningham@crca.org.au" <ncunningham@crca.org.au>
List-Id: linux-pm@vger.kernel.org

On Fri, Feb 13, 2009 at 06:46:58AM -0800, Brian Swetland wrote:
> [Matthew Garrett <mjg59@srcf.ucam.org>]
> > The easiest way to handle this would seem to be a multiplexing daemon 
> > that implements whatever policy a specific use case has. In your case 
> > this would do its own reference counting and then implement timeouts for 
> > specific applications, perhaps with some kind of acl so arbitrary apps 
> > can't take a lock and then fall down a well. If you've got a 
> > sufficiently advanced init then you'd be able to flag an application as 
> > being in restart state and then have the daemon hold the lock until the 
> > application chooses to reacquire it or not, which seems more flexible 
> > than any purely kernel-based implementation.
> 
> It'd be nice to not have to indirect all userspace suspend inhibits.
> If we had the device interface to userspace actually have INHIBIT
> and STOP_INHIBIT ops, we could notice if the fd is closed without
> actually returning the state to STOP_INHIBIT cleanly.  Add a mechanism
> for waiting until somebody exits unexpectedly that init or your monitor
> process could use, you avoid the indirection and have a mechanism for
> handing over to whatever is responsible for restarting something that's
> in an unhappy state.  Too convoluted?

Mm. How do you guarantee a timely handover? Doing it in userland means 
that you can adapt it to work with whatever process restart setup you 
have, whereas doing it in kernel means adapting whatever process restart 
setup you have to the kernel. I'd still lean towards thinking that the 
userland approach means you can have tighter integration with the rest 
of your stack.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
