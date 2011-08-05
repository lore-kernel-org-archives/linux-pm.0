From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Crash when suspending Lenovo T510 laptop (2.6.39.3)
Date: Fri, 5 Aug 2011 16:44:06 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1108051641040.2055-100000__43304.0697048002$1312577096$gmane$org@iolanthe.rowland.org>
References: <201108052236.12404.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201108052236.12404.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Len Brown <len.brown@intel.com>, linux-pm@lists.linux-foundation.org, Jesper Juhl <jj@chaosbits.net>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Fri, 5 Aug 2011, Rafael J. Wysocki wrote:

> > You're right, sorry.  System suspend was not involved, so the problem
> > was triggerend by runtime suspend alone, resulting from unplugging the
> > Ethernet cable.
> > 
> > It looks like the crash started in pci_disable_msi().
> 
> OTOH, I'm not sure how pci_legacy_suspend_late() was called.
> In theory it is only called by the system suspend code and it surely
> is not called for e1000e.

The ? indicates that pci_legacy_suspend_late() wasn't necessarily on
the task's call stack; it may simply have been a leftover pointer from
some other operation, sitting somewhere in the middle of the stack
page.

Alan Stern
