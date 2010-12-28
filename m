From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: subtle pm_runtime_put_sync race and sdio functions
Date: Tue, 28 Dec 2010 21:34:09 +0200
Message-ID: <AANLkTinPrUbaFsNMmoZJtOaF6dutLaXXQ7Uws5826n4=__17439.834928564$1293564920$gmane$org@mail.gmail.com>
References: <AANLkTimj0E3Rz_8WQrU4wGg3ONyXzkUT9+U3Xqz7Cq0X@mail.gmail.com>
	<201012261935.13238.rjw@sisk.pl>
	<AANLkTimHHN+GesyhR6Jjnm771XLhn=inn=vrSk=mT6Mh@mail.gmail.com>
	<201012282021.31695.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201012282021.31695.rjw@sisk.pl>
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
Cc: linux-wireless@vger.kernel.org, linux-mmc@vger.kernel.org, Ido Yariv <ido@wizery.com>, linux-pm@lists.linux-foundation.org, Johannes Berg <johannes@sipsolutions.net>
List-Id: linux-pm@vger.kernel.org

On Tue, Dec 28, 2010 at 9:21 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> It looks like you could simply do a power down-power up cycle before tryi=
ng to
> load new firmware, just in case. =A0I guess that's suboptimal for some re=
ason?

It would work, but we will not be able to unconditionally disable the
radios (e.g. airplane mode comes to mind).

> Please pretend that the runtime PM framework doesn't exist for a while. =
=A0How
> would you design things in that case?

Duplicate most of runtime-PM's plumbing into the MMC/SDIO subsystem.
Off the top of my hat:
- We need the device hierarchy and the suspend/resume dependencies (a
single SDIO card has several logical sub-devices, a.k.a SDIO
functions)
- We need to maintain usage_count for each device, and expose the same
API to handle it
- We need autosuspend for MMC cards (power them off on inactivity)
- We need the same, or similar, locking plumbing
- We probably need the same sysfs ABI as well: autosuspend_delay_ms,
and even  /sys/devices/.../power/control itself is useful (not for our
device, but for others, sure)
- ...

Thanks,
Ohad.
