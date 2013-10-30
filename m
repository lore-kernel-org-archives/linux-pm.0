From: Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: [PATCH v2 0/2] cpufreq support for the big.LITTLE switcher
Date: Wed, 30 Oct 2013 15:44:39 -0400
Message-ID: <1383162281-24204-1-git-send-email-nicolas.pitre@linaro.org>
Content-Transfer-Encoding: 7BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from relais.videotron.ca ([24.201.245.36]:23363 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754369Ab3J3Tor (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 30 Oct 2013 15:44:47 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: viresh.kumar@linaro.org, sudeep.karkadanagesha@arm.com, dave.martin@arm.com, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linaro-kernel@lists.linaro.org, patches@linaro.org

This is the third and final set of patches towards a fully functional
and production quality switcher solution for big.LITTLE systems,
establishing a landmark to compare against for any scheduler based
solution meant to eventually surpass the switcher's power efficiency
available in the mainline kernel.

Rationale for this code: http://lwn.net/Articles/481055/

The first and second patch sets have already been merged by RMK.  They
implement the core switcher mechanism.  This set adds the necessary code
to drive the switcher based on cpufreq governor decisions.

This set (v2) was rebased on top of the latest linux-pm tree as
requested by Rafael.


