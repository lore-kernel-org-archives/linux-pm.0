From: Pavel Machek <pavel@ucw.cz>
Subject: Re: RFC: A proposal for power capping through forced
 idle in the Linux Kernel
Date: Wed, 23 Dec 2009 10:49:05 +0100
Message-ID: <20091223094905.GC24181__20914.7776048214$1261561892$gmane$org@elf.ucw.cz>
References: <4352991a0912141511k7f9b8b79y767c693a4ff3bc2b@mail.gmail.com>
	<20091218170407.GA1396@ucw.cz>
	<4352991a0912221310k40f42498nba2081011398c7e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4352991a0912221310k40f42498nba2081011398c7e@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Salman Qazi <sqazi@google.com>
Cc: linux-pm@lists.linux-foundation.org, Taliver Heath <taliver@google.com>, Michael Rubin <mrubin@google.com>, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Tue 2009-12-22 13:10:36, Salman Qazi wrote:
> On Fri, Dec 18, 2009 at 9:04 AM, Pavel Machek <pavel@ucw.cz> wrote:
> > Hi
> >
> >
> >> Why not use voltage and frequency scaling?
> >>
> >> Forced Idle Injection is more effective[1] and more widely available.
> >> Even with voltage and frequency scaling, interpolation is needed
> >> between the available settings.  So, if we did use voltage and
> >
> > It is only more efficient on new hardware.
> >
> > You should also explain 'why not throttling' because that is actually
> > designed for power capping.
> 
> Do you mean t-states?

Yes.

> >> Application to Laptops and Cellphones:
> >>
> >> Imagine being in a tent in Death Valley with a laptop.  You are bored,
> >> and you want to watch a movie.  However, you also want to do your best
> >> to make the battery last and watch as much of the movie as possible.
> >> Forced idle power capping is a solution.  If your machine has a knob
> >> that allows you to control the available power, you can turn that knob
> >> until your video starts getting choppy.  And then, turn the knob back
> >
> > That's bad example. Video player should already sleep between frames.
> 
> Yes, the video player should sleep.  However, there will be other
> things running.  And certainly, it is possible to cap the power and
> discriminate so that those things are prevented from running while the
> video player is allowed to run with minimal latency impact.

I don't see how it would work without much of extra setup. Lets say
your windowmanager wants to do some work, and you starve it
indefinitely?
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
