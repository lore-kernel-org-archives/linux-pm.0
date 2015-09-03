From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2 Resend 0/5] PM / OPP: Add debugfs support
Date: Thu, 3 Sep 2015 10:02:12 +0530
Message-ID: <20150903043212.GF13140@linux>
References: <cover.1441083292.git.viresh.kumar@linaro.org>
 <1528146.dlEkeu6D3U@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:33079 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752397AbbICEcS (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 3 Sep 2015 00:32:18 -0400
Received: by pacex6 with SMTP id ex6so28418564pac.0
        for <linux-pm@vger.kernel.org>; Wed, 02 Sep 2015 21:32:18 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1528146.dlEkeu6D3U@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: sboyd@codeaurora.org, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, nm@ti.com, khilman@linaro.org

On 03-09-15, 03:05, Rafael J. Wysocki wrote:
> This series is generally fine by me, but it causes too much code churn
> to happen for pushing it into 4.3 at this point.  I can queue it up
> for the next merge widnow.

Thanks for letting me know :)

I wasn't initially trying for 4.3, but 4.4. But sent this again to get
it Acked, so that the path for next series gets clear :)

I am currently working on multiple-regulator support and that will
have lot of updates too.

Thanks.

-- 
viresh
