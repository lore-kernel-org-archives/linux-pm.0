From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFD] Automatic suspend
Date: Tue, 17 Feb 2009 00:08:27 +0100
Message-ID: <200902170008.31054.rjw__49603.9842990742$1234825857$gmane$org@sisk.pl>
References: <f73f7ab80902161208h12837d4ex1d28d55d031d5d71@mail.gmail.com>
	<20090216135204.064f553b@infradead.org>
	<13B9B4C6EF24D648824FF11BE896716203771DD01B@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <13B9B4C6EF24D648824FF11BE896716203771DD01B@dlee02.ent.ti.com>
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
To: "Woodruff, Richard" <r-woodruff2@ti.com>
Cc: Kyle Moffett <kyle@moffetthome.net>, Nigel Cunningham <nigel@nigel.suspend2.net>, LKML <linux-kernel@vger.kernel.org>, Arve@smtp1.linux-foundation.org, Uli Luckas <u.luckas@road.de>, Brian Swetland <swetland@google.com>, pm list <linux-pm@lists.linux-foundation.org>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Monday 16 February 2009, Woodruff, Richard wrote:
> 
> > From: Arjan van de Ven [mailto:arjan@infradead.org]
> > Sent: Monday, February 16, 2009 3:52 PM
> > On Mon, 16 Feb 2009 15:32:06 -0600
> > "Woodruff, Richard" <r-woodruff2@ti.com> wrote:
> > >
> > > - It provides a way to handle overdrive/turbo operating points out of
> > > band from the generically tuned cpufreq governors like ondemand.  The
> > > way we characterize overdrive is stricter then what Intel has talked
> > > about for x86.
> >
> > if you have an improved-for-your-systems governor then I'm sure that is
> > very welcome in the kernel.
> 
> No, the generic governors were not substantially improved. Not every customer is using cpufreq for DVFS. As such we went underneath it. If we had more community presence at the start time we might have also tried that.
> 
> > I think just about all of us agree that the final decision needs to be
> > in the driver (possibly followed by something that gets various device
> > requests and combines it into hw settings); we're just talking about
> > what inputs feed into that decision ;)
> >
> > And for different types of devices that's guaranteed to be different...
> > and sometimes we'll be hampered by existing interfaces, so we might end
> > up with hacky stuff.
> 
> Is there some kind of roadmap which can be plotted which goes from course to more granular control?
> 
> Phase 1 (all or nothing): like wakelocks (minus back light):
> system-auto-suspend-on, system-auto-suspend-off.  The drivers can still veto
> as they do today.
> 
> Phase 2: Subsystem generic tunable, on say latency + bandwidth. Start with
> CPU then move to classes like USB.
> 
> Phase 3: ??? if needed add direct device control, hints on an extended
> fadvise(), and explicit control left to open/close and direct ioctls?
> 
> I don't know that 1,2,3 above even make sense.

I'd like to talk about this. 

Phase 1: I agree that system-auto-suspend-on, system-auto-suspend-off would be
useful, but I don't like the wakelocks interface.  Do you think there is an
alternative way/mechanism of doing this?

Phase 2: I'm not sure.  We may want to introduce such things for various
subsystems in parallel (eg. USB already has such things).

Phase 3: Probably explicit control left to open/close.

> However, the notion of actually plotting out a course with goals does as it
> will take a long time and it is good to get some benefit along the way.

Agreed.

Thanks,
Rafael
