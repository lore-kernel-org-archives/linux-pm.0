From: "Mahalingam, Nithish" <nithish.mahalingam@intel.com>
Subject: Re: Runtime PM: Check for dev->parent PM support
Date: Thu, 3 Dec 2009 14:08:23 +0530
Message-ID: <175E0F9A9EFCEA46A65F5552BB057298C5C4EB55@bgsmsx502.gar.corp.intel.com>
References: <175E0F9A9EFCEA46A65F5552BB057298C5C4E603@bgsmsx502.gar.corp.intel.com>
	<Pine.LNX.4.44L0.0912021016170.11361-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0912021016170.11361-100000@iolanthe.rowland.org>
Content-Language: en-US
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
Cc: "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Yup got it. On further reading through the code found that the check does happen at some point but could have been optimized by checking if the parent supports runtime PM initially.

Regards,	
Nithish Mahalingam


-----Original Message-----
From: Alan Stern [mailto:stern@rowland.harvard.edu] 
Sent: Wednesday, December 02, 2009 8:50 PM
To: Mahalingam, Nithish
Cc: Rafael J. Wysocki; linux-pm@lists.linux-foundation.org
Subject: Re: [linux-pm] Runtime PM: Check for dev->parent PM support

On Wed, 2 Dec 2009, Mahalingam, Nithish wrote:

> Hi Rafael,
> 
> I see that in most of the internal runtime functions
> (__pm_runtime_suspend, __pm_runtime_resume, __pm_runtime_set_status
> etc.) without any explicit check to see if the dev->parent supports
> runtime PM there is access to its runtime PM fields. I guess there
> can be a use case where a device supports runtime PM but its parent
> does not. Am I missing something here?

That's right.  For example, in theory there could be a situation where
the PCI subsystem didn't include runtime PM support but the SCSI
subsystem did.  Then you could have a SCSI target device (with support) 
whose parent was a PCI SCSI host adapter (without support).

(Actually that example couldn't happen, because PCI is one of the first 
subsystems to support runtime PM.  But you get the idea.)

Alan Stern
