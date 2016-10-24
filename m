From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v4 0/9] PM / Domains: DT support for domain idle states & atomic PM domains
Date: Tue, 25 Oct 2016 00:30:18 +0200
Message-ID: <2068597.AeryDFjO6y@vostro.rjw.lan>
References: <1477347668-41901-1-git-send-email-lina.iyer@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:43999 "HELO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S940962AbcJXWXR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 Oct 2016 18:23:17 -0400
In-Reply-To: <1477347668-41901-1-git-send-email-lina.iyer@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lina Iyer <lina.iyer@linaro.org>
Cc: ulf.hansson@linaro.org, khilman@kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, andy.gross@linaro.org, sboyd@codeaurora.org, linux-arm-msm@vger.kernel.org, brendan.jackman@arm.com, lorenzo.pieralisi@arm.com, sudeep.holla@arm.com, Juri.Lelli@arm.com

On Monday, October 24, 2016 03:20:59 PM Lina Iyer wrote:
> Hi all,
> 
> Changes since v3 [5] -
> - Added "domain-idle-state" compatible to arm/idle-states.txt
> - Updated documentation for defining PM domain idle states
> - Updated documentation for devices and PM domains.
> - Updated code to look for "domain-idle-state" instead of "arm,idle-state" compatible.
> - The series is available at [6].

Is this the series I've already queued up?

If so, can you please send a delta patch only with a proper changelog?

Thanks,
Rafael

