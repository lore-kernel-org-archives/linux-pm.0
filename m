From: Jon Mason <jon.mason-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Subject: [RFC 0/3] thermal: broadcom: complete and extend to NSP
Date: Thu, 23 Mar 2017 15:18:45 -0400
Message-ID: <1490296728-14733-1-git-send-email-jon.mason@broadcom.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org
List-Id: linux-pm@vger.kernel.org

This patch series is intended to complete the implementation submitted
in http://www.spinics.net/lists/devicetree/msg168813.html
It lacked the Kconfig select options and DT bindings for BCM5301X.
Also, it did not allow for NSP to be selected.  This series addresses
that.

I'm sending this as an RFC, as that series has not been included (or
reviewed) yet.  If Rafal wants to include these in a v2 of his series,
then I am agreeable with that.


Jon Mason (3):
  thermal: broadcom: Allow for NSP to use ns-thermal driver
  ARM: dts: NSP: Add Thermal Support
  ARM: dts: BCM5301X: Add Thermal Support

 arch/arm/boot/dts/bcm-nsp.dtsi   | 15 +++++++++++++++
 arch/arm/boot/dts/bcm5301x.dtsi  | 15 +++++++++++++++
 arch/arm/mach-bcm/Kconfig        |  2 ++
 drivers/thermal/broadcom/Kconfig |  2 +-
 4 files changed, 33 insertions(+), 1 deletion(-)

-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
