From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: subtle pm_runtime_put_sync race and sdio functions
Date: Wed, 29 Dec 2010 08:34:25 +0200
Message-ID: <AANLkTikrd3JpBG4JYUUxQhPPNhSmJaE5j5ozz=_vpU52__16743.6662632555$1293604562$gmane$org@mail.gmail.com>
References: <AANLkTim7pGtO=vjKmA_3O74Kwvio124cgoaMeUSB70dW@mail.gmail.com>
	<Pine.LNX.4.44L0.1012281541580.22998-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1012281541580.22998-100000@netrider.rowland.org>
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
Cc: linux-wireless@vger.kernel.org, linux-mmc@vger.kernel.org, Ido Yariv <ido@wizery.com>, linux-pm@lists.linux-foundation.org, Johannes Berg <johannes@sipsolutions.net>
List-Id: linux-pm@vger.kernel.org

On Tue, Dec 28, 2010 at 11:46 PM, Alan Stern <stern@rowland.harvard.edu> wr=
ote:
> What's the relation between mmc_power_off() and mmc_power_save_host()?

Essentially they are the same - mmc_power_off() is the one that
actually powers off the card.

mmc_power_save_host() just invokes first a bus-specific ->power_save()
handler (if one exists).

> Does one merely go into a low-power state whereas the other does the
> complete-power-off reset?

No, think of them as the same. Both will lead to a complete power off.
The mmc_power_off() is just an internal function which belongs to the
MMC core.

> During wlan-interface-down, it's not necessary to reduce the power
> level; it's merely desirable. =A0That's exactly the sort of thing runtime
> PM is meant for. =A0Hence the existing call to pm_runtime_put_sync() is
> sufficient.

Not exactly - think of airplane mode, where we must ensure the radios
are disabled, without being blocked by /sys/devices/.../power/control
- we will need to bypass runtime PM in this scenario too.

> Put it another way: =A0Suppose an SDIO card has more than one function
> and you need to reset the wl1271 function. =A0It sounds like there's no
> way to do this without resetting the other functions as well. =A0What
> happens if another function's driver is busy and can't allow a reset
> just then?

That's a chip specific thing. In our case, there is no other active
SDIO function.

Other vendors which does employ several SDIO functions have a separate
reset for each function _in addition_ to the power line. So for them
the runtime PM model is just great - they never care if the actual
power is down or not - it's really just about power consumption, and
nothing else. When they need an unconditional reset, they just use the
appropriate reset line.

In our case we have a single control for both power and reset
functionality (actually we do have a separate power line to the
device, but it is not controlled by software - it is fed directly from
the battery rail).
