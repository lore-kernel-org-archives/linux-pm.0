From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC][PATCH 1/3] PM: Introduce new top level suspend
	and	hibernation callbacks
Date: Fri, 21 Mar 2008 09:34:37 +1100
Message-ID: <1206052477.8420.26.camel__27163.6997619227$1206052705$gmane$org@pasglop>
References: <Pine.LNX.4.44L0.0803201412210.22752-100000@netrider.rowland.org>
Reply-To: benh@kernel.crashing.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0803201412210.22752-100000@netrider.rowland.org>
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
Cc: LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Alexey Starikovskiy <astarikovskiy@suse.de>
List-Id: linux-pm@vger.kernel.org


On Thu, 2008-03-20 at 14:26 -0400, Alan Stern wrote:
> 
> One of the things we don't want to do is bind a new driver to a device
> after it has gone through the prepare() stage.  Doing so would involve
> calling the driver's probe() routine, which is likely to want to
> register new children and who knows what else.  The probe routine might 
> even end up running after the device was suspended!  Clearly this 
> should be avoided.
> 
> But the user can force a binding to occur by writing the device's path
> to the driver's "bind" attribute in sysfs.  This means that
> driver_bind() in drivers/base/bus.c will need to know whether or not
> the device has gone through the prepare() stage, which means the device
> structure will need to have a flag set before prepare() is called (more 
> precisely, the flag must be set before dev->sem is released following 
> the call to prepare).
> 
> Either that or else driver_bind() must always block whenever a system
> sleep is in progress.  That would be easier -- but it's a lot like what 
> the freezer would do.  Which would you prefer?

I don't fully understand what you are saying here.

You say "bind a new driver to a device after it has gone through the
prepare() stage"

So either there was already a driver bound to that device, which got a
prepare() callback, and in which case bind() doesn't mean much. Or there
was not, in which case there was no prepare() call involved.

I suppose if you prepare(), then unbind(), then something tries to
bind()... But wouldn't the core flag set after prepare() be plenty
enough to shield against that ?

I fail to see the race you are talking about here.

Ben.
