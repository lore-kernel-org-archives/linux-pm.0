From: Jonathan Tinkham <sctincman-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 0/3] power: bq24735-charger: chromebook fixes
Date: Tue,  2 Feb 2016 23:03:43 -0700
Message-ID: <1454479426-6437-1-git-send-email-sctincman@gmail.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, Jonathan Tinkham <sctincman-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Acer Chromebook 13 (CB5-311) this module fails to load if the charger
is not inserted, and will error when it is removed.

These fixes are adapted from Acer's downstream kernel.

Jonathan Tinkham (3):
  power: bq24735-charger: fix failed i2c with ac-detect
  power: bq24735-charger: add 'ti,external-control' option
  power: bq24735-charger: document 'ti,external-control' option

 .../bindings/power_supply/ti,bq24735.txt           |  3 ++
 drivers/power/bq24735-charger.c                    | 56 ++++++++++++++--------
 include/linux/power/bq24735-charger.h              |  2 +
 3 files changed, 40 insertions(+), 21 deletions(-)

-- 
2.7.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
