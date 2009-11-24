From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] PM: fix irq enable/disable in runtime PM code
Date: Tue, 24 Nov 2009 23:30:41 +0100
Message-ID: <200911242330.41735.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.0911241520190.2881-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0911241520190.2881-100000@iolanthe.rowland.org>
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
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Tuesday 24 November 2009, Alan Stern wrote:
> This patch (as1305) fixes a bug in the irq-enable settings and removes
> some related overhead in the runtime PM code.
> 
> 	In __pm_runtime_resume(), within the scope of the original
> 	spin_lock_irq(), we know that irqs are disabled.  There's no
> 	reason to go through a pair of enable/disable cycles when
> 	acquiring and releasing the parent's lock.
> 
> 	In __pm_runtime_set_status(), irqs are already disabled when
> 	the parent's lock is acquired, and they must remain disabled
> 	when it is released.
> 
> Signed-off-by: Alan Stern <stern@rowland.harvard.edu>

Thanks for the patch, I'll apply it shortly.

Rafael
