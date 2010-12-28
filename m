From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: subtle pm_runtime_put_sync race and sdio functions
Date: Tue, 28 Dec 2010 21:15:27 +0200
Message-ID: <AANLkTinewad6YxXvn5gnJQ+HJn41Sg96319GQn9KRKWj__42442.8904000253$1293563891$gmane$org@mail.gmail.com>
References: <AANLkTimj0E3Rz_8WQrU4wGg3ONyXzkUT9+U3Xqz7Cq0X@mail.gmail.com>
	<201012261245.29680.rjw@sisk.pl>
	<AANLkTinvBD6NhHY7PMw9NSJNBW77-Gah8Vcow6t1aiCT@mail.gmail.com>
	<201012261937.21256.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201012261937.21256.rjw@sisk.pl>
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

On Sun, Dec 26, 2010 at 8:37 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> So, it only happens during asynchronous suspend? =A0In other words, if su=
spend
> is synchronous, everything should be fine, right?

Not necessarily.

Consider this simple scenario, where a device was added after the mmc
host controller, but before mac80211. In this case its suspend handler
will have the chance to abort system suspend after mac80211 already
told our driver to power down the device (but the device wasn't
powered down yet, because the driver used pm_runtime_put_sync() which
is disabled).

Thanks,
Ohad.
