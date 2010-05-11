From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/8] Suspend block api (version 6)
Date: Tue, 11 May 2010 10:24:43 -0700
Message-ID: <20100511172442.GB13931__37677.438153378$1273598749$gmane$org@atomide.com>
References: <1272667021-21312-1-git-send-email-arve@android.com>
	<87wrvl5479.fsf@deeprootsystems.com>
	<87632vhbs8.fsf@deeprootsystems.com>
	<201005102225.52431.rjw@sisk.pl>
	<20100511161227.GD13600@atomide.com>
	<20100511161448.GA16148@srcf.ucam.org>
	<20100511163632.GE13600@atomide.com>
	<20100511164554.GA17016@srcf.ucam.org>
	<20100511165821.GA13931@atomide.com>
	<20100511170348.GA17443@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20100511170348.GA17443@srcf.ucam.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Matthew Garrett <mjg@redhat.com>
Cc: Geoff Smith <geoffx.smith@intel.com>, Brian Swetland <swetland@google.com>, linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>, Tejun Heo <tj@kernel.org>, linux-pm@lists.linux-foundation.org, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

* Matthew Garrett <mjg@redhat.com> [100511 09:59]:
> On Tue, May 11, 2010 at 09:58:21AM -0700, Tony Lindgren wrote:
> > * Matthew Garrett <mjg@redhat.com> [100511 09:41]:
> > > Yes. You still need suspend blocks.
> > 
> > Maybe not if echo opportunistic > /sys/power/policy gets cleared by
> > the kernel if the kernel idle loop can't make it. That means something
> > has blocked the suspend attempt in a driver for example. The system
> > keeps running, and the userspace can deal with the situation.
> 
> So an event arrives just as userspace does this write. How do you avoid 
> the race? Plausible answers mostly appear to end up looking like suspend 
> blockers.

Assuming you attempt suspend in a custom pm_idle function, any driver
handling the event can fail the suspend attempt.

And that would clear the opportunistic suspend flag. And the userspace
would be still running and could handle the event. And when the userspace
is done, it can again echo opportunistic > /sys/power/policy.

For the failed suspend path in the kernel, currently the kernel would
unwind back all the drivers because of the failed driver, but that path
should be possible to optimize.

Regards,

Tony
