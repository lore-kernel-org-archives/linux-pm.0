From: Brian Swetland <swetland@google.com>
Subject: Re: [PATCH 01/13] PM: Add wake lock api.
Date: Fri, 13 Feb 2009 06:24:09 -0800
Message-ID: <20090213142409.GA29487@bulgaria.corp.google.com>
References: <1233802226-23386-1-git-send-email-arve@android.com>
	<13B9B4C6EF24D648824FF11BE89671620377169672@dlee02.ent.ti.com>
	<20090213011035.GA8664@srcf.ucam.org>
	<200902131155.07530.u.luckas@road.de>
	<20090213140654.GC26549@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20090213140654.GC26549@srcf.ucam.org>
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
> 
> Ok, so let's think about this differently. What we want is simply for 
> drivers to be able to block an automatic suspend. For performance 
> reasons we want to keep track of this state without calling into the 
> entire driver tree. Now that the userspace API can automatically clean 
> up after itself, why is this not just a simple counter? Kernel API would 
> be something like:
> 
> (input arrives)
> inhibit_suspend();
> (input queue is emptied)
> uninhibit_suspend();
> 
> perhaps using the device struct or something as a token for debug 
> purposes. Userland ABI would then be a single /dev/inhibit_suspend, 
> with the counter being bumped each time an application opens it. It'll 
> automatically be dropped if the application exits without cleaning up.
> 
> This seems simpler and also avoids any arguments about the naming 
> scheme. What am I missing?

If we can enable keeping stats (probably as a config option that
defaults off) to help answer the "battery life is down 20% in this
build, are we preventing suspend more than before?" question, this
seems like a reasonable direction to me.

For the case where somebody wants to release the hold on suspend after a
timer expiration, that can be built on top of this, so that's covered.

I think the "what happens when a process crashes and its suspend
inhibits are released" issue still needs some thought -- if say a
background/service process crashes while holding a lock we want to
have the process be able to be restarted by init or whatnot without
having to wait for some other activity.  This is a real example we
ran into in the past -- telephony process crashes and the device 
doesn't get back on the network until the user presses a key, an 
alarm fires, etc.

I suspect this is more sparse than Arve is hoping for, and maybe
I've missed some obvious concern he has. 

Brian
