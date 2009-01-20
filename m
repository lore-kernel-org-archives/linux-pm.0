From: Greg KH <gregkh@suse.de>
Subject: Re: [PATCH] USB: Fix suspend-resume of PCI USB
	controllers
Date: Mon, 19 Jan 2009 17:36:02 -0800
Message-ID: <20090120013602.GA8377__16053.5246752717$1232415669$gmane$org@suse.de>
References: <200901200126.57839.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200901200126.57839.rjw@sisk.pl>
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
Cc: Jeff Chua <jeff.chua.linux@gmail.com>, USB list <linux-usb@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Zdenek Kabelac <zdenek.kabelac@gmail.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@linux-foundation.org>, Andrey Borzenkov <arvidjaar@mail.ru>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Jan 20, 2009 at 01:26:56AM +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> Commit a0d4922da2e4ccb0973095d8d29f36f6b1b5f703
> (USB: fix up suspend and resume for PCI host controllers) attempted
> to fix the suspend-resume of PCI USB controllers, but unfortunately
> it did that incorrectly and interrupts are left enabled by the USB
> controllers' ->suspend_late() callback as a result.  This leads to
> serious problems during suspend which are very difficult to debug.
> 
> Fix the issue by removing the ->suspend_late() callback of PCI
> USB controllers and moving the code from there to the ->suspend()
> callback executed with interrupts enabled.  Additionally, make
> the ->resume() callback of PCI USB controllers execute
> pci_enable_wake(dev, PCI_D0, false) to disable wake-up from the
> full power state (PCI_D0).
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> Tested-by: Andrey Borzenkov <arvidjaar@mail.ru>
> Tested-by: "Jeff Chua" <jeff.chua.linux@gmail.com>
> Cc: Alan Stern <stern@rowland.harvard.edu>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
> Cc: "Zdenek Kabelac" <zdenek.kabelac@gmail.com>
> Cc: Ingo Molnar <mingo@elte.hu>


Alan, does this look ok for you?

thanks,

greg k-h
