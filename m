From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2] PM / OPP: add missing of_node_put() for
 of_get_cpu_node()
Date: Wed, 11 Oct 2017 16:06:46 +0530
Message-ID: <20171011103646.GD32532@vireshk-i7>
References: <1507632519-19648-1-git-send-email-sudeep.holla@arm.com>
 <1507716661-27146-1-git-send-email-sudeep.holla@arm.com>
 <20171011102146.GB32532@vireshk-i7>
 <62886e65-5bed-9a17-e1e0-0012ebc742ec@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f50.google.com ([74.125.83.50]:48838 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751462AbdJKKgs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 Oct 2017 06:36:48 -0400
Received: by mail-pg0-f50.google.com with SMTP id v78so770188pgb.5
        for <linux-pm@vger.kernel.org>; Wed, 11 Oct 2017 03:36:48 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <62886e65-5bed-9a17-e1e0-0012ebc742ec@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: linux-pm@vger.kernel.org, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>

On 11-10-17, 11:35, Sudeep Holla wrote:
> Generally Greg pulls them based on fixes tags, so I didn't bother
> to specify that explicitly :)

Hmm, I didn't knew that :)

-- 
viresh
