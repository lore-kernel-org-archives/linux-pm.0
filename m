From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC] Tying sysfs "wakeup" file to
	platform-level?handler
Date: Tue, 25 Nov 2008 15:18:29 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0811251513320.2457-100000@iolanthe.rowland.org>
References: <20081125191929.GA4692@trantor.hsd1.or.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20081125191929.GA4692@trantor.hsd1.or.comcast.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Deepak Saxena <dsaxena@plexity.net>
Cc: linux-pm@lists.linux-foundation.org, Chris Ball <cjb@laptop.org>, Andres Salomon <dilinger@queued.net>
List-Id: linux-pm@vger.kernel.org

On Tue, 25 Nov 2008, Deepak Saxena wrote:

> The sideband signal is a gpio. The driver knows that the GPIO exists,
> but it does not know that it anything about it is routed on the board
> IMHO it should not.

It's a difficult problem.  You've essentially got a platform device on 
the USB bus.

> > The easiest answer is for the driver to call directly into the platform code.
> 
> Agreed, and there are several ways to do this: 
> 
> One is to do wrap code around #ifdef and if(machine_is_olpc()) to make
> a call to an OLPC-specific call.
> 
> The other is to add a generic platform wakeup hook mechanism such as
> either my original proposal or adding a set_wakeup() to struct device
> itself. Another option is to have a single platform_set_wakeup()
> pointer similar to the platform_notify() and platform_notify_remove().

I'm not sure...  This sort of thing isn't something I've had to deal 
with before.

Suppose the same sort of WLAN interface was packaged as an independent,
external USB device and one of them was plugged into an OLPC.  Then how
would you know which device was the one attached to the embedded
controller and which was external?

> Note that in the OLPC tree we have some #ifdef OLPC in the wifi driver
> but those are not upstream and I'm going to work on removing them. I
> would prefer not to add anymore.

That's understandable.

Alan Stern
