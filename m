From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 0/2] PM / Domains / OPP: Introduce domain-performance-state binding
Date: Mon, 12 Dec 2016 16:26:17 +0530
Message-ID: <cover.1481539827.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f169.google.com ([209.85.192.169]:34348 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754192AbcLLK4c (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Dec 2016 05:56:32 -0500
Received: by mail-pf0-f169.google.com with SMTP id c4so12553921pfb.1
        for <linux-pm@vger.kernel.org>; Mon, 12 Dec 2016 02:56:32 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Stephen Boyd <sboyd@codeaurora.org>, Nishanth Menon <nm@ti.com>, Vincent Guittot <vincent.guittot@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Kevin Hilman <khilman@baylibre.com>, Ulf Hansson <ulf.hansson@linaro.org>, Lina Iyer <lina.iyer@linaro.org>, devicetree@vger.kernel.org, Nayak Rajendra <rnayak@codeaurora.org>, Viresh Kumar <viresh.kumar@linaro.org>

Hello,

Some platforms have the capability to configure the performance state of
their Power Domains. The performance levels are represented by positive
integer values, a lower value represents lower performance state.

We had some discussions about it in the past on the PM list [1], which is
followed by discussions during the LPC. The outcome of all that was that we
should extend Power Domain framework to support active state power management
as well.

The power-domains until now were only concentrating on the idle state
management of the device and this needs to change in order to reuse the
infrastructure of power domains for active state management.

To get a complete picture of the proposed plan, following is what we
need to do:
- Create DT bindings to get domain performance state information for the
  platforms.
- Enhance OPP framework to parse these and call into the PM Qos
  framework with a performance state request.
- Enhance PM Qos framework to provide the API to be used by consumers
  (or OPP framework) and pass it on to the (Generic) Power Domain
  framework.
- Enhance Generic Power Domain framework to accept such requests,
  accumulate all belonging to a single power domain and call domain
  driver specific callback with the performance state we want for the
  domain.
- The domain driver shall then, in a platform specific way, set the
  requested performance level.
- Note that these features are applicable to the CPU, GPU and other IIO
  or non-IIO devices.
- There can be cases where a device can choose between multiple power
  domains based on what performance level we want for the device. In
  such cases, we should represent the multiplexer with a separate power
  domain. In effect, the device (or OPP table) will correspond to a
  single power domain, but the backend driver of that domain shall
  implement the multiplexing functionality.

This patchset implements the very first part of this chain and
introduces a new optional property for the consumers of the
power-domains: domain-performance-state. This property can be used
directly by the consumer or its OPP table.

V1->V2:
- The performance states get their own nodes as they can have multiple
  values.
- Allow optional property domain-microvolt for the performance states

--
viresh

[1] https://marc.info/?l=linux-pm&m=147747923708075&w=2

Viresh Kumar (2):
  PM / Domains: Introduce domain-performance-states binding
  PM / OPP: Introduce domain-performance-state binding to OPP nodes

 Documentation/devicetree/bindings/opp/opp.txt      | 59 ++++++++++++++++++
 .../devicetree/bindings/power/power_domain.txt     | 69 ++++++++++++++++++++++
 2 files changed, 128 insertions(+)

-- 
2.7.1.410.g6faf27b

