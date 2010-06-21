From: Florian Mickler <florian@mickler.org>
Subject: Re: [RFC][PATCH] PM: Avoid losing wakeup events during
	suspend
Date: Mon, 21 Jun 2010 14:39:50 +0200
Message-ID: <20100621143950.7594fd33__36980.801591608$1277124075$gmane$org@schatten.dmk.lab>
References: <20100620225810.GB9735@gvim.org>
	<Pine.LNX.4.44L0.1006202223440.29532-100000@netrider.rowland.org>
	<20100621055522.GE9735@gvim.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100621055522.GE9735@gvim.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: markgross@thegnar.org
Cc: 640e9920@gmail.com, Neil Brown <neilb@suse.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Matthew@smtp1.linux-foundation.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Sun, 20 Jun 2010 22:55:22 -0700
mark gross <640e9920@gmail.com> wrote:

> On Sun, Jun 20, 2010 at 10:33:01PM -0400, Alan Stern wrote:
> > On Sun, 20 Jun 2010, mark gross wrote:
> > > > In what way is this better than suspend blockers?
> > > 
> > > 1) I don't think suspend blockers really solve or effectively articulate
> > > the suspend wake event race problem.
> > 
> > Why not?
> 
> For starters the suspend block patch is about suspend blocking, at least
> at first before competing ideas starting coming out and this race issue
> was offered up as an excuse to not consider the alternative ideas, then
> suddenly suspend blocking became a wake event notification mechanism
> implementation that was baked into the implementation.  The arguments
> are still a blur and irritating to recall / look up again.

I really can't follow you here. Userspace and kernelspace actively
blocking suspend when necessary guarantees that the race is won by the
right party. I.e. the race problem is solved.

You can view it as a wake event notification if you want. But that's
just another point of view. 

> 
> But, the point I'm trying to make is that wake event serialization /
> event handling suddenly became a big FUD-pie tightly bound to a specific
> feature for suspend blocking (or was is auto suspending?  Its a magical
> solution to all the PM problems in the kernel.  I'm being sarcastic.)  
> 
> Its much better to call out the issue and provide a clean targeted
> solution to it without binding it to some other solution to a different
> problem.

See my other mail in response to Alan Stern. In the case of a
userspace-suspend-manager, if we just use this wake-event-counting
mechanism, we have to make shure userspace get's scheduled and notifies
the suspend-manager with an 'all clear' before it suspends the machine.

Else it can happen for the userspace-manager to suspend before
userspace could notify the userspace-manager to not suspend.

Cheers,
Flo
