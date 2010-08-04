From: Florian Mickler <florian@mickler.org>
Subject: Re: Attempted summary of suspend-blockers LKML thread
Date: Wed, 4 Aug 2010 23:39:24 +0200
Message-ID: <20100804233924.5303d19a__32422.1072988168$1280958348$gmane$org@schatten.dmk.lab>
References: <20100731230101.7cc1d8c7@infradead.org>
	<20100801191228.GL2470@linux.vnet.ibm.com>
	<20100801154708.19817b75@infradead.org>
	<20100802011006.GS2470@linux.vnet.ibm.com>
	<AANLkTi=a-1hn_oL=i-=RKK9xOur+4mQjTRut+aiXtYkE@mail.gmail.com>
	<20100803183447.0275c134@infradead.org>
	<20100804163216.GB24163@linux.vnet.ibm.com>
	<20100804163509.GA31523@srcf.ucam.org>
	<20100804204208.GA21452@elf.ucw.cz>
	<20100804205159.GH24163@linux.vnet.ibm.com>
	<20100804211513.GC21452@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100804211513.GC21452@elf.ucw.cz>
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
Cc: peterz@infradead.org, swetland@google.com, linux-kernel@vger.kernel.org, Arve@smtp1.linux-foundation.org, linux-pm@lists.linux-foundation.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, tglx@linutronix.de, alan@lxorguk.ukuu.org.uk, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Wed, 4 Aug 2010 23:15:13 +0200
Pavel Machek <pavel@ucw.cz> wrote:

> Hi!
> 
> > > > > If this doesn't work for the Android folks for whatever reason, another
> > > > > approach would be to do the freeze in user code, which could track
> > > > > whether any user-level resources (pthread mutexes, SysV semas, whatever)
> > > > > where held, and do the freeze on a thread-by-thread basis within each
> > > > > "victim" application as the threads reach safe points.
> > > > 
> > > > The main problem I see with the cgroups solution is that it doesn't seem 
> > > > to do anything to handle avoiding loss of wakeup events.
> > > 
> > > In different message, Arve said they are actually using low-power idle
> > > to emulate suspend on Android.
> > 
> > Hello, Pavel,
> > 
> > Could you please point me at this message?
> 
> AFAICT, this tells us that idle and suspend is the same hardware state
> on current Android hardware:
> 								Pavel
> 
> Message-ID: <AANLkTinjH0C0bSK=Y2wKASnbJFsR2BN303xBXkaHbmRC@mail.gmail.com>
> 
> Arve said:
> 
> If you just program the alarm you will wake up see that the monotonic
> clock has not advanced and set the alarm another n seconds into the
> future. Or are proposing that suspend should be changed to keep the
> monotonic clock running? If you are, why? We can enter the same
> hardware states from idle, and modifying suspend to wake up more often
> would increase the average power consumption in suspend, not improve
> it for idle. In other words, if suspend wakes up as often as idle, why
> use suspend?
> 
> 

They always told us from the beginning, that on the msm platform they
reach the same powerlevel from suspend and idle. They still get gains
from using opportunistic suspend. 

Cheers,
Flo
