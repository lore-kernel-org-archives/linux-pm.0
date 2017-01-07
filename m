From: Krzysztof Kozlowski <krzk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 0/4] ARM: exynos: Fix Odroid U3 USB/LAN when TFTP booting (power sequence)
Date: Sat,  7 Jan 2017 10:51:59 +0200
Message-ID: <20170107085203.4431-1-krzk@kernel.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Krzysztof Kozlowski <krzk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>, Anand Moon <linux.amoon-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Sylwester Nawrocki <s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Peter Chen <peter.chen-3arQi8VN3Tc@public.gmane.org>, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, hverkuil-qWit8jRvyhVmR6Xm/wNWPw@public.gmane.org, Markus Reichl <m.reichl-SRyzfwRm/0rPTwkrwQOX7A@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Hi,

Thanks to Markus Reichl, I got an Odroid U3 to work with. Thanks to Peter
Chen, we got a power sequence generic library which solves my long
standing Odroid U3 problem - no LAN9730 if it was enabled by bootloader.

My previous attempts for this can be found here [0].

This patchset is based on Peter's v11 of power sequence [1].
Patchset is available also on my Github [2].

More detailed analysis is described in patch 2/4 ("ARM: dts: exynos: Fix
LAN9730 on Odroid U3 after tftpboot").


Best regards,
Krzysztof


[0] http://www.spinics.net/lists/linux-mmc/msg37386.html
[1] https://lwn.net/Articles/710736/
[2] https://github.com/krzk/linux/commits/for-next/odroid-u3-usb3503-pwrseq

Krzysztof Kozlowski (4):
  ARM: dts: exynos: Fix indentation of EHCI and OHCI ports
  ARM: dts: exynos: Fix LAN9730 on Odroid U3 after tftpboot
  ARM: exynos_defconfig: Enable power sequence for Odroid U3
  ARM: multi_v7_defconfig: Enable power sequence for Odroid U3

 arch/arm/boot/dts/exynos4.dtsi            | 24 ++++++++++++------------
 arch/arm/boot/dts/exynos4412-odroidu3.dts | 21 +++++++++++++++++++++
 arch/arm/configs/exynos_defconfig         |  2 ++
 arch/arm/configs/multi_v7_defconfig       |  1 +
 4 files changed, 36 insertions(+), 12 deletions(-)

-- 
2.9.3

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
