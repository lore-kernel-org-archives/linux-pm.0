From: "Basak, Partha" <p-basak2@ti.com>
Subject: Re: [PATCH] PM: runtime PM + idle: allow usage when
 interrupts are disabled
Date: Thu, 19 Aug 2010 16:32:23 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301E82ACD17__31779.6766678386$1282229295$gmane$org@dbde02.ent.ti.com>
References: <1281459261-30829-1-git-send-email-khilman@deeprootsystems.com>
	<201008162318.03923.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201008162318.03923.rjw@sisk.pl>
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
To: "Rafael J. Wysocki" <rjw@sisk.pl>, Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Ming@smtp1.linux-foundation.org
List-Id: linux-pm@vger.kernel.org



> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Rafael J. Wysocki
> Sent: Tuesday, August 17, 2010 2:48 AM
> To: Kevin Hilman
> Cc: linux-pm@lists.linux-foundation.org; linux-omap@vger.kernel.org; Alan
> Stern; Ming Lei
> Subject: Re: [linux-pm] [PATCH] PM: runtime PM + idle: allow usage when
> interrupts are disabled
> 
> On Tuesday, August 10, 2010, Kevin Hilman wrote:
> > When using runtime PM in combination with CPUidle, the runtime PM
> > transtions of some devices may be triggered during the idle path.
> > Late in the idle sequence, interrupts will likely be disabled when
> > runtime PM for these devices is initiated.
> >
> > Currently, the runtime PM core assumes methods are called with
> > interrupts enabled.  However, if it is called with interrupts
> > disabled, the internal locking unconditionally enables interrupts, for
> > example:
> >
> > pm_runtime_put_sync()
> 
> Please don't use that from interrupt context.  There's pm_runtime_put()
> exactly for this purpose that puts the _idle() call into a workqueue.

Rafael, we execute this little before executing idle instruction with interrupts locked. So, we cannot call pm_runtime_put() as we want it to take effect immediately.
Kevin??

> 
> >     __pm_runtime_put()
> >         pm_runtime_idle()
> >             spin_lock_irq()
> >             __pm_runtime_idle()
> >                 spin_unlock_irq()   <--- interrupts unconditionally
> enabled
> 
> That's because __pm_runtime_idle() has to be called from process context.
> 
> >                 dev->bus->pm->runtime_idle()
> >                 spin_lock_irq()
> >              spin_unlock_irq()
> 
> Thanks,
> Rafael
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
