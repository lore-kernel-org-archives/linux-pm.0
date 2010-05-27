From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 0/8] Suspend block api (version 8)
Date: Thu, 27 May 2010 19:14:33 +0100
Message-ID: <20100527181433.GG3543__6402.39244462482$1274985373$gmane$org@srcf.ucam.org>
References: <Pine.LNX.4.44L0.1005271344040.3239-100000@iolanthe.rowland.org>
	<1274982779.27810.5708.camel@twins>
	<20100527175719.GD3543@srcf.ucam.org>
	<1274983333.27810.5744.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1274983333.27810.5744.camel@twins>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Paul@smtp1.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, felipe.balbi@nokia.com, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-pm@vger.kernel.org

On Thu, May 27, 2010 at 08:02:13PM +0200, Peter Zijlstra wrote:
> On Thu, 2010-05-27 at 18:57 +0100, Matthew Garrett wrote:
> > If you want to support forced suspend for laptops and you want to avoid 
> > the risk of losing wakeups then you need in-kernel suspend blockers. 
> > That's entirely orthogonal to Android's runtime power management.
> 
> The simple fact of life is, on PC style hardware suspend is mostly about
> missing events. I really _really_ want to miss mouse movement of my
> bluetooth mouse when the gear is stowed in my backpack.

That's fine - those shouldn't be configured as wakeup events.

> Its perfectly OK to miss events on _forced_ suspend.

No, it's not. Forced suspend may be in response to hitting a key, but it 
may also be in response to a 30 minute timeout expiring. If I get a WoL 
packet in the 0.5 of a second between userspace deciding to suspend and 
actually doing so, the system shouldn't suspend.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
