From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC,PATCHv3 0/3] sdhci runtime_pm implementation
Date: Tue, 1 Mar 2011 14:33:07 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1103011431400.2034-100000__2584.98515836454$1299008330$gmane$org@iolanthe.rowland.org>
References: <cover.1298820825.git.tardyp@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <cover.1298820825.git.tardyp@gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pierre Tardy <tardyp@gmail.com>
Cc: linux-pm@lists.linux-foundation.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tue, 1 Mar 2011, Pierre Tardy wrote:

> Please find sdhci runtime_pm implementation.
> 
> It uses clock gating fw as a tip to know when our chip is idle.
> It implements wake up from card insertion/removal.
> 
> This is RFC, please dont merge yet. I really would like to have deep review
> from PCI linux-pm guys.
> 
> Opens are: 
> 
> 1/ Not sure if the pci configs in the driver in rpm_suspend/resume flow
>  are not duplicate from what the core is doing.

There may be one or two small errors.

> 2/ Wakeup from D3hot: I cannot find any driver that is implementing it in current upstream,

Other drivers do it, but they use PCI PME# instead of interrupts.

> I'm not sure if I'm doing it the good way. 
> We have the exact same issue for our not yet upstreamable usb-otg driver.
> Not sure if this cannot be implemented generically in core.

Alan Stern
