From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 0/8] Suspend block api (version 8)
Date: Thu, 27 May 2010 20:03:13 +0100
Message-ID: <20100527200313.5c532f2f__30324.9505152509$1274987086$gmane$org@lxorguk.ukuu.org.uk>
References: <Pine.LNX.4.44L0.1005271344040.3239-100000@iolanthe.rowland.org>
	<1274982779.27810.5708.camel@twins>
	<20100527175719.GD3543@srcf.ucam.org>
	<1274983333.27810.5744.camel@twins>
	<20100527181433.GG3543@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100527181433.GG3543@srcf.ucam.org>
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

> No, it's not. Forced suspend may be in response to hitting a key, but it 

You are the only person here talking about 'forced' suspends. The rest of
us are talking about idling down and ensuring we are always in a state we
un-idle correctly.

> may also be in response to a 30 minute timeout expiring. If I get a WoL 
> packet in the 0.5 of a second between userspace deciding to suspend and 
> actually doing so, the system shouldn't suspend.

I don't think that argument holds water in the form you have it

What about 5 nanoseconds before you suspend. Now you can't do that (laws
of physics and stuff).

So your position would seem to be "we have a race but can debate how big
is permissible"

The usual model is

"At no point should we be in a position when entering a suspend style
 deep sleep where we neither abort the suspend, nor commit to a
 suspend/resume sequence if the events we care about occur"

and that is why the hardware model is

	Set wake flags
	Check if idle
	If idle
		Suspend
	else
		Clear wake flags
		Unwind

and the wake flags guarantee that an event at any point after the wake
flags are set until they are cleared will cause a suspend to be resumed,
possibly immediately after the suspend.

Alan
