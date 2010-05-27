From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 0/8] Suspend block api (version 8)
Date: Thu, 27 May 2010 22:06:09 +0100
Message-ID: <20100527210609.GA8865__18715.5085070573$1274994441$gmane$org@srcf.ucam.org>
References: <20100527172510.GC2468@srcf.ucam.org>
	<1274981288.27810.5609.camel@twins>
	<20100527173218.GF2468@srcf.ucam.org>
	<1274981750.27810.5641.camel@twins>
	<20100527174140.GB3187@srcf.ucam.org>
	<1274982397.27810.5679.camel@twins>
	<20100527175258.GB3543@srcf.ucam.org>
	<1274982981.27810.5719.camel@twins>
	<20100527175920.GE3543@srcf.ucam.org>
	<20100527220314.312d9e3c@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20100527220314.312d9e3c@lxorguk.ukuu.org.uk>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Peter Zijlstra <peterz@infradead.org>, Paul@smtp1.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, felipe.balbi@nokia.com
List-Id: linux-pm@vger.kernel.org

On Thu, May 27, 2010 at 10:03:14PM +0100, Alan Cox wrote:
> On Thu, 27 May 2010 18:59:20 +0100
> Matthew Garrett <mjg59@srcf.ucam.org> wrote:
> > Ok. So the existing badly-behaved application ignores your request and 
> > then gets blocked. And now it no longer responds to wakeup events. So 
> > you penalise well-behaved applications without providing any benefits to 
> > badly-behaved ones.
> 
> I don't see how you put the first two sentences together and get the
> final one.
> 
> When you beat up badly behaved apps that doesn't penalise well behaved
> ones.

If you're going to block an app on drawing then you either need to 
reenable drawing on wakeup or you need to have an interface for alerting 
the app to the fact that drawing is about to block and it should get 
back to its event loop. The first is suboptimal, the second penalises 
well behaved apps.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
