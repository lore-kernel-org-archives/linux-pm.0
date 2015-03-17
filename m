From: Tomeu Vizoso <tomeu.vizoso-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
Subject: [PATCH v6 0/8] Add support for Tegra Activity Monitor
Date: Tue, 17 Mar 2015 10:36:10 +0100
Message-ID: <1426584991-11110-1-git-send-email-tomeu.vizoso@collabora.com>
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Mikko Perttunen <mikko.perttunen-/1wQRMveznE@public.gmane.org>, Tomeu Vizoso <tomeu.vizoso-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Kyungmin Park <kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, MyungJoo Ham <myungjoo.ham-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Peter De Schrijver <pdeschrijver-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Prashant Gaikwad <pgaikwad-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Hello,

something happened during the last cycle and an old version of the devfreq
driver was merged.

This thread contains patches that bring it up to date to the last submitted
version and also incorporates the feedback that that version received, plus
some other small fixes and improvements that came up during rebase and
testing.

These patches implement support for setting the rate of the EMC clock based on
stats collected from the ACTMON, a piece of hw in the Tegra124 that counts
memory accesses (among others).

It depends on the following in-flight patches:

* EMC driver: http://thread.gmane.org/gmane.linux.kernel/1907035
* CPUFreq driver: http://thread.gmane.org/gmane.linux.kernel/1897078

I have pushed a branch here for testing:

http://cgit.collabora.com/git/user/tomeu/linux.git/log/?h=actmon-v6

Regards,

Tomeu

Tomeu Vizoso (8):
  of: Add binding for NVIDIA Tegra ACTMON node
  PM / devfreq: tegra: Update to v5 of the submitted patches
  clk: tegra: Have EMC clock implement determine_rate()
  PM / devfreq: tegra: Use clock rate constraints
  PM / devfreq: tegra: remove operating-points
  PM / devfreq: tegra: Set drvdata before enabling the irq
  PM / devfreq: tegra: Enable interrupts after resuming the devfreq
    monitor
  ARM: tegra: Add Tegra124 ACTMON support

 .../devicetree/bindings/arm/tegra/actmon.txt       |  28 ++
 arch/arm/boot/dts/tegra124.dtsi                    |  11 +
 drivers/clk/tegra/clk-emc.c                        |  19 +-
 drivers/devfreq/tegra-devfreq.c                    | 480 +++++++++++----------
 4 files changed, 316 insertions(+), 222 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/tegra/actmon.txt

-- 
2.1.0
