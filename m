From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: subtle pm_runtime_put_sync race and sdio functions
Date: Wed, 29 Dec 2010 23:25:36 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1012292314280.13580-100000__6133.6864754141$1293683330$gmane$org@netrider.rowland.org>
References: <AANLkTikrd3JpBG4JYUUxQhPPNhSmJaE5j5ozz=_vpU52@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTikrd3JpBG4JYUUxQhPPNhSmJaE5j5ozz=_vpU52@mail.gmail.com>
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
Cc: linux-wireless@vger.kernel.org, linux-mmc@vger.kernel.org, Ido Yariv <ido@wizery.com>, linux-pm@lists.linux-foundation.org, Johannes Berg <johannes@sipsolutions.net>
List-Id: linux-pm@vger.kernel.org

On Wed, 29 Dec 2010, Ohad Ben-Cohen wrote:

> On Tue, Dec 28, 2010 at 11:46 PM, Alan Stern <stern@rowland.harvard.edu> =
wrote:
> > What's the relation between mmc_power_off() and mmc_power_save_host()?
> =

> Essentially they are the same - mmc_power_off() is the one that
> actually powers off the card.
> =

> mmc_power_save_host() just invokes first a bus-specific ->power_save()
> handler (if one exists).
> =

> > Does one merely go into a low-power state whereas the other does the
> > complete-power-off reset?
> =

> No, think of them as the same. Both will lead to a complete power off.
> The mmc_power_off() is just an internal function which belongs to the
> MMC core.

Then what routine does the power down without the full reset?

That's why you run into trouble, isn't it?  The device has been powered
down, but if the system sleep transition is aborted then the device
doesn't get reset (by mmc_power_save_host?), so you can't wake it up
again.

Also, what routine tries to do the failing wakeup, and what is its call
path?

> > During wlan-interface-down, it's not necessary to reduce the power
> > level; it's merely desirable. =A0That's exactly the sort of thing runti=
me
> > PM is meant for. =A0Hence the existing call to pm_runtime_put_sync() is
> > sufficient.
> =

> Not exactly - think of airplane mode, where we must ensure the radios
> are disabled, without being blocked by /sys/devices/.../power/control
> - we will need to bypass runtime PM in this scenario too.

I don't see why.  Turning off the radio is different from powering the =

device down -- you should be able to do the first without doing the =

second (although probably not vice versa).

Alan Stern
