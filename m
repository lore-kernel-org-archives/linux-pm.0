From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Runtime PM for PCI-based USB host controllers
Date: Wed, 26 May 2010 23:16:13 +0200
Message-ID: <201005262316.13957.rjw__26662.2863630348$1274916131$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.1005261138330.1328-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1005261138330.1328-100000@iolanthe.rowland.org>
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
Cc: linux-pci@vger.kernel.org, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Matthew Garrett <mjg@redhat.com>
List-Id: linux-pm@vger.kernel.org

On Wednesday 26 May 2010, Alan Stern wrote:
> Rafael:
> 
> I've been updating the patch Matthew Garrett posted last November, 
> adding runtime PM methods for PCI USB controllers.  Overall the 
> situation is now easier, since the rest of the USB subsystem has been 
> converted over to the runtime PM framework.  And it even seems to work!
> 
> But there is one problem.  The device driver needs to know, during its
> pm_suspend callback, whether or not wakeup should be enabled.  (Or more
> accurately, the pm_suspend callback needs to fail if wakeup isn't going
> to be available.) 

The driver can check that by calling pci_dev_run_wake() which returns false
if there's no wakeup support for the device.  However, that's not enough on
some broken machines where some signal pins are simply not connected to the
system core logic (as a result the PCI core thinks that wakeup is supported,
but in fact it doesn't work due to the broken hardware - yes, there are
machines like this in the wild, Matthew has one).

Rafael
