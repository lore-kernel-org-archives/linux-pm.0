From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 0/8] mfd/power/phy: Add support for otg vbus detection via axp pmic
Date: Tue,  9 Jun 2015 23:37:53 +0200
Message-ID: <1433885881-19809-1-git-send-email-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:55845 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751748AbbFIViS (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 9 Jun 2015 17:38:18 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Kishon Vijay Abraham I <kishon@ti.com>, Felipe Balbi <balbi@ti.com>, Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: =?UTF-8?q?Bruno=20Pr=C3=A9mont?= <bonbons@linux-vserver.org>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree <devicetree@vger.kernel.org>, linux-sunxi@googlegroups.com

Hi All,

Here is a series which adds the beginning of power-supply support to
the axp20x pmic code. My primary reason for working on this is to
enable the use of the usb power-supply bits in the pmic to for vbus
detection on boards which do not have a vbus-det gpio, and instead
rely on the pmic for vbus detection.

After I had written most of the vbus power-supply driver code I
became aware of Bruno Pr=C3=A9mont's (in the CC) previous work on this
our drivers are mostly the same, and I've borrowed some code from
his driver to add support for min-volt / max-curr properties.

The big difference between our 2 drivers is that mine driver uses
a devicetree child node / mfd cell per power-supply, so one for
each of the usb-power, ac-power / battery-charger and rtc-backup-bat-ch=
arger
bits.

Depending on the board each of those must be enabled / disabled separat=
ely
in devicetree as most boards do not use all 4. So in dt each one needs =
its
own child-node of the axp20x node. Another reason for using separate ch=
ild
nodes for each is so that other devicetree nodes can have a power-suppl=
y
property with a phandle referencing a node representing a single
power-supply.

Regards,

Hans
