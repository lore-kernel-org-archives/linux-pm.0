From: "Du, Alek" <alek.du@intel.com>
Subject: Re: [PATCH v2] [RFC] ehci: Disable wake on overcurrent
 (WKOC_E) and disconnect (WKDISC_E)
Date: Fri, 7 May 2010 09:32:00 +0800
Message-ID: <20100507093200.28ecd63c__22018.2119323455$1273196257$gmane$org@dxy2>
References: <1865303E0DED764181A9D882DEF65FB61A82A6DAFD@shsmsx502.ccr.corp.intel.com>
	<Pine.LNX.4.44L0.1005061204000.1708-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1005061204000.1708-100000@iolanthe.rowland.org>
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
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, USB list <linux-usb@vger.kernel.org>, Ondrej Zary <linux@rainbow-software.org>, Kernel development list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Fri, 7 May 2010 00:06:33 +0800
Alan Stern <stern@rowland.harvard.edu> wrote:

> On Thu, 6 May 2010, Du, Alek wrote:
> 
> > Hi Alan,
> > 
> > >With this patch, _none_ of the wakeup bits are enabled.  That should
> > >work, right?
> > >
> > I guess so, but if no wakeup bits set, how to handle remote wakeup case? Seems you removed remote wakeup case?
> 
> The wakeup bits get set later, in ehci_set_wakeup_flags().
> 
> The point is that the wakeup bits take effect only when the controller 
> leaves D0.  But ehci_bus_suspend() is called when the root hub is 
> suspended, which happens first.  So at that time the wakeup bits aren't 
> needed.
> 
> Alan Stern
> 

Alan,

As I tested, with the second patch, after entering phy low power mode, the port cannot detect any USB devices that plugged in.
I also confirm that after set PHCD flag, any write to PORTSC is illegal. (I have another patch will send out soon named "Clear PHCD before resuming",
but the patch is not related with this one) 

So it seems wakeup bits must set before set PHCD. So we may revise the flowchart a little bit, for example, if the HCD has hostpc,
then set the wakeup bits like before, if the HCD is the normal one, then go your new way?


Thanks,
Alek
