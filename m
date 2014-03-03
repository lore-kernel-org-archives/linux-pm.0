From: Josh Cartwright <joshc@codeaurora.org>
Subject: spear-cpufreq + multiplatform?
Date: Mon, 3 Mar 2014 12:08:09 -0600
Message-ID: <20140303180809.GA28282@joshc.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.11.231]:60121 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751894AbaCCSKz (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 3 Mar 2014 13:10:55 -0500
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.linux@gmail.com>, Shiraz Hashim <shiraz.hashim@st.com>, Deepak Sikri <deepak.sikri@st.com>
Cc: linux-arm-kernel@lists.infradead.org, spear-devel@list.st.com, linux-pm@vger.kernel.org

Hey folks-

I noticed booting today's next on a non-spear platform, that I'm seeing
the following in my logs:

	[    2.126494] spear_cpufreq: Invalid cpufreq_tbl

Looking closer, it looks like the spear-cpufreq driver has a
late_initcall() that's not too multiplatform friendly.  Perhaps the
spear cpufreq initialization routine should be called explicitly from
some platform-specific code, or explicitly check to ensure it's running
on SPEAr?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
