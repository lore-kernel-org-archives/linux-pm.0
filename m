From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [RFC V7 0/2] OPP: Allow OPP table to be used for power-domains
Date: Tue, 31 Oct 2017 18:17:01 +0530
Message-ID: <cover.1509453284.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:45140 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751746AbdJaMrT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 31 Oct 2017 08:47:19 -0400
Received: by mail-pg0-f68.google.com with SMTP id b192so14574384pga.2
        for <linux-pm@vger.kernel.org>; Tue, 31 Oct 2017 05:47:19 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: ulf.hansson@linaro.org, Kevin Hilman <khilman@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Rafael Wysocki <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Stephen Boyd <sboyd@codeaurora.org>, Nishanth Menon <nm@ti.com>, Vincent Guittot <vincent.guittot@linaro.org>, robh+dt@kernel.org, rnayak@codeaurora.org, sudeep.holla@arm.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Viresh Kumar <vireshk@kernel.org>

Hi,

Now that the performance state of PM domains are supported by the kernel
(merged in linux-next), I am trying once again to define the bindings
which we dropped until the code is merged first.

This is targeted for 4.16 kernel and I am sending it now to get early
reviews.

The bindings in this series have changed a bit since the time it was
last sent for review [1].

I have taken care of most of the feedback given last time.

Summary:

Power-domains can also have their active states and this patchset
enhances the OPP binding to define those.

The power domains can use the OPP bindings mostly as is. Though there
are some changes required to support special cases:

- Allow "operating-points-v2" to contain multiple phandles for power
  domain providers providing multiple domains.

- A new property "power-domain-opp" is added for devices to specify the
  minimum required OPP of the master domain for the functioning of the
  device. We can add this property directly to device's node if the
  device has a fixed minimum OPP requirement from the master power
  domain. Or we can add this property to each OPP node of the device, if
  different OPP nodes have different minimum OPP requirement from the
  master power domain.

- Allow some of the OPP properties to accept magic values (firmware
  dependent) as the OS doesn't know the real freq/voltage values.

--
viresh

[1] https://marc.info/?l=linux-kernel&m=149320428621874&w=2

Viresh Kumar (2):
  OPP: Allow OPP table to be used for power-domains
  OPP: Allow "opp-hz" and "opp-microvolt" to contain magic values

 Documentation/devicetree/bindings/opp/opp.txt      | 18 +++++++
 .../devicetree/bindings/power/power_domain.txt     | 62 ++++++++++++++++++++++
 2 files changed, 80 insertions(+)

-- 
2.15.0.rc1.236.g92ea95045093
