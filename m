From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Re: [Suspend-devel] Suspending to SD card on an Asus
	EEE PC
Date: Tue, 5 Feb 2008 10:50:18 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0802051048100.4167-100000__49776.6113178388$1202226787$gmane$org@iolanthe.rowland.org>
References: <200802032237.02078.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200802032237.02078.rjw@sisk.pl>
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
Cc: suspend-devel@lists.sourceforge.net, Max Whitney <mwhitney@sfu.ca>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Sun, 3 Feb 2008, Rafael J. Wysocki wrote:

> Actually, this is a kernel problem.
> 
> In short, the kernel disconnects removable storage devices before putting them
> into low power states and this cannot be fixed totally cleanly, AFAICS.

Actually the device probably disconnects itself instead of going into a 
low-power state as it should.  Or else the host controller does.

> If this is a USB device, you may try to set CONFIG_USB_PERSIST in the kernel
> config (this is not a safe option, though).

It still won't work with a suspend (normally USB_PERSIST affects only
hibernation).  For more information see this email and the thread it
belongs to:

	http://marc.info/?l=linux-usb-devel&m=119639745705185&w=2

Alan Stern
