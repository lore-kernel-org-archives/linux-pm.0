From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: 4.8.1 regression with cpufreq governors
Date: Thu, 20 Oct 2016 08:59:30 +0530
Message-ID: <20161020032930.GC11766@vireshk-i7>
References: <20161018004606.GA5559@comcast.net>
 <2549240.nvakNXlyKF@vostro.rjw.lan>
 <20161019200610.GB9047@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f177.google.com ([209.85.192.177]:33733 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753630AbcJTD3e (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 19 Oct 2016 23:29:34 -0400
Received: by mail-pf0-f177.google.com with SMTP id 128so27343997pfz.0
        for <linux-pm@vger.kernel.org>; Wed, 19 Oct 2016 20:29:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20161019200610.GB9047@comcast.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Tim Walberg <twalberg@comcast.net>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, Linux PM list <linux-pm@vger.kernel.org>

On 19-10-16, 15:06, Tim Walberg wrote:
> This indeed turned out to be the fix.

Really? How can this fix the ondemand governor thing?

Or is it that Ondemand never broke ?

-- 
viresh
