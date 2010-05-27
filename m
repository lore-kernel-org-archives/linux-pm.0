From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 0/8] Suspend block api (version 8)
Date: Thu, 27 May 2010 20:02:43 +0200
Message-ID: <1274983363.27810.5749.camel__30064.2460737892$1274987161$gmane$org@twins>
References: <AANLkTin97MMu-XO_Lk-snefBWz2ymhS0Qi1y1RxLwdVA@mail.gmail.com>
	<20100527003943.07c17f85@lxorguk.ukuu.org.uk>
	<20100527140655.GA28048@srcf.ucam.org>
	<alpine.LFD.2.00.1005271642440.3032@localhost.localdomain>
	<20100527155201.GA31937@srcf.ucam.org>
	<alpine.LFD.2.00.1005271808340.3032@localhost.localdomain>
	<20100527192135.6c6543b3@schatten.dmk.lab>
	<1274981127.27810.5597.camel@twins>
	<20100527194241.52caaf37@schatten.dmk.lab>
	<1274982729.27810.5703.camel@twins>
	<20100527175426.GC3543@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100527175426.GC3543@srcf.ucam.org>
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
Cc: Paul@smtp1.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, felipe.balbi@nokia.com, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-pm@vger.kernel.org

On Thu, 2010-05-27 at 18:54 +0100, Matthew Garrett wrote:
> On Thu, May 27, 2010 at 07:52:09PM +0200, Peter Zijlstra wrote:
> 
> > How so, event happens on hardware level, IRQ gets raised, CPU wakes up,
> > handler gets run, handler generates a task wakeup, runqueue isn't empty,
> > we run stuff.
> 
> If you're using idle-based suspend without any forced idling or blocking 
> of applications then you don't lose wakeups. People keep conflating 
> separate issues.

I still don't see how blocking applications will cause missed wakeups in
anything but a buggy application at worst, and even those will
eventually get the event when they unblock.

What seems to be the confusion?
