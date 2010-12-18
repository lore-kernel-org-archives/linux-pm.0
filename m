From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: subtle pm_runtime_put_sync race and sdio functions
Date: Sat, 18 Dec 2010 23:50:55 +0100
Message-ID: <201012182350.55544.rjw__17045.2523547739$1292712731$gmane$org@sisk.pl>
References: <AANLkTikJr+0kVPE4aSwPjZWRfA3gRSNgGwzQdSwRpo_5@mail.gmail.com>
	<AANLkTin23vbbA7+UDzh=v060HbkLMrJjB38cs+AWScPJ@mail.gmail.com>
	<1292690407.3653.2.camel@jlt3.sipsolutions.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1292690407.3653.2.camel@jlt3.sipsolutions.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, linux-mmc@vger.kernel.org, Ido Yariv <ido@wizery.com>
List-Id: linux-pm@vger.kernel.org

On Saturday, December 18, 2010, Johannes Berg wrote:
> On Sat, 2010-12-18 at 18:00 +0200, Ohad Ben-Cohen wrote:
> 
> > > That's where the problem is.  If there's a difference, from the driver's
> > > point of view, between suspend and some other operation, there should be a
> > > way to tell the driver what case it actually is dealing with.
> > 
> > Yes, the problem will be solved if the driver would bypass the runtime
> > PM framework on system suspend. mac80211 obviously has this
> > information, and technically it's very easy to let the driver know
> > about it.
> > 
> > But the difference between suspend and normal operation is really
> > artificial: in both cases mac80211 just asks the driver to power its
> > device down, and the end result is exactly the same (a GPIO line of
> > the device is de-asserted in our case). The difference between these
> > two scenarios
> > exist only because runtime PM is effectively disabled during system
> > suspend, and therefore the driver has to look for an alternative way
> > to power down the device.
> 
> Sounds to me like the difference isn't really in the driver, but the
> core PM subsystem. Why does it care when powering off a device whether
> it's during suspend, or during runtime?

The problem is that the driver is using something it shouldn't use for
the particular purpose.  Plain and simple.

Namely, it uses the runtime PM _framework_ (which has specific and _documented_
limitations) for general power management of the device it handles.  It is
wrong and it has nothing to do with the PM subsystem.

Thanks,
Rafael
