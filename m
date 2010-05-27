From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 0/8] Suspend block api (version 8)
Date: Thu, 27 May 2010 19:05:15 +0100
Message-ID: <20100527190515.08be091a__45787.938059266$1274984429$gmane$org@lxorguk.ukuu.org.uk>
References: <Pine.LNX.4.44L0.1005271253240.3239-100000@iolanthe.rowland.org>
	<alpine.LFD.2.00.1005271915540.3032@localhost.localdomain>
	<20100527173118.GE2468@srcf.ucam.org>
	<1274981680.27810.5636.camel@twins>
	<20100527174019.GA3187@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100527174019.GA3187@srcf.ucam.org>
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
Cc: Peter Zijlstra <peterz@infradead.org>, Paul@smtp1.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, Linux@smtp1.linux-foundation.org, Thomas Gleixner <tglx@linutronix.de>, Mailing List <linux-omap@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>, felipe.balbi@nokia.com
List-Id: linux-pm@vger.kernel.org

On Thu, 27 May 2010 18:40:19 +0100
Matthew Garrett <mjg59@srcf.ucam.org> wrote:

> On Thu, May 27, 2010 at 07:34:40PM +0200, Peter Zijlstra wrote:
> > > we still need to be able to enter suspend while the system isn't idle.
> > 
> > _WHY_!?
> 
> Because if I'm running a kernel build in a tmpfs and I hit the sleep 
> key, I need to go to sleep. Blocking processes on driver access isn't 
> sufficient.

Suspend as an idle state

Suspend as a 'hand of God' choice.

One is a performance optimisation the other is an operator executive
decision.

I'd prefer we avoided mixing them up. Everyone seems fairly happy with
the current operator ordered suspend behaviour I believe ?
