From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2] cpufreq: kirkwood-cpufreq:- Handle return value of
 clk_prepare_enable
Date: Wed, 17 May 2017 12:15:49 +0530
Message-ID: <20170517064549.GC17481@vireshk-i7>
References: <1495003358-25593-1-git-send-email-arvind.yadav.cs@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f180.google.com ([209.85.192.180]:33503 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750950AbdEQGpx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 May 2017 02:45:53 -0400
Received: by mail-pf0-f180.google.com with SMTP id e193so2558427pfh.0
        for <linux-pm@vger.kernel.org>; Tue, 16 May 2017 23:45:53 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1495003358-25593-1-git-send-email-arvind.yadav.cs@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On 17-05-17, 12:12, Arvind Yadav wrote:
> Here, Clock enable can failed. So adding an error check for
> clk_prepare_enable.

You missed my comment for the commit log.

-- 
viresh
