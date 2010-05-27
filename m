From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 0/8] Suspend block api (version 8)
Date: Thu, 27 May 2010 23:36:05 +0100
Message-ID: <20100527223605.GB11364__19157.401045277$1275000349$gmane$org@srcf.ucam.org>
References: <20100527222514.0a1710bf@lxorguk.ukuu.org.uk>
	<Pine.LNX.4.44L0.1005271730180.3239-100000@iolanthe.rowland.org>
	<20100527230806.4deb6de3@lxorguk.ukuu.org.uk>
	<20100527220949.GB10602@srcf.ucam.org>
	<20100527232357.6d14fdb2@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20100527232357.6d14fdb2@lxorguk.ukuu.org.uk>
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
Cc: Peter Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, felipe.balbi@nokia.com
List-Id: linux-pm@vger.kernel.org

On Thu, May 27, 2010 at 11:23:57PM +0100, Alan Cox wrote:
> On Thu, 27 May 2010 23:09:49 +0100
> Matthew Garrett <mjg59@srcf.ucam.org> wrote:
> 
> > On Thu, May 27, 2010 at 11:08:06PM +0100, Alan Cox wrote:
> > 
> > > This is I believe robust (and has been implemented on some non x86
> > > boxes). It depends on not forcing running tasks into suspend. That is the
> > > key.
> > 
> > We've already established that ACPI systems require us to force running 
> > tasks into suspend. How do we avoid the race in that situation?
> 
> Android phones do not have ACPI. Embedded platforms do not have ACPI. MID
> x86 devices do not have ACPI.

It doesn't matter. Right now there's a race condition in terms of 
wakeup events on ACPI systems. What's your proposal for fixing that?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
