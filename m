From: Caesar Wang <wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: [PATCH v2 0/2] fix the TSHUT issue on rockchip thermal
Date: Thu, 22 Oct 2015 09:25:28 +0800
Message-ID: <1445477130-17065-1-git-send-email-wxt@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Caesar Wang <wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

We need the OTP pin is gpio state before resetting the TSADC controller,
since the tshut polarity will generate a high signal.

Says:
The TSHUT temperature is setting more than 80 degree, the default
tshut polarity is HIGH.

If T > 80C, the OTP output the High Signal.
If T < 80C, the OTP output the Low Signal.

On the moment, the TSADC controller is reset, the tshut polarity will be
Low in a short period of time.

So:
If T < 80C, the OTP output the High Signal.
If T > 80C, the OTP output the Low Signal.

In some cases, the OTP pin is connected to the PMIC, maybe the PMIC can
accept the reset response time to avoid this issue.

In other words, the system will be always reboot if we make the OTP pin
is connected the others IC to control the power.

This series patchs are depend on Doug's patch.(https://patchwork.kernel.org/patch/7454311/)

This series patchs are based on the Linus master branch.

518cd44 ARM: dts: rockchip: Add the OTP gpio pinctrl
83e0bab dt-bindings: Add the "init" pinctrl in this document
150426c drivers/pinctrl: Add the concept of an "init" state
ce1fad2 Merge branch 'keys-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs
1099f86 Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/net
911b79c KEYS: Don't permit request_key() to construct a new keyring
37850e3 net: bcmgenet: Fix early link interrupt enabling
afc050d Merge tag 'wireless-drivers-for-davem-2015-10-17' of git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers
e277de5 tunnels: Don't require remote endpoint or ID during creation.
740dbc2 openvswitch: Scrub skb between namespaces
....

Tested on box board.


Changes in v2:
  - As the Rob comments, add the 'init' pinctrl more decription in document.
  - fix the subject to make more obvious in PATCH[1/2]
Series-changes: 1
  - As the Doug comments, add the 'init' property to sync document.
  - Add some commits for more obvious in PATCH[2/2]

Changes in v1:
  - As the Doug comments, drop the thermal driver patchs since
    we can with pinctrl changing to work.
  - As the Doug's patch to add the 'init' property.

Caesar Wang (2):
  dt-bindings: Add the "init" pinctrl in this document
  ARM: dts: rockchip: Add the OTP gpio pinctrl

 Documentation/devicetree/bindings/thermal/rockchip-thermal.txt | 5 +++--
 arch/arm/boot/dts/rk3288.dtsi                                  | 9 +++++++--
 2 files changed, 10 insertions(+), 4 deletions(-)

-- 
1.9.1
