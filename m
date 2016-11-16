From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: dt: Add support for r8a7743 and r8a7745
Date: Wed, 16 Nov 2016 15:39:06 +0530
Message-ID: <20161116100906.GA20987@vireshk-i7>
References: <1479290751-9705-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f169.google.com ([209.85.192.169]:36079 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752255AbcKPKJK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Nov 2016 05:09:10 -0500
Received: by mail-pf0-f169.google.com with SMTP id 189so42329853pfz.3
        for <linux-pm@vger.kernel.org>; Wed, 16 Nov 2016 02:09:10 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1479290751-9705-1-git-send-email-geert+renesas@glider.be>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Simon Horman <horms@verge.net.au>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 16-11-16, 11:05, Geert Uytterhoeven wrote:
> Add the compatible strings for supporting the generic cpufreq driver on
> the Renesas RZ/G1M (r8a7743) and RZ/G1E (r8a7745) SoCs.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> Support for RZ/G1M and RZ/G1E is expected to land in v4.10.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
