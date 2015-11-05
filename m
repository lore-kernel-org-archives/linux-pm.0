From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 0/5] PM / OPP: opp-supported-hw and <prop>-name bindings
Date: Thu,  5 Nov 2015 07:11:51 +0530
Message-ID: <cover.1446687367.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:33963 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932797AbbKEBmH (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 4 Nov 2015 20:42:07 -0500
Received: by padhx2 with SMTP id hx2so62043354pad.1
        for <linux-pm@vger.kernel.org>; Wed, 04 Nov 2015 17:42:07 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, robh+dt@kernel.org, sboyd@codeaurora.org, lee.jones@linaro.org
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, mark.rutland@arm.com, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, nm@ti.com, devicetree@vger.kernel.org, b.zolnierkie@samsung.com, m.szyprowski@samsung.com, Viresh Kumar <viresh.kumar@linaro.org>

Hi Rafael,

All the bindings are Reviewed by Stephen now and Rob didn't had a
problem with them (though he didn't Ack them separately yet) :)

The first patch enables us to select only a subset of OPPs from the
bigger table, based on what version of the hardware we are running on.

The second one enables us to select slightly different values for
multiple properties, based on what kind of hardware they are running on.

The third one removes an (unused) binding, which is replaced by the
second patch with a better solution.

The fourth patch is based on what Stephen suggested (and then reviewed)
in the earlier series, and the 5th one updates the existing users of
these bindings for it.

Viresh Kumar (5):
  PM / OPP: Add "opp-supported-hw" binding
  PM / OPP: Add
    {opp-microvolt|opp-microamp|turbo-mode|opp-suspend}-<name> binding
  PM / OPP: Remove 'operating-points-names' binding
  PM / OPP: Rename OPP nodes as opp@<opp-hz>
  ARM: dts: exynos4412: Rename OPP nodes as opp@<opp-hz>

 Documentation/devicetree/bindings/opp/opp.txt | 143 +++++++++++++++++++-------
 arch/arm/boot/dts/exynos4412.dtsi             |  28 ++---
 2 files changed, 118 insertions(+), 53 deletions(-)

-- 
2.6.2.198.g614a2ac

