From: "Ted Ts'o" <tytso@mit.edu>
Subject: Re: Attempted summary of suspend-blockers LKML thread,
	take three
Date: Wed, 11 Aug 2010 15:31:06 -0400
Message-ID: <20100811193106.GB24435__16114.8384133869$1281555220$gmane$org@thunk.org>
References: <20100806225453.GA3947@linux.vnet.ibm.com>
	<alpine.DEB.2.00.1008061651530.30564@asgard.lang.hm>
	<AANLkTikyRhtfX4R3x_NDgHnXssmfVuhjC5PbhRZ0a7su@mail.gmail.com>
	<alpine.DEB.2.00.1008062010510.30564@asgard.lang.hm>
	<20100807061558.GA28087@thunk.org>
	<AANLkTi=sMVjya9CH6UoZwJCXJTDRgBhnPXmApU_RHVTi@mail.gmail.com>
	<20100808155719.GB3635@thunk.org>
	<AANLkTinM5e2HGOFavODPZNzZx4KshDSjsvKN4pLpGGgr@mail.gmail.com>
	<20100808213821.GD3635@thunk.org>
	<AANLkTinNc1SWmz8pE_4k6vThxQCJfCR_UqV6OM=OsJOf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <AANLkTinNc1SWmz8pE_4k6vThxQCJfCR_UqV6OM=OsJOf@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: david@lang.hm, peterz@infradead.org, Brian Swetland <swetland@google.com>, linux-kernel@vger.kernel.org, James.Bottomley@suse.de, galibert@pobox.com, florian@mickler.org, menage@google.com, swmike@swm.pp.se, linux-pm@lists.linux-foundation.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, tglx@linutronix.de, alan@lxorguk.ukuu.org.uk, arjan@infradead.org
List-Id: linux-pm@vger.kernel.org

On Wed, Aug 11, 2010 at 07:57:32PM +0300, Felipe Contreras wrote:
> Let's concentrate; Android is the only mobile platform that has
> expressed interested in suspend blockers. UI applications in Android
> are written specifically for Android. Period.
> 
> Other platforms, such as MeeGo, rely on Qt API, not suspend blockers.

I think you're wrong that this will be sufficient, but I've already
stated my position before, namely that what you do when you only have
800mWh has very different performance/battery tradeoffs than when you
have 94,000mWh batteries.  One of the reasons why my mail archive for
this discussion has over 1800 messages and is close to 10MB is that
everyone keeps saying the same thing over and over again.  So I'm not
going to say it again.

I was thinking that the only way we can tell is for us to go away and
come back in two years, and we can see whether or not Meego is getting
the same 200,000 activations per day that Android is, and maybe *then*
people will understand.

However, earlier today, I had a very productive conversation with an
engineer from Nokia who has had many years of experience of doing
power management for cell phones, and who is now trying to make Meego
power efficient enough for cell phones, and he seemed to think that
problem which suspend blockers or wakelocks are trying to solve was
valid.

I now believe that part of the problem is that is that many Meego
folks only have an experience with Netbooks or Laptops, and don't
appreciate that sometimes, when you make such a radical change in
battery capacity to a mobile handset, things become qualitatively
different, and not just quantitatively different.  Put another way, a
laptop has six hours of battery lifetime with 94,000 mWh worth of
battery; a cell phone needs to be able to be usable over a 20-24 hour
period of despite having a 800-1200 mWh battery --- and what you need
do for these two are different.

This is very similar to how trying to make a kernel scale to 512 NUMA
nodes is quite different to trying make a kernel work with 4-8 SMP
cpu's.  Until you've actually tried doing it, you might think that all
you have to do is just throw in a bunch of spinlocks and rw spinlocks.
But it turns out it's a lot harder than that --- but it's very hard to
convince someone who hasn't had that experience to understand why that
is true.

So it may very well be that we should just agree to disagree, and if
there are one or more Nokia engineers who are interested in doing
something that would help their cell phones (I will let them speak up
and clarify their positions for themselves), that they work directly
with those who agree that there _is_ a problem.

At that point, we can either keep these patches out of tree, much like
how the SGI Altix has patches that are needed so that the Linux kernel
scales enough so it will even successfully complete its kernel
initialization successfully.  Or if there is consensus between people
who are interested at Linaro (if any), Nokia (if any), and Android (if
any), maybe we take this directly to Linus, and he can say yes or no.

But for those who are unwilling to believe it isn't even a problem, I
don't know that another 2000 e-mail messages, and another 10MB of mail
archives, is going to achieve anything.  Let's just agree to disagree.

	     	      	      		       	    - Ted

P.S.  Just to make it clear, I am speaking only for myself, and not
for the Android team and not for Google in any way, shape, or form.
Nor was the person from Nokia who expressed to me his opinions was not
necessarily expressing the opinions of Nokia or (obviously) Meego.
