From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 0/8] Suspend block api (version 8)
Date: Thu, 27 May 2010 19:37:51 +0200
Message-ID: <1274981871.27810.5650.camel__43619.7363109843$1274982122$gmane$org@twins>
References: <Pine.LNX.4.44L0.1005271329460.3239-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1005271329460.3239-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Linux PM <linux-pm@lists.linux-foundation.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, felipe.balbi@nokia.com
List-Id: linux-pm@vger.kernel.org

On Thu, 2010-05-27 at 13:32 -0400, Alan Stern wrote:

> On some platforms (like those with ACPI), deeper power-savings are
> available by using forced suspend than by using idle. 

Sounds like something that's fixable, doesn't it?

>  That used to be
> the case on Android.  Arve has said that it isn't necessarily true any
> more, but that's the way their software is set up.

Who cares about their current software? We're arguing about sensible
interfaces for the technical problem posed.
