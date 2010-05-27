From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 0/8] Suspend block api (version 8)
Date: Thu, 27 May 2010 16:42:15 -0700
Message-ID: <87fx1cgbe0.fsf__23745.209122035$1275003941$gmane$org@deeprootsystems.com>
References: <Pine.LNX.4.44L0.1005271253240.3239-100000@iolanthe.rowland.org>
	<20100527174019.GA3187@srcf.ucam.org>
	<1274982447.27810.5684.camel@twins> <201005280041.43553.rjw@sisk.pl>
	<20100528001514.28e593ef@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100528001514.28e593ef@lxorguk.ukuu.org.uk> (Alan Cox's message
	of "Fri\, 28 May 2010 00\:15\:14 +0100")
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
Cc: Peter Zijlstra <peterz@infradead.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, LKML <linux-kernel@vger.kernel.org>, felipe.balbi@nokia.com, Linux@smtp1.linux-foundation.org, Mickler <florian@mickler.org>, Thomas Gleixner <tglx@linutronix.de>, List <linux-omap@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Florian@smtp1.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> - Given a non forced (that is 'idle down') transition to a suspend level
>   we can implement a 'suspend as idle' on many embedded platforms in a
>   manner which is not racy at kernel level. Apparently implemented
>   already on ARM

Just to confirm, yes, it is already implemeted on ARM, and in mainline
for the TI OMAP3 (ARM Cortex-A8) and in commercial products (Nokia
N900, Moto Droid, Palm Pre, Archos, etc.)  For the OMAP the deepest
C-state is actually a fully powered-down ARM core.

While the Droid uses 'suspend as idle' in addition to opportunistic
suspend, the N900 *never* suspends in the traditional sense, it is
entirely idle based.

Kevin
