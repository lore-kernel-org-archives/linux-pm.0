From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: v4.8-rc1: thinkpad x60: running at low frequency even during
 kernel build
Date: Fri, 4 Nov 2016 15:01:05 +0530
Message-ID: <20161104093105.GE3414@vireshk-i7>
References: <20161104083849.GA32688@amd>
 <20161104085830.GA4089@amd>
 <20161104091037.GD3414@vireshk-i7>
 <20161104092636.GA30729@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f174.google.com ([209.85.192.174]:34006 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752152AbcKDJbO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 4 Nov 2016 05:31:14 -0400
Received: by mail-pf0-f174.google.com with SMTP id n85so49067388pfi.1
        for <linux-pm@vger.kernel.org>; Fri, 04 Nov 2016 02:31:14 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20161104092636.GA30729@amd>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: rjw@rjwysocki.net, linux-pm@vger.kernel.org, kernel list <linux-kernel@vger.kernel.org>, rui.zhang@intel.com, linux-acpi@vger.kernel.org

On 04-11-16, 10:26, Pavel Machek wrote:
> How would I know if it is thermal capping? There's nothing in dmesg.

I am not sure what code is responsible for doing that in case of x86, maybe
Rafael and Rui can explain it that better.

But surely it involves userspace in this case as scaling_max_freq is getting
changed.

-- 
viresh
