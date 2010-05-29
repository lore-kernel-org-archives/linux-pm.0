From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 0/8] Suspend block api (version 8)
Date: Sat, 29 May 2010 09:53:37 +0200
Message-ID: <1275119617.27810.12634.camel__45250.2939886928$1275119762$gmane$org@twins>
References: <20100527222514.0a1710bf@lxorguk.ukuu.org.uk>
	<1275052817.1645.64.camel@laptop> <1275058794.27810.9571.camel@twins>
	<201005282344.49892.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201005282344.49892.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, felipe.balbi@nokia.com, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-pm@vger.kernel.org

On Fri, 2010-05-28 at 23:44 +0200, Rafael J. Wysocki wrote:
> Consider updatedb or another file indexing ... thing on a laptop.  I certainly
> don't want anything like this to run and drain my battery, even if it has
> already been started when the machine was on AC power.  Now, of course,
> I can kill it, but for that I need to notice that it's running and it presumably
> might have done some job already and it would be wasteful to lose it.
> It would be quite nice if that app was not regarded as runnable when the
> system was on battery power. 

How will a ionice on steriods that will defer servicing IO when the IO
system QoS limit doesn't meet the updatedb process's level is too low,
not solve this?

In that case the updatedb process will simply block on IO, will hence
not be runnable and thus not drain your battery.
