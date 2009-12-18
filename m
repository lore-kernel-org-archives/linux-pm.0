From: Pavel Machek <pavel@ucw.cz>
Subject: Re: RFC: A proposal for power capping through forced
	idle in the	Linux Kernel
Date: Fri, 18 Dec 2009 18:04:07 +0100
Message-ID: <20091218170407.GA1396__6625.27825120396$1261156016$gmane$org@ucw.cz>
References: <4352991a0912141511k7f9b8b79y767c693a4ff3bc2b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4352991a0912141511k7f9b8b79y767c693a4ff3bc2b@mail.gmail.com>
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

Hi


> Why not use voltage and frequency scaling?
> 
> Forced Idle Injection is more effective[1] and more widely available.
> Even with voltage and frequency scaling, interpolation is needed
> between the available settings.  So, if we did use voltage and

It is only more efficient on new hardware.

You should also explain 'why not throttling' because that is actually
designed for power capping. 

> Application to Laptops and Cellphones:
> 
> Imagine being in a tent in Death Valley with a laptop.  You are bored,
> and you want to watch a movie.  However, you also want to do your best
> to make the battery last and watch as much of the movie as possible.
> Forced idle power capping is a solution.  If your machine has a knob
> that allows you to control the available power, you can turn that knob
> until your video starts getting choppy.  And then, turn the knob back

That's bad example. Video player should already sleep between frames.

Better example would be 'make video so choppy that expected battery
time rises over length ov movie.

(And yes, this would have been useful for me on notebook with failed
fan and ineffective throttling).


								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
