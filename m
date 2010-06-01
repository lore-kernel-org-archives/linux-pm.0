From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: Runtime PM for PCI-based USB host controllers
Date: Tue, 1 Jun 2010 16:06:45 +0100
Message-ID: <20100601150645.GA10095__49900.7839397111$1275404959$gmane$org@srcf.ucam.org>
References: <20100526165748.GA7965@srcf.ucam.org>
	<Pine.LNX.4.44L0.1006011055440.2949-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1006011055440.2949-100000@iolanthe.rowland.org>
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

On Tue, Jun 01, 2010 at 10:59:17AM -0400, Alan Stern wrote:

> Can we rely on the forbid/allow mechanism?  If userspace never allows 
> runtime suspend for devices like the video controller then there's no 
> problem.  Conversely, if a PCI device really doesn't have a driver and 
> isn't used for anything, then by default it should go into a lower 
> power state if userspace allows this.

I think that's safe, yes. Other fringe concerns include things like 
smbus controllers - we typically won't allow a driver to bind to them 
because they're used by ACPI, so putting the in D3 is also an error. So 
I think Rafael's right in that we should default to forbid unless a 
driver knows that it's safe, and let userspace override us.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
