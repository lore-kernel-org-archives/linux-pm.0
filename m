From: Frans Klaver <frans.klaver-MHHw4NDrbWwAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 00/13] ltc2952 modernization and new functionality
Date: Wed, 22 Oct 2014 16:30:57 +0200
Message-ID: <1413988270-28092-1-git-send-email-frans.klaver@xsens.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Frans Klaver <frans.klaver-MHHw4NDrbWwAvxtiuMwx3w@public.gmane.org>, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, =?UTF-8?q?Ren=C3=A9=20Moll?= <linux-93MfrKQ0iTlmR6Xm/wNWPw@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

Hi there,

Apparently I missed the fact that version 2 [1] of the ltc2952 driver had already
been queued, so here's a series that implements most of the changes that I
already did in v3..5 [2] of the driver.

This series implements devm_* usage, reduction of globals, some cleanup and
finally makes the input trigger optional.

>From the changes to the previous submissions I did not include renaming kill to
poweroff.  The name poweroff is already used a lot. Besides that, the control
is referred to as kill in the ltc2952 datasheet.

Thanks,
Frans

[1] http://comments.gmane.org/gmane.linux.power-management.general/48312
[2] https://lkml.org/lkml/2014/10/13/104

Frans Klaver (13):
  power: reset: ltc2952: prefer devm_kzalloc over kzalloc
  power: reset: ltc2952: prefer devm_request_irq over request_irq
  power: reset: ltc2952: unroll gpio_desc array
  power: reset: ltc2952: prefer devm_gpiod_get over gpiod_get
  power: reset: ltc2952: reduce dependency on global variables
  power: reset: ltc2952: remove global variable poweroff_panic
  power: reset: ltc2952: drop empty suspend/resume functions
  power: reset: ltc2952: cleanup control flow in poweroff_handler
  power: reset: ltc2952: remove C++ style function pointers
  power: reset: ltc2952: disable timers in _remove
  power: reset: ltc2952: check trigger value before starting timer
  power: reset: ltc2952: make trigger input optional
  power: reset: ltc2952: document optional trigger behavior

 .../bindings/power/reset/ltc2952-poweroff.txt      |  13 +-
 drivers/power/reset/ltc2952-poweroff.c             | 290 +++++++++------------
 2 files changed, 129 insertions(+), 174 deletions(-)

-- 
2.1.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
