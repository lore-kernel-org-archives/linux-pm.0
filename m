From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH RFC 1/2] thermal/cpu idle cooling: Introduce cpu idle
 cooling driver
Date: Thu, 8 Jun 2017 14:04:28 +0200
Message-ID: <20170608120428.GC2244@mai>
References: <1496653645-20283-1-git-send-email-kevin.wangtao@hisilicon.com>
 <20170606034135.GA5103@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wr0-f176.google.com ([209.85.128.176]:33333 "EHLO
        mail-wr0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751449AbdFHMEd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Jun 2017 08:04:33 -0400
Received: by mail-wr0-f176.google.com with SMTP id v104so17623841wrb.0
        for <linux-pm@vger.kernel.org>; Thu, 08 Jun 2017 05:04:32 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20170606034135.GA5103@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Tao Wang <kevin.wangtao@hisilicon.com>, rui.zhang@intel.com, edubezval@gmail.com, amit.kachhap@gmail.com, javi.merino@kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, sunzhaosheng@hisilicon.com, vincent.guittot@linaro.org, jean.wangtao@linaro.org

On Tue, Jun 06, 2017 at 09:11:35AM +0530, viresh kumar wrote:
> + Daniel
> 
> On 05-06-17, 17:07, Tao Wang wrote:
> > cpu idle cooling driver performs synchronized idle injection across
> > all cpu in same cluster, offers a new method to cooling down cpu,
> > that is similar to intel_power_clamp driver, but is basically
> > designed for ARM platform.
> > Each cluster has its own idle cooling device, each core has its own
> > idle injection thread, idle injection thread use play_idle to enter
> > idle. In order to reach deepest idle state, all cores are aligned by
> > jiffies. the injected idle ratio can be controlled through cooling
> > device interface.
> > 

I don't see any ARM specific code in this driver as stated in the description.

Was it considered to make the intel_powerclamp and this driver to converge to a
single generic driver?
