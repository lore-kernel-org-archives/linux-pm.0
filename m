From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 0/8] Suspend block api (version 8)
Date: Sat, 05 Jun 2010 21:52:16 +0200
Message-ID: <1275767536.1645.534.camel__27562.7885749147$1275767686$gmane$org@laptop>
References: <20100527222514.0a1710bf@lxorguk.ukuu.org.uk>
	<201006052104.05324.rjw@sisk.pl> <1275765379.1645.532.camel@laptop>
	<201006052139.31253.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201006052139.31253.rjw@sisk.pl>
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
Cc: tytso@mit.edu, Andrew Morton <akpm@linux-foundation.org>, Brian Swetland <swetland@google.com>, Felipe Contreras <felipe.contreras@gmail.com>, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, James Bottomley <James.Bottomley@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Linux PM <linux-pm@lists.linux-foundation.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, felipe.balbi@nokia.com
List-Id: linux-pm@vger.kernel.org

On Sat, 2010-06-05 at 21:39 +0200, Rafael J. Wysocki wrote:
> 
> There is a number of kernel users that depend on Android user space
> (phone vendors using Android on their hardware, but providing their own
> drivers), so I don't think we really can identify Android with Google in that
> respect.

I don't see why we can't merge the platform code and drivers without
suspend blockers. Google can patch them back in on their side if they
want to.
