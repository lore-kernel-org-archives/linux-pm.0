From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: deadlock between mmc_pm_notify() and mmcqd
Date: Tue, 29 Mar 2011 13:46:57 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1103291345220.2111-100000@iolanthe.rowland.org>
References: <alpine.DEB.2.00.1103291755190.2328@localhost6.localdomain6>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.DEB.2.00.1103291755190.2328@localhost6.localdomain6>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Frank Hofmann <frank.hofmann@tomtom.com>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Tue, 29 Mar 2011, Frank Hofmann wrote:

> Hi linux-pm'ers,

Maybe you should post this on the linux-mmc mailing list too?  They're 
more likely to know about the problem.

> I'm encountering the following deadlock:
> 
> 
> First, an "echo disk >/sys/power/state":
> 
...

> This waits for I/O. Which would be processed by mmcqd:
> 
> mmcqd D c03bad2c 0 516 2 0x00000000
> [<c03bad2c>] (schedule+0x48c/0x50c) from [<c02f1ae8>] (__mmc_claim_host+0xbc/0x158)
> [<c02f1ae8>] (__mmc_claim_host+0xbc/0x158) from [<c02f8378>] (mmc_blk_issue_rq+0x2c/0x728)
> [<c02f8378>] (mmc_blk_issue_rq+0x2c/0x728) from [<c02f9184>] (mmc_queue_thread+0xd8/0xdc)
> [<c02f9184>] (mmc_queue_thread+0xd8/0xdc) from [<c00d199c>] (kthread+0x80/0x88)
> [<c00d199c>] (kthread+0x80/0x88) from [<c007e0e4>] (kernel_thread_exit+0x0/0x8)
> 
> and that's waiting to claim the MMC host.
> 
> Which will never happen - mmc_pm_notify(), by the point above, holds that 
> host ransom already, the code does the mmc_claim_host() directly before 
> calling into bus_ops->suspend().

Alan Stern
