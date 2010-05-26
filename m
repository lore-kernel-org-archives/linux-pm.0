From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: Runtime PM for PCI-based USB host controllers
Date: Thu, 27 May 2010 00:00:09 +0100
Message-ID: <20100526230009.GA15469__40737.6470081092$1274918168$gmane$org@srcf.ucam.org>
References: <201005262316.13957.rjw@sisk.pl>
	<Pine.LNX.4.44L0.1005261813350.1328-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1005261813350.1328-100000@iolanthe.rowland.org>
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

On Wed, May 26, 2010 at 06:14:52PM -0400, Alan Stern wrote:

> We don't have to worry about that.  If the hardware is broken and the 
> kernel doesn't realize it, the user will just have to tell it not to 
> allow runtime suspend for those devices.

It's worse than that - Windows simply doesn't use legacy PCI PMEs for 
anything, so an increasing number of modern machines don't have them 
wired up. Defaulting to runtime PM simply isn't practical, since the 
behaviour will simply be that the devices stop working without any 
indication that they've stopped working. The "easiest" workaround would 
be a thread that polls for PCI devices with set PME bits, along with a 
set of heuristics for determining whether the device can really wake up. 

Devices in the core logic (like USB generally is) will be fine in any 
case. It's discrete PCI devices that are the problem.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
