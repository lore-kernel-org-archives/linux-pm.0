From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [patch 2.6.25-rc6 7/7] PCI set up
 device.power.can_wakeup flags
Date: Thu, 20 Mar 2008 17:53:07 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0803201750010.881-100000__39368.0185931318$1206050096$gmane$org@netrider.rowland.org>
References: <200803201425.54587.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200803201425.54587.david-b@pacbell.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Thu, 20 Mar 2008, David Brownell wrote:

> A previous version of this patch broke on PowerPC platforms after they
> changed how they do early PCI initialization (following the first version
> of this patch).  Potentially the real fix involves switching PCI init on
> all platforms so they all adopt the driver model "init() then add()" model,
> calling device_initialize() early and pci_setup_device() before device_add().

Would it help to break this apart into two patches: the first to switch 
PCI over to the driver model approach, and the second to set up the 
can_wakeup flags?  Those really are two very different goals.

What are the barriers to doing the first part right now?  Is it just 
PPC?

Alan Stern
