From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 3/8] PM / OPP: Manage supply's voltage/current in a
 separate structure
Date: Thu, 13 Oct 2016 11:12:11 +0530
Message-ID: <20161013054211.GA2991@vireshk-i7>
References: <cover.1475581665.git.viresh.kumar@linaro.org>
 <c225f2c1cb64e392c72bc981eafa06f1a6c9edf3.1475581665.git.viresh.kumar@linaro.org>
 <57FEA7F2.3070604@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f180.google.com ([209.85.192.180]:34087 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755163AbcJMFnx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Oct 2016 01:43:53 -0400
Received: by mail-pf0-f180.google.com with SMTP id r16so6346534pfg.1
        for <linux-pm@vger.kernel.org>; Wed, 12 Oct 2016 22:42:16 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <57FEA7F2.3070604@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Dave Gerlach <d-gerlach@ti.com>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, nm@ti.com, sboyd@codeaurora.org, Viresh Kumar <vireshk@kernel.org>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, robh@kernel.org, broonie@kernel.org

On 12-10-16, 16:15, Dave Gerlach wrote:
> >  /**
> >+ * struct dev_pm_opp_supply - Power supply voltage/current values
> >+ * @u_volt:	Target voltage in microvolts corresponding to this OPP
> >+ * @u_volt_min:	Minimum voltage in microvolts corresponding to thisq OPP
> >+ * @u_volt_max:	Maximum voltage in microvolts corresponding to this OPP
> >+ * @u_amp:	Maximum current drawn by the device in microamperes
> >+ *
> >+ * This structure stores the voltage/current values for a single power supply.
> >+ */
> >+struct dev_pm_opp_supply {
> >+	unsigned long u_volt;
> >+	unsigned long u_volt_min;
> >+	unsigned long u_volt_max;
> >+	unsigned long u_amp;
> >+};
> >+
> >+/**
> 
> This needs to move to include/linux/pm_opp.h, does it not? We need access to
> the actual voltage values from outside of the OPP core if we are going to be
> setting regulators from the platform provided opp_set_rate callback
> described in patch 7.

Yes, will do in V2.

-- 
viresh
