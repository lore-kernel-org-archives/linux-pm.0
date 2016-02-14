From: Leo Yan <leo.yan@linaro.org>
Subject: Regard of thermal power allocator's coefficients
Date: Sun, 14 Feb 2016 19:00:41 +0800
Message-ID: <20160214110041.GB26920@leoy-linaro>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f180.google.com ([209.85.192.180]:35922 "EHLO
	mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751175AbcBNLAt (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 14 Feb 2016 06:00:49 -0500
Received: by mail-pf0-f180.google.com with SMTP id e127so71785132pfe.3
        for <linux-pm@vger.kernel.org>; Sun, 14 Feb 2016 03:00:49 -0800 (PST)
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, Javi Merino <javi.merino@arm.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, linux-kernel@vger.kernel.org

Hi there,

I'm trying to upstreaming IPA patches for 96board Hikey, but so far
there have no standard DT binding for passing IPA coefficients for
power modeling.

So want to firstly to confirm if should we pass coefficients by using
device tree? Is someone working on related work for this?

Here has another more straightforward method is to directly to
include power model's coefficients in thermal sensor driver (such like
drivers/thermal/hisi_thermal.c), but my concern is this method will
include SoC specific data in the common thermal sensor driver,
so is this doable?

Welcome any suggestion.

Thanks,
Leo Yan
