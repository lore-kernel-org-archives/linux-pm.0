From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: Kernel warning in cpufreq_add_dev()
Date: Fri, 9 Sep 2016 15:27:42 +0530
Message-ID: <20160909095742.GA18547@vireshk-i7>
References: <20160819110032.GM1041@n2100.armlinux.org.uk>
 <2310664.2BksGViL4r@vostro.rjw.lan>
 <20160824131316.GI25143@ubuntu>
 <1496109.Jd9MGDryNS@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:36717 "EHLO
        mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753810AbcIIJ5q (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Sep 2016 05:57:46 -0400
Received: by mail-pa0-f50.google.com with SMTP id id6so26981661pad.3
        for <linux-pm@vger.kernel.org>; Fri, 09 Sep 2016 02:57:45 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1496109.Jd9MGDryNS@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Russell King - ARM Linux <linux@armlinux.org.uk>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 31-08-16, 03:26, Rafael J. Wysocki wrote:
> I was thinking about something similar, but won't the WARN_ON()s in
> cpufreq_add/remove_dev_symlink() still trigger, say if there's more
> than one CPU in a policy and both happen to be online initially?

Right. I missed that. I have sent a patch just now in reply to the first email
from Russell. That should fix it all..

@Russell: Can you please test/verify the patch I have sent now?

-- 
viresh
