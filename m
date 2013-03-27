From: Rob Herring <robherring2@gmail.com>
Subject: omap cpufreq driver in multi-platform kernels
Date: Tue, 26 Mar 2013 20:49:48 -0500
Message-ID: <5152503C.2050503@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-vb0-f45.google.com ([209.85.212.45]:52522 "EHLO
	mail-vb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752307Ab3C0Btv (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 26 Mar 2013 21:49:51 -0400
Received: by mail-vb0-f45.google.com with SMTP id q16so2573657vbe.18
        for <linux-pm@vger.kernel.org>; Tue, 26 Mar 2013 18:49:50 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Shawn Guo <shawn.guo@linaro.org>, linux-pm@vger.kernel.org, Mark Langsdorf <mark.langsdorf@calxeda.com>

Kevin, Tony, Paul,

The omap cpufreq driver causes problems in multi-platform kernels
because it unconditionally registers with the cpufreq core and does not
check sufficiently that it is running on an omap platform. So on a
kernel with highbank and omap drivers booted on highbank, the
cpufreq-cpu0 driver fails to init. Any suggestions for how to fix? For
DT this could just be several of_machine_is_compatible checks, but I'm
not really sure for non-DT. Converting the driver to a platform driver
would be another option.

This will also affect other cpufreq-cpu0 users like iMX. And I'd guess
there may be other ARM cpufreq drivers that will cause the same issue.

Rob
