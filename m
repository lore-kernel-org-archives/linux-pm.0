From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH v2] runtime pm: add sysfs debug files
Date: Thu, 15 Apr 2010 14:33:02 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1004151429340.1562-100000@iolanthe.rowland.org>
References: <20100415174704.GA31336@comet.dominikbrodowski.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100415174704.GA31336@comet.dominikbrodowski.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Thu, 15 Apr 2010, Dominik Brodowski wrote:

> Alan,
> 
> many thanks for your comments!
> 
> On Sun, Apr 11, 2010 at 02:54:56PM -0400, Alan Stern wrote:
> > > +	if (dev->power.disable_depth)
> > > +		return sprintf(buf, "disabled\n");
> > > +	if (dev->power.runtime_auto == false)
> > > +		return sprintf(buf, "forbidden\n");
> > 
> > The logic here isn't right.  A "disabled" device can be either 
> > suspended or active.  The same holds for a "forbidden" device 
> > (although the suspended-and-forbidden combination would be rather 
> > unusual).  And a device can be both "disabled" and "forbidden".
> 
> Might it be better to move this to a different file, then?

Yes.  The revised patch is better.

> > In addition, you need to check for the runtime error state.  In this 
> > state, a device is neither active nor suspended.
> 
> Okay. Is the check I added sufficient?

Yes.

> > > +static DEVICE_ATTR(runtime_usage, 0444, usagecount_show, NULL);
> > > +static DEVICE_ATTR(runtime_children, 0444, children_show, NULL);
> > 
> > "runtime_children" seems like a slightly odd name.  It isn't the number 
> > of children; it's the number of _active_ children.  But I don't have 
> > any suggestions for a better name.
> 
> What about "runtime_active_kids"?

Okay.  The name doesn't have to be superb since it's only for 
debugging.

> From: Dominik Brodowski <linux@dominikbrodowski.net>
> Date: Sun, 11 Apr 2010 15:56:49 +0200
> Subject: [PATCH] runtime pm: add sysfs debug files
> 
> Add a few sysfs files relating to runtime power management for
> advanced debug purposes:
> 
> runtime_enabled: is runtime PM enabled for this device? States
> 	are "enabled", "disabled", "forbidden" or a combination
> 	of the latter two.
> 
> runtime_status:	what state is the device in currently? E.g., it
> 	reports "suspended" for runtime-suspended devices, and
>         "active" for active devices. NOTE: if runtime_enabled
> 	returns "disabled", the value of this file may not
> 	reflect its physical state.
> 
> runtime_usage: the runtime PM usage count of a device
> 
> runtime_active_kids: the runtime PM children usage count of a device, or
> 	0 if the ignore_children flag is set.
> 
> Also, CONFIG_PM_SLEEP_ADVANCED_DEBUG is not defined in any Kconfig
> file, so replace it with CONFIG_PM_ADVANCED_DEBUG.
> 
> Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>

Acked-by: Alan Stern <stern@rowland.harvard.edu>
