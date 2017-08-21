From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: OPP: how to get the all frequency list?
Date: Mon, 21 Aug 2017 17:53:33 +0900
Message-ID: <599A9F8D.6080508@samsung.com>
References: <CGME20170821085332epcas2p2e06a9d81a79ab5e71804db41bf349833@epcas2p2.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:25013 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751069AbdHUIxe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 21 Aug 2017 04:53:34 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <vireshk@kernel.org>, "nm@ti.com" <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, =?UTF-8?B?7ZWo?= =?UTF-8?B?66qF7KO8?= <myungjoo.ham@samsung.com>

Dear all,

I have a question that how to get the all frequency list
by using the OPP interface. (It doesn't matter whether frequency is available or not.)

OPP has following three functions in order to find the proper frequency.
- dev_pm_opp_find_freq_exact(struct device *dev, unsigned long freq, bool available);
- dev_pm_opp_find_freq_floor(struct device *dev, unsigned long freq);
	: Search for a rounded floor freq (if opp->available is true)
- dev_pm_opp_find_freq_ceil(struct device *dev, unsigned long freq);
	: Search for a rounded ceil freq if (opp->available is true)

In this case,
when the device using OPP tries to find the all frequencies,
the device can't find them. The device can just find the available frequencies.

If the some frequency of the device might be disabled by dev_pm_opp_disable()
and also the device doesn't know the correct frequency value,
the device cannot find the all frequencies by using the dev_pm_opp_find_freq_floor/ceil()

It is just able to find the available frequencies if opp->available is true.

Or
When proving the device driver and then before disabling the OPP by dev_pm_opp_disable(),
each device driver have to store the frequency lists on the private data structure.

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
