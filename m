From: Ladislav Michl <ladis-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>
Subject: [PATCH v6 0/3] power: supply: ltc2941-battery-gauge: Support LTC2942
 and LTC2944
Date: Sun, 16 Jul 2017 11:32:02 +0200
Message-ID: <20170716093202.vfea4yylbzfec72v@lenoch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Mike Looijmans <mike.looijmans-Oq418RWZeHk@public.gmane.org>, Dragos Bogdan <dragos.bogdan-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>, Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

This is the 6th version of patch.
Changelog:
- v2: reworked voltage computing to not overflow and keep precision
- v3: update devicetree binding documentation
- v4: add ltc2942 devicetree compatible
- v5: reworked to incorporate Dragos' LTC2944 patch
- v6: fix missing break in the switch statement, move LTC2942 and LTC2944
      id definitions into respective patches
 
LTC2942 is pin compatible with LTC2941 providing few more registers
holding information about battery voltage and temperature. It can
be runtime detected using bit A7 in the Status register.

LTC2944 is compatible with LTC2943, but uses different
voltage and current computing constants.

Comments welcome,
	ladis
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
