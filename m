From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 0/8] Suspend block api (version 8)
Date: Thu, 27 May 2010 19:31:00 +0100
Message-ID: <20100527183100.GP3543__46835.2893753492$1274986009$gmane$org@srcf.ucam.org>
References: <20100527173218.GF2468@srcf.ucam.org>
	<1274981750.27810.5641.camel@twins>
	<20100527174140.GB3187@srcf.ucam.org>
	<1274982397.27810.5679.camel@twins>
	<20100527175258.GB3543@srcf.ucam.org>
	<1274982981.27810.5719.camel@twins>
	<20100527175920.GE3543@srcf.ucam.org>
	<1274983598.27810.5761.camel@twins>
	<20100527181758.GJ3543@srcf.ucam.org>
	<1274984528.27810.5818.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1274984528.27810.5818.camel@twins>
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

On Thu, May 27, 2010 at 08:22:08PM +0200, Peter Zijlstra wrote:
> On Thu, 2010-05-27 at 19:17 +0100, Matthew Garrett wrote:
> 
> > It's blocked on the screen being turned off. It's supposed to be reading 
> > a network packet. How does it ever get to reading the network packet?
> 
> Its blocked because its a buggy app, who cares about misbehaviour in a
> buggy app?

So why bother blocking? Just kill the app and tell the user. If you want 
to support suboptimal apps then blocking isn't sufficient. If you don't 
want to then blocking isn't necessary.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
