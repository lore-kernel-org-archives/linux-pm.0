From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 0/8] Suspend block api (version 8)
Date: Sat, 29 May 2010 22:12:36 +0200
Message-ID: <201005292212.36107.rjw__15809.2421865605$1275163974$gmane$org@sisk.pl>
References: <20100527222514.0a1710bf@lxorguk.ukuu.org.uk>
	<201005282344.49892.rjw@sisk.pl>
	<1275119617.27810.12634.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1275119617.27810.12634.camel@twins>
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
Cc: LKML <linux-kernel@vger.kernel.org>, Arve@smtp1.linux-foundation.org, Florian Mickler <florian@mickler.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, felipe.balbi@nokia.com, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-pm@vger.kernel.org

On Saturday 29 May 2010, Peter Zijlstra wrote:
> On Fri, 2010-05-28 at 23:44 +0200, Rafael J. Wysocki wrote:
> > Consider updatedb or another file indexing ... thing on a laptop.  I certainly
> > don't want anything like this to run and drain my battery, even if it has
> > already been started when the machine was on AC power.  Now, of course,
> > I can kill it, but for that I need to notice that it's running and it presumably
> > might have done some job already and it would be wasteful to lose it.
> > It would be quite nice if that app was not regarded as runnable when the
> > system was on battery power. 
> 
> How will a ionice on steriods that will defer servicing IO when the IO
> system QoS limit doesn't meet the updatedb process's level is too low,
> not solve this?
> 
> In that case the updatedb process will simply block on IO, will hence
> not be runnable and thus not drain your battery.

It will only work for apps that use I/O, but there may be purely CPU-bound
ones that need that kind of approach too.
