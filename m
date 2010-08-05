From: Brian Swetland <swetland@google.com>
Subject: Re: Attempted summary of suspend-blockers LKML thread
Date: Thu, 5 Aug 2010 08:15:35 -0700
Message-ID: <AANLkTinOkBvKKtrvb_ZYTPzAU9r24yXVPfcbSGqHUUji__41614.7850141444$1281024918$gmane$org@mail.gmail.com>
References: <20100803183447.0275c134@infradead.org>
	<20100804163216.GB24163@linux.vnet.ibm.com>
	<20100804163509.GA31523@srcf.ucam.org>
	<alpine.DEB.2.00.1008041124580.6545@asgard.lang.hm>
	<20100804185520.GA2417@srcf.ucam.org>
	<alpine.DEB.2.00.1008041207260.6545@asgard.lang.hm>
	<20100804192115.GA2946@srcf.ucam.org>
	<alpine.DEB.2.00.1008041222280.6545@asgard.lang.hm>
	<20100804195723.GA3553@srcf.ucam.org>
	<alpine.DEB.2.00.1008041508040.6545@asgard.lang.hm>
	<20100805133811.GA20565@srcf.ucam.org>
	<alpine.DEB.2.00.1008050724110.25170@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.DEB.2.00.1008050724110.25170@asgard.lang.hm>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: david@lang.hm
Cc: peterz@infradead.org, linux-kernel@vger.kernel.org, florian@mickler.org, linux-pm@lists.linux-foundation.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, tglx@linutronix.de, alan@lxorguk.ukuu.org.uk, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Aug 5, 2010 at 7:34 AM,  <david@lang.hm> wrote:
>
> for example, if you want to abort the suspend because there is network
> activity, you can check the packet count of your network interface, decide
> to go to sleep, setup the network interface to raise a 'wake me up'
> interrupt (because you have decided in a userspace policy that you want
> this), and then check to see if the packet count has changed. If it has,
> abort the suspend, if not continue the suspend and once you are suspended if
> the 'wake me up' interrupt is set you will wake back up.
>
> there are probably cleaner/better ways of doing this than the simple logic
> that I'm listing, but why wouldn't the simple logic provide the correct
> result?

If your network interrupt happens before the network driver's
suspend() hook is called this works -- the check in the suspend hook
observes the change and returns an abort status.

If your network interrupt happens after the suspend() hook is called
this does not work -- the event comes after your opportunity to abort
suspend has happened, your interrupt handler processed it, set the
flag, but the system proceeds to suspend anyway, missing the event.

The wakelock/suspendblock mechanism avoids races like the above.

Brian
