From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: Attempted summary of suspend-blockers LKML thread
Date: Wed, 4 Aug 2010 13:51:59 -0700
Message-ID: <20100804205159.GH24163__42364.9375130937$1280955270$gmane$org@linux.vnet.ibm.com>
References: <20100801054816.GI2470@linux.vnet.ibm.com>
	<20100731230101.7cc1d8c7@infradead.org>
	<20100801191228.GL2470@linux.vnet.ibm.com>
	<20100801154708.19817b75@infradead.org>
	<20100802011006.GS2470@linux.vnet.ibm.com>
	<AANLkTi=a-1hn_oL=i-=RKK9xOur+4mQjTRut+aiXtYkE@mail.gmail.com>
	<20100803183447.0275c134@infradead.org>
	<20100804163216.GB24163@linux.vnet.ibm.com>
	<20100804163509.GA31523@srcf.ucam.org>
	<20100804204208.GA21452@elf.ucw.cz>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20100804204208.GA21452@elf.ucw.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>
Cc: peterz@infradead.org, swetland@google.com, linux-kernel@vger.kernel.org, florian@mickler.org, linux-pm@lists.linux-foundation.org, tglx@linutronix.de, alan@lxorguk.ukuu.org.uk, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Aug 04, 2010 at 10:42:08PM +0200, Pavel Machek wrote:
> Hi!
> 
> > > If this doesn't work for the Android folks for whatever reason, another
> > > approach would be to do the freeze in user code, which could track
> > > whether any user-level resources (pthread mutexes, SysV semas, whatever)
> > > where held, and do the freeze on a thread-by-thread basis within each
> > > "victim" application as the threads reach safe points.
> > 
> > The main problem I see with the cgroups solution is that it doesn't seem 
> > to do anything to handle avoiding loss of wakeup events.
> 
> In different message, Arve said they are actually using low-power idle
> to emulate suspend on Android.

Hello, Pavel,

Could you please point me at this message?

							Thanx, Paul

> This came like a bit of a shock to me ("why do they make it so complex
> then"), but... it also means that as soon as you are able to stop
> "unwanted" processing, you can just leave normal cpuidle mechanisms to
> deal with the rest...
> 
> (Of course, you'll also have to fix kernel timers not to beat
> unneccessarily often; still that's better solution that just stoping
> them all and then sprinkling wakelocks all over the kernel to deal
> with obvious bugs it introduces...)
> 									Pavel
> -- 
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
