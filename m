From: Matthew Garrett <mjg@redhat.com>
Subject: Re: [RFC] usb: Add support for runtime power management
	of the hcd
Date: Thu, 13 Aug 2009 22:47:29 +0100
Message-ID: <20090813214729.GD14532__44148.2253642336$1250200282$gmane$org@srcf.ucam.org>
References: <20090813003544.GB2532@srcf.ucam.org>
	<Pine.LNX.4.44L0.0908131117130.2940-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0908131117130.2940-100000@iolanthe.rowland.org>
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
Cc: linux-usb@vger.kernel.org, linux-pci@vger.kernel.org, Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Aug 13, 2009 at 11:22:44AM -0400, Alan Stern wrote:

> You have to call the HCD's pci_suspend method!  Not to mention calling 
> synchronize_irq and all the other stuff in hcd_pci_suspend and 
> hcd_pci_suspend_noirq.

The bus level code does this, assuming that the driver-level code 
doesn't return an error.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
