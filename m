From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH v2] [RFC] ehci: Disable wake on overcurrent
 (WKOC_E) and disconnect (WKDISC_E)
Date: Fri, 7 May 2010 11:20:18 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1005071106570.1804-100000__21114.8585928187$1273245666$gmane$org@iolanthe.rowland.org>
References: <20100507093200.28ecd63c@dxy2>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100507093200.28ecd63c@dxy2>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Du, Alek" <alek.du@intel.com>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, USB list <linux-usb@vger.kernel.org>, Ondrej Zary <linux@rainbow-software.org>, Kernel development list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Fri, 7 May 2010, Du, Alek wrote:

> Alan,
> 
> As I tested, with the second patch, after entering phy low power mode, the port cannot detect any USB devices that plugged in.

Ooh, that's not good.  It almost violates the EHCI spec (see the last
line on p.60 in table 4.4).

> I also confirm that after set PHCD flag, any write to PORTSC is illegal. (I have another patch will send out soon named "Clear PHCD before resuming",
> but the patch is not related with this one) 

I'm afraid we are going to have to modify the wakeup bits in PORTSC
after PHCD is set.  Can we clear PHCD, modify PORTSC, and then set PHCD
again?

> So it seems wakeup bits must set before set PHCD. So we may revise the flowchart a little bit, for example, if the HCD has hostpc,
> then set the wakeup bits like before, if the HCD is the normal one, then go your new way?

For normal HCDs, the wakeup bits don't matter when the controller is in
D0.  Therefore we can continue to set them as before during bus or port
suspend.

But during controller suspend, if the controller isn't supposed to be
remote-wakeup-enabled then we will need to clear the wakeup bits
(and set them again during controller resume).  Will that work?

Alan Stern
