From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: PATCH: PM / Runtime: Remove idle notification after
 failing suspend (was: Re: [PATCH] PM: add synchronous ...)
Date: Sun, 10 Oct 2010 16:18:06 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1010101616410.30042-100000__41804.1775505573$1286741947$gmane$org@netrider.rowland.org>
References: <201010090124.56493.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201010090124.56493.rjw@sisk.pl>
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
Cc: linux-pm@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Sat, 9 Oct 2010, Rafael J. Wysocki wrote:

> From: Rafael J. Wysocki <rjw@sisk.pl>
> Subject: PM / Runtime: Remove idle notification after failing suspend
> 
> If runtime suspend of a device fails returning -EAGAIN or -EBUSY,
> which means that it's safe to try to suspend it again, the PM core
> runs the runtime idle helper function for it.  Unfortunately this may
> lead to problems, for example for PCI devices whose drivers don't
> implement the ->runtime_idle() callback, because in that case the
> PCI bus type's ->runtime_idle() always calls pm_runtime_suspend()
> for the given device.  Thus, if it is automatically called by a
> driver's ->runtime_suspend() returning -EAGAIN or -EBUSY, it will
> cause the suspend to happen again possibly causing a busy loop to
> appear.  To avoid that, remove the idle notification after failing
> runtime suspend of a device altogether and let the callers of
> pm_runtime_suspend() repeat the operation if need be.
> 
> Reported-by: Alan Stern <stern@rowland.harvard.edu>
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

This is fine as far as I'm concerned.

Alan Stern
