From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 0/8] Suspend block api (version 8)
Date: Thu, 27 May 2010 16:33:59 +0100
Message-ID: <20100527163359.23e83bdd__35608.3323866644$1274974081$gmane$org@lxorguk.ukuu.org.uk>
References: <Pine.LNX.4.44L0.1005271053420.3239-100000@iolanthe.rowland.org>
	<1274972956.27810.5161.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1274972956.27810.5161.camel@twins>
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
Cc: Paul@smtp1.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, felipe.balbi@nokia.com
List-Id: linux-pm@vger.kernel.org

On Thu, 27 May 2010 17:09:16 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Thu, 2010-05-27 at 11:06 -0400, Alan Stern wrote:
> > 
> >         Opportunistic suspends are okay.
> > 
> >         The proposed userspace API is too Android-specific.
> 
> I would argue opportunistic suspends are not ok, and therefore the
> proposed API is utterly irrelevant.

Assuming you are happy that opportunistically entering C6 and the like is
ok via ACPI can you explain why you have a problem with opportunistic
suspend and why it is different to a very deep sleep CPU state such as we
have now (and which on many embedded platforms we deal with *is* sleeping
external devices too)

Alan
