From: Adriana Reus <adriana.reus-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 0/5] iio: light: us5281d: Add power managmenet and interrupt support
Date: Tue, 24 Nov 2015 12:59:47 +0200
Message-ID: <1448362792-5181-1-git-send-email-adriana.reus@intel.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org, lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org, Adriana Reus <adriana.reus-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

The first patches add a dt property for choosing the power mode for raw reads.
The following adds helper functions preparing for pm support.
The last ones add power management and interrupt support.

Adriana Reus (5):
  iio: light: us5182d: Add property for choosing default power mode
  Documentation: devicetree: Add property for controlling power saving
    mode for the us5182 als sensor
  iio: light: us5182d: Add functions for selectively enabling als and
    proximity
  iio: light: us8152d: Add power management support
  iio: light: us5182d: Add interrupt support and events

 .../devicetree/bindings/iio/light/us5182d.txt      |  11 +
 drivers/iio/light/us5182d.c                        | 513 ++++++++++++++++++++-
 2 files changed, 504 insertions(+), 20 deletions(-)

-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
