From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: calling runtime PM from system PM methods
Date: Thu, 2 Jun 2011 10:18:06 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1106021010360.1913-100000__39672.1944715411$1307024445$gmane$org@iolanthe.rowland.org>
References: <87k4d55c8k.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <87k4d55c8k.fsf@ti.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Kevin Hilman <khilman@ti.com>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wed, 1 Jun 2011, Kevin Hilman wrote:

> In the process of experimenting with other solutions, I found an
> interesting discovery:
> 
> In the driver's ->suspend() hook, I did something like this:
> 
> 	priv->forced_suspend = false;
> 	if (!pm_runtime_suspended(dev)) {
> 		pm_runtime_put_sync(dev);
> 		priv->forced_suspend = true;
> 	}
> 
> and in the resume hook I did this:
> 
> 	if (priv->forced_suspend)
> 		pm_runtime_get_sync(dev);
> 
> Even after disabling runtime PM from userspace via
> /sys/devices/.../power/control, the ->suspend() hook triggered an actual
> transition.  This is because pm_runtime_forbid() just uses the usage
> counter, so the _put_sync() in the ->suspend callback decrements the
> counter and triggers an rpm_idle().   Is this expected behavior?

Not really.  In fact it is a bug in your experimental code -- you are
decrementing the usage counter in a context where you did not
previously increment it.  In principle, the counter might already be 0
when the suspend hook runs.

Yes, it is indeed possible for a device to be active while the usage
counter is 0.  For example (assuming the counter is initially 0), this
will happen if you call

	pm_runtime_get_sync(dev);
	pm_runtime_put_noidle(dev);

or even if you simply call

	pm_runtime_resume(dev);

Of course, the drivers you're talking about may never do this.  Still, 
it's a logical mistake to do a *_put without previously doing a *_get.

Alan Stern
