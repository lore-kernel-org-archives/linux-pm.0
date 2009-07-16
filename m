From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] [suspend] pci_raw_set_power_state: replace
 msleep by udelay in resuming procedure
Date: Thu, 16 Jul 2009 13:02:53 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0907161259510.2952-100000__18650.636697612$1247763882$gmane$org@iolanthe.rowland.org>
References: <1247759007-27411-1-git-send-email-wuzhangjin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1247759007-27411-1-git-send-email-wuzhangjin@gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Wu Zhangjin <wuzhangjin@gmail.com>
Cc: len.brown@intel.com, yanh@lemote.com, linux-kernel@vger.kernel.org, wuzj@lemote.com, zhangfx@lemote.com, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Thu, 16 Jul 2009, Wu Zhangjin wrote:

> we can not call msleep() when resuming from STR/Standby: if the
> current_state of the pci device is PCI_D3hot, means we are in the
> procedure of resuming, in this procedure, we can not re-schedule,
> otherwise, there will be a deadlock.

I don't understand.

First of all, why does current_state == PCI_D3hot mean the system is
resuming from sleep?  Isn't it possible that the PCI device is going
through a runtime resume?

Secondly, why will scheduling during a resume cause a deadlock?

Alan Stern
