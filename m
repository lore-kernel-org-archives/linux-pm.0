From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] PM: runtime PM + idle: allow usage when
	interrupts are disabled
Date: Sat, 21 Aug 2010 01:27:46 +0200
Message-ID: <201008210127.46934.rjw__20972.1828149215$1282347025$gmane$org@sisk.pl>
References: <1281459261-30829-1-git-send-email-khilman@deeprootsystems.com>
	<201008162318.03923.rjw@sisk.pl>
	<874oeqgu6w.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <874oeqgu6w.fsf@deeprootsystems.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Thursday, August 19, 2010, Kevin Hilman wrote:
> "Rafael J. Wysocki" <rjw@sisk.pl> writes:
> 
> > On Tuesday, August 10, 2010, Kevin Hilman wrote:
> >> When using runtime PM in combination with CPUidle, the runtime PM
> >> transtions of some devices may be triggered during the idle path.
> >> Late in the idle sequence, interrupts will likely be disabled when
> >> runtime PM for these devices is initiated.
> >> 
> >> Currently, the runtime PM core assumes methods are called with
> >> interrupts enabled.  However, if it is called with interrupts
> >> disabled, the internal locking unconditionally enables interrupts, for
> >> example:
> >> 
> >> pm_runtime_put_sync()
> >
> > Please don't use that from interrupt context.  
> 
> I'm not using this in interrupt context.  I'm using it in process
> context where interrupts are disabled, specifically, the idle thread.
> 
> > There's pm_runtime_put() exactly for this purpose that puts the
> > _idle() call into a workqueue.
> 
> If I'm in my CPU's idle path, I don't want to activate a workqueue
> because then I'll no longer be idle.

Well, what about:

-> idle
   -> check if devices have been suspended
       - enter idle if so
       - call pm_request_idle() for devices

The workqueue will activate and put the devices into low-power states and
then your idle callback will be called again, with the devices suspended.

Thanks,
Rafael
