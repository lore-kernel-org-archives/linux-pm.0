From: Florian Mickler <florian@mickler.org>
Subject: Re: Attempted summary of suspend-blockers LKML thread
Date: Thu, 5 Aug 2010 07:56:29 +0200
Message-ID: <20100805075629.07d5d88d__38508.0655258664$1280987848$gmane$org@schatten.dmk.lab>
References: <20100801054816.GI2470@linux.vnet.ibm.com>
	<alpine.DEB.2.00.1008041124580.6545@asgard.lang.hm>
	<20100804185520.GA2417@srcf.ucam.org>
	<201008042251.08266.rjw@sisk.pl>
	<20100804205654.GA4986@srcf.ucam.org>
	<alpine.DEB.2.00.1008041529530.6545@asgard.lang.hm>
	<AANLkTimRZc2B1=ic-0jrGBX7ahCu=NCoQadCOePGDmh9@mail.gmail.com>
	<alpine.DEB.2.00.1008041554580.6545@asgard.lang.hm>
	<20100804231003.GL24163@linux.vnet.ibm.com>
	<20100805073359.4cb791c0@schatten.dmk.lab>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100805073359.4cb791c0@schatten.dmk.lab>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Florian Mickler <florian@mickler.org>
Cc: david@lang.hm, peterz@infradead.org, swetland@google.com, linux-kernel@vger.kernel.org, Arve@smtp1.linux-foundation.org, linux-pm@lists.linux-foundation.org, paulmck@linux.vnet.ibm.com, tglx@linutronix.de, alan@lxorguk.ukuu.org.uk, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Thu, 5 Aug 2010 07:33:59 +0200
Florian Mickler <florian@mickler.org> wrote:

> On Wed, 4 Aug 2010 16:10:03 -0700
> "Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:

> 
> No no. In the David-Lang-CGroup-Scheme[1](tm?) suspend-from-idle
> is used. For idle decision a certain subset of tasks is ignored. 
> 
> Where suspend is prevented by the trusted
> process in android-world taking a wakelock, here it would just prevent
> the system from going idle by arming timers.
> 
> This would be pretty equivalent to the suspend-blocker scheme and not
> introduce new userspace api. But the downside is, as Arve pointed out,
> that now one can not get full-idle-power-leverage while suspend
> is blocked. 
> 
> [1] http://permalink.gmane.org/gmane.linux.kernel/1018452  and
> following 
> 
> 
> Cheers,
> Flo
> 

There are a few downsides that got mentioned already in reponse..  I got
a little lagged behind. 

There are upsides to this approach like not
having a special purpose userspace api, conceptually integrating
suspend into the idle mechanism .. 

Short summary of the cons that got mentioned:

  -  applications need to resort to polling to keep the system
	out of idle (->  system will never be fully idle)

  -  the race between deciding to suspend and becoming active
	again is not handled

  -  no special statistics available

  -  the timers of the ignored applications will behave unexpected
	(as the monotonic clock is not stopped)... while applications
	have already to cope with network-loss, other side effects of
	suspend without monotonic clock stopped are to be expected...


Cheers,
Flo
