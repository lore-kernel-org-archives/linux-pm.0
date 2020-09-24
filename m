Return-Path: <SRS0=e+u9=DB=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20D13C4363D
	for <linux-pm@archiver.kernel.org>; Thu, 24 Sep 2020 09:52:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E297223977
	for <linux-pm@archiver.kernel.org>; Thu, 24 Sep 2020 09:52:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727349AbgIXJwu (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 24 Sep 2020 05:52:50 -0400
Received: from foss.arm.com ([217.140.110.172]:40392 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726380AbgIXJwt (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 24 Sep 2020 05:52:49 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1CB2D113E;
        Thu, 24 Sep 2020 02:52:49 -0700 (PDT)
Received: from ubuntu.arm.com (unknown [10.57.15.115])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 201213F73B;
        Thu, 24 Sep 2020 02:52:46 -0700 (PDT)
From:   Nicola Mazzucato <nicola.mazzucato@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        sudeep.holla@arm.com, rjw@rjwysocki.net, vireshk@kernel.org,
        robh+dt@kernel.org, daniel.lezcano@linaro.org
Cc:     morten.rasmussen@arm.com, chris.redpath@arm.com,
        nicola.mazzucato@arm.com
Subject: [PATCH v2 0/2] CPUFreq: Add support for cpu performance dependencies
Date:   Thu, 24 Sep 2020 10:53:45 +0100
Message-Id: <20200924095347.32148-1-nicola.mazzucato@arm.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rob, Rafael, Viresh, Daniel and Sudeep,

I am proposing the addition of performance dependencies in cpufreq core
and one if its drivers (the implementation/approach is RFC).
This is to support systems where exposed cpu performance controls are more
fine-grained that the platform's ability to scale cpus independently.

In this V2 posting of the proposed dt-binding to support this, I have
included an outline of how this information can be stored and passed onto
relevant OSPM frameworks.

Please see each patch for detailed information.

[v2]
  * Fix errors when running make dt_binding_check
  * Improve commit message description for the dt-binding
  * Add RFC for implementation in cpufreq-core and one of its
    drivers.

Nicola Mazzucato (2):
  dt-bindings: arm: Add devicetree binding for
    cpu-performance-dependencies
  [RFC] CPUFreq: Add support for cpu-perf-dependencies

 .../bindings/arm/cpu-perf-dependencies.yaml   | 48 +++++++++++++++++++
 1 file changed, 48 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/cpu-perf-dependencies.yaml

-- 
2.27.0

