From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: subtle pm_runtime_put_sync race and sdio functions
Date: Sat, 18 Dec 2010 17:12:10 +0200
Message-ID: <AANLkTimWKQQ8cCZJ+=R+v2HUtoq8wRZsRA5+O9wghuRJ__38382.8921862461$1292685202$gmane$org@mail.gmail.com>
References: <AANLkTikJr+0kVPE4aSwPjZWRfA3gRSNgGwzQdSwRpo_5@mail.gmail.com>
	<Pine.LNX.4.44L0.1012110937100.10743-100000@netrider.rowland.org>
	<AANLkTi=32bqipN5U00La-B7JSgTC1bHgMev=xUSF6kRN@mail.gmail.com>
	<4D0CC23E.6000509@csr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4D0CC23E.6000509@csr.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: David Vrabel <david.vrabel@csr.com>
Cc: linux-mmc@vger.kernel.org, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Ido Yariv <ido@wizery.com>
List-Id: linux-pm@vger.kernel.org

On Sat, Dec 18, 2010 at 4:16 PM, David Vrabel <david.vrabel@csr.com> wrote:
...
> It may be useful if you
> describe the wi-fi chip's operational or power states and the valid
> transitions between them.

Sure.

When powered up initially, the device is a standard SDIO device that
responds to bus transactions.

Soon after being initialized (firmware download, configuration,
etc..), the device is put at a quiescent state by the driver, and
therefore the driver has to be explicitly wake it up before any SDIO
communication takes place.

Toggling the device's power down and up again brings it back to the
fully active state.

> 2. The resume handler fails because it cannot distinguish between a
> wi-fi chip that needs reinitializing from power-on and one that is
> already operational?

Yes. But please note that it's not the driver's resume handler, it's
just regular driver code that powers up the device and reinitializes
it (that happens to be called by mac80211's resume handler here, but
otherwise is the regular code that powers up the device and
initializes when the user brings up the wlan interface).

> There is probably a chip register you can query to
> determine if the chip was powered down or reset. =A0In the absense of any
> suitable chip-specific register a CCCR register such as I/O Enable might
> be usable.

That's a problem: without knowing if the device was powered off or
not, the driver will have to do some guess work, where an SDIO error
would indicate that the device was powered on all along (and therefore
just needs to be waken up). That's not pretty: even if that didn't
involve bus errors, it means adding a bus transaction just to tell
between two different legitimate software paths (we would also need to
add code that would reset the device state in case it wasn't powered
off. Usually the driver assumed it can just power off the device, but
if that's not the case anymore, the driver will have to do that
differently. We never tried that so I can't tell if it'd be trivial or
not, but I'm concerned because usually untested device scenarios tend
to be quirky...).

Thanks,
Ohad.
