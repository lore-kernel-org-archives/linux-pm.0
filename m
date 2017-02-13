From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2 1/6] PM / QOS: Add default case to the switch
Date: Mon, 13 Feb 2017 08:41:48 +0530
Message-ID: <20170213031148.GC8498@vireshk-i7>
References: <cover.1486611268.git.viresh.kumar@linaro.org>
 <338b16e4c882634e30e4f4c011a9e9c52d134cbc.1486611268.git.viresh.kumar@linaro.org>
 <20170209142425.GC23373@xo-6d-61-c0.localdomain>
 <20170210060030.GA8498@vireshk-i7>
 <20170210121535.GA27377@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f51.google.com ([74.125.83.51]:36347 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751334AbdBMDLw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 12 Feb 2017 22:11:52 -0500
Received: by mail-pg0-f51.google.com with SMTP id v184so28224327pgv.3
        for <linux-pm@vger.kernel.org>; Sun, 12 Feb 2017 19:11:51 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20170210121535.GA27377@amd>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, khilman@baylibre.com, ulf.hansson@linaro.org, Len Brown <len.brown@intel.com>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, sboyd@codeaurora.org, nm@ti.com, robh+dt@kernel.org, lina.iyer@linaro.org, rnayak@codeaurora.org

On 10-02-17, 13:15, Pavel Machek wrote:
> As soon as new QoS request type is added, this switch can be
> fixed. There is no issue now, and there should be no issue in future.

Sure. Will do it in V3.

-- 
viresh
