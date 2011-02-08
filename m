From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 0/2] Fix hangup after creating checkpoint on
 Xen.
Date: Tue, 8 Feb 2011 11:46:37 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1102081143470.2100-100000__8735.351303085$1297183759$gmane$org@iolanthe.rowland.org>
References: <1297164178.9388.65.camel@zakaz.uk.xensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1297164178.9388.65.camel@zakaz.uk.xensource.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Ian Campbell <ijc@hellion.org.uk>
Cc: linux-pm@lists.linux-foundation.org, xen-devel@lists.xensource.com, "SUZUKI,
	Kazuhiro" <kaz@jp.fujitsu.com>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, 8 Feb 2011, Ian Campbell wrote:

> The problem is that currently we have:
> 
>         dpm_suspend_start(PMSG_SUSPEND);
>         
>                 dpm_suspend_noirq(PMSG_SUSPEND);
>                         
>                         sysdev_suspend(PMSG_SUSPEND);
>                         /* suspend hypercall */
>                         sysdev_resume();
>                 
>                 dpm_resume_noirq(PMSG_RESUME);
>         
>         dpm_resume_end(PMSG_RESUME);
> 
> However the suspend hypercall can return a value indicating that the
> suspend didn't actually happen (e.g. was cancelled). This is used e.g.
> when checkpointing guests, because in that case you want the original
> guest to continue. When the suspend didn't happen the drivers need to
> recover differently from if it did.

That is odd, and it is quite different from the intended design of the 
PM core.  Drivers are supposed to put their devices into a known 
suspended state; then afterwards they put the devices back into an 
operational state.  What happens while the devices are in the suspended 
state isn't supposed to matter -- the system transition can fail, but 
devices get treated exactly the same way as if it succeeded.

Why do your drivers need to recover differently based on the success of 
the hypercall?

Alan Stern
