From: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH V8 0/3] OPP: Allow OPP table to be used for power-domains
Date: Mon, 18 Dec 2017 15:51:27 +0530
Message-ID: <cover.1513591822.git.viresh.kumar@linaro.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Viresh Kumar <vireshk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Vincent Guittot <vincent.guittot-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, rnayak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, sudeep.holla-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

Hi,

Now that the performance state of PM domains are supported by the kernel
(merged in linux-next), I am trying once again to define the bindings
which we dropped until the code is merged first.

Summary:

Power-domains can also have their active states and this patchset
enhances the OPP binding to define those.

The power domains can use the OPP bindings mostly as is. Though there
are some changes required to support special cases:

- Allow "operating-points-v2" to contain multiple phandles for power
  domain providers providing multiple domains.

- A new property "required-opp" is added for the devices to specify the
  minimum required OPP of the master domain or any other type of device.

- Allow some of the OPP properties to accept magic values (firmware
  dependent) as the OS doesn't know the real freq/voltage values.

V7->V8:
- V7 1/2 divided into two patches. 1/3 is unchanged from V7.
- 2/3 renamed the property from "power-domain-opp" to "required-opp", as
  suggested by Rob.
- Added Ulf's reviewed-by for 1/3 and 3/3.

--
viresh

Viresh Kumar (3):
  OPP: Allow OPP table to be used for power-domains
  OPP: Introduce "required-opp" property
  OPP: Allow "opp-hz" and "opp-microvolt" to contain magic values

 Documentation/devicetree/bindings/opp/opp.txt      | 19 +++++++
 .../devicetree/bindings/power/power_domain.txt     | 65 ++++++++++++++++++++++
 2 files changed, 84 insertions(+)

-- 
2.15.0.194.g9af6a3dea062

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
