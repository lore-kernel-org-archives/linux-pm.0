From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: subtle pm_runtime_put_sync race and sdio functions
Date: Sat, 18 Dec 2010 23:52:10 +0100
Message-ID: <201012182352.10765.rjw__26783.2862599336$1292712810$gmane$org@sisk.pl>
References: <AANLkTikJr+0kVPE4aSwPjZWRfA3gRSNgGwzQdSwRpo_5@mail.gmail.com>
	<1292690407.3653.2.camel@jlt3.sipsolutions.net>
	<AANLkTin6zdUb2C-3GU-FySb3Pmk5iHaG5neLNSG38Tdx@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTin6zdUb2C-3GU-FySb3Pmk5iHaG5neLNSG38Tdx@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: linux-mmc@vger.kernel.org, linux-wireless@vger.kernel.org, Ido Yariv <ido@wizery.com>, Johannes Berg <johannes@sipsolutions.net>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Saturday, December 18, 2010, Ohad Ben-Cohen wrote:
> On Sat, Dec 18, 2010 at 6:40 PM, Johannes Berg
> <johannes@sipsolutions.net> wrote:
> > On Sat, 2010-12-18 at 18:00 +0200, Ohad Ben-Cohen wrote:
> >
> >> > That's where the problem is.  If there's a difference, from the driver's
> >> > point of view, between suspend and some other operation, there should be a
> >> > way to tell the driver what case it actually is dealing with.
> >>
> >> Yes, the problem will be solved if the driver would bypass the runtime
> >> PM framework on system suspend. mac80211 obviously has this
> >> information, and technically it's very easy to let the driver know
> >> about it.
> >>
> >> But the difference between suspend and normal operation is really
> >> artificial: in both cases mac80211 just asks the driver to power its
> >> device down, and the end result is exactly the same (a GPIO line of
> >> the device is de-asserted in our case). The difference between these
> >> two scenarios
> >> exist only because runtime PM is effectively disabled during system
> >> suspend, and therefore the driver has to look for an alternative way
> >> to power down the device.
> >
> > Sounds to me like the difference isn't really in the driver, but the
> > core PM subsystem. Why does it care when powering off a device whether
> > it's during suspend, or during runtime?
> 
> Agree.
> 
> If we can add a dev_pm_info bit, that would allow using runtime PM API
> during suspend/resume transitions, the driver will not have to care.
> 
> Rafael what do you think ? Is that totally unacceptable ?

Already said.  It is not acceptable at all.

Thanks,
Rafael
