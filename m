From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Question about timers during system suspend
Date: Wed, 5 Jan 2011 00:05:42 +0100
Message-ID: <201101050005.42914.rjw@sisk.pl>
References: <BLU102-W26157F65094C5BCB0C51ADEB080@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <BLU102-W26157F65094C5BCB0C51ADEB080@phx.gbl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Raj Kumar <rajkumar278@hotmail.com>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Tuesday, January 04, 2011, Raj Kumar wrote:
> 
> Hi,

Hi,

> I have question regarding the timers during system suspend. If a software timer is
> active in device driver, will this timer be stopped during system suspend?

What do you mean by "stopped"?  Do you mean canceled?

> If the timer is active, will it prevent the system from full suspend?

No, it won't.

> The another thing is during system suspend, how the user space code know about suspend?

It doesn't, unless it's notified by the user space process initiating suspend.

> One way is that device driver gets the suspend and it notifies the user space. 

That doesn't work, because user space is frozen when drivers' suspend routines
are being called.  It might work if the driver in question registered a power
management notifier and sent a notification to user space from there.

> But is there way that during system goes into full suspend, is any user space component that will
> give notifications to applications that has registered for system suspend transition?

That depends on the configuration of user space.  pm-utils can do that for one
example.

Thanks,
Rafael
