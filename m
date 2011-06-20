From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: calling runtime PM from system PM methods
Date: Mon, 20 Jun 2011 10:39:32 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1106201028470.2113-100000__29759.4183510684$1308580906$gmane$org@iolanthe.rowland.org>
References: <201106192136.51572.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201106192136.51572.rjw@sisk.pl>
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
Cc: LKML <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Sun, 19 Jun 2011, Rafael J. Wysocki wrote:

> In the meantime I rethought the __pm_runtime_disable() part of my previous
> patch and I now think it's not necessary to complicate it any more.  Of course,
> we need not check if runtime resume is pending in __device_suspend(), because
> we've done it already in dpm_prepare(), but the barrier part should better be
> done in there too.

Does this really make sense?  What use is a barrier in dpm_prepare() if 
runtime PM is allowed to continue functioning up to the 
suspend callback?

As I see it, we never want a suspend or suspend_noirq callback to call 
pm_runtime_suspend().  However it's okay for the suspend callback to 
invoke pm_runtime_resume(), as long as this is all done in subsystem 
code.

And in between the prepare and suspend callbacks, runtime PM should be
more or less fully functional, right?  For most devices it will never
be triggered, because it has to run in process context and both
userspace and pm_wq are frozen.  It may trigger for devices marked as
IRQ-safe, though.

Maybe the barrier should be moved into __device_suspend().

Alan Stern
