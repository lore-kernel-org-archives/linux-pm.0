From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: Runtime PM for PCI-based USB host controllers
Date: Wed, 26 May 2010 17:00:03 +0100
Message-ID: <20100526160002.GA6242__3176.11706345833$1274889827$gmane$org@srcf.ucam.org>
References: <Pine.LNX.4.44L0.1005261138330.1328-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
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
Cc: linux-pci@vger.kernel.org, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Wed, May 26, 2010 at 11:51:12AM -0400, Alan Stern wrote:

(leaving the wakeup stuff to Rafael for the moment...)

> Another question...  The PCI core doesn't call pm_runtime_enable() or
> pci_runtime_set_active() anywhere.  Apparently this is left up to the
> individual device driver.  But shouldn't the core take this
> responsibility?  What happens to PCI devices for which there is no
> driver?  Shouldn't the core put them into runtime suspend by default?

This is problematic in the GPU case, at least, since there are still 
many that get driven by userspace rather than by the kernel.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
