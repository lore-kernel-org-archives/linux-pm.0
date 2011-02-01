From: Kevin Hilman <khilman@ti.com>
Subject: Re: [RFC][PATCH] Power domains for platform bus type
Date: Mon, 31 Jan 2011 16:17:02 -0800
Message-ID: <878vy01udd.fsf__26242.4528752037$1296519515$gmane$org@ti.com>
References: <201101300107.19389.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201101300107.19389.rjw@sisk.pl> (Rafael J. Wysocki's message of
	"Sun, 30 Jan 2011 01:07:19 +0100")
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
Cc: LKML <linux-kernel@vger.kernel.org>, Grant Likely <grant.likely@secretlab.ca>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

"Rafael J. Wysocki" <rjw@sisk.pl> writes:

> Hi,
>
> This is something we discussed during the last Linux Plumbers Conference.
>
> The problem appears to be that the same device may be used in different
> systems in different configurations such that actions necessary for the
> device's power management can vary from one system to another.  In those
> cases the drivers' power management callbacks are generally not sufficient,
> because they can't take the configuration of the whole system into account.
>
> I think this issue may be addressed by adding objects that will represent
> power domains and will provide power management callbacks to be executed
> in addition to the device driver's PM callbacks, which is done by the patch
> below.
>
> Please have a look at it and tell me what you think.
>

FYI... I just tested this patch on OMAP by converting our existing use
of platform_bus_set_ops() to use this approach by adding a powerdomain
to each omap_device.   

Note we're currently only overriding the runtime_[suspend|resume]
methods, so those are the only paths I've tested.

Kevin
