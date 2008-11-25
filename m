From: Deepak Saxena <dsaxena@plexity.net>
Subject: Re: [RFC] Tying sysfs "wakeup" file
	to	platform-level?handler
Date: Tue, 25 Nov 2008 12:38:37 -0800
Message-ID: <20081125203837.GA5449@trantor.hsd1.or.comcast.net>
References: <20081125191929.GA4692@trantor.hsd1.or.comcast.net>
	<Pine.LNX.4.44L0.0811251513320.2457-100000@iolanthe.rowland.org>
Reply-To: dsaxena@plexity.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0811251513320.2457-100000@iolanthe.rowland.org>
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
Cc: linux-pm@lists.linux-foundation.org, Chris Ball <cjb@laptop.org>, Andres Salomon <dilinger@queued.net>
List-Id: linux-pm@vger.kernel.org

On Nov 25 2008, at 15:18, Alan Stern was caught saying:
> On Tue, 25 Nov 2008, Deepak Saxena wrote:
> 
> > The sideband signal is a gpio. The driver knows that the GPIO exists,
> > but it does not know that it anything about it is routed on the board
> > IMHO it should not.
> 
> It's a difficult problem.  You've essentially got a platform device on 
> the USB bus.
> 
> > > The easiest answer is for the driver to call directly into the platform code.
> > 
> > Agreed, and there are several ways to do this: 
> > 
> > One is to do wrap code around #ifdef and if(machine_is_olpc()) to make
> > a call to an OLPC-specific call.
> > 
> > The other is to add a generic platform wakeup hook mechanism such as
> > either my original proposal or adding a set_wakeup() to struct device
> > itself. Another option is to have a single platform_set_wakeup()
> > pointer similar to the platform_notify() and platform_notify_remove().
> 
> I'm not sure...  This sort of thing isn't something I've had to deal 
> with before.

I'm going to throw a patch togethre and post it here and on lkml for
vetting and we can go from there.

> Suppose the same sort of WLAN interface was packaged as an independent,
> external USB device and one of them was plugged into an OLPC.  Then how
> would you know which device was the one attached to the embedded
> controller and which was external?

I think in that case we couldn't really do WOL. I imagine this is the
case on a standard laptop too. On future XO versions, we may move to
an SDIO based card and we will have to deal with the same situation
where the SDIO stack has a concept of wake up on card insert/remove
but we will need to route the WOL signal from the card to the EC.

~Deepak

-- 
 Deepak Saxena  http://www.greenbasement.info
   _____   __o  Kernel Hacker, One Laptop Per Child  (o>
------    -\<,  Give One Laptop, Get One Laptop      //\
 ----- ( )/ ( ) http://www.amazon.com/xo             V_/_
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
