From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: race condition on min/max update?
Date: Fri, 26 Feb 2016 20:07:49 +0530
Message-ID: <20160226143749.GA20706@vireshk-i7>
References: <56CE1432.2020409@linaro.org>
 <20160226025315.GA9159@vireshk-i7>
 <5917491.2o5563OMLE@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f172.google.com ([209.85.192.172]:34755 "EHLO
	mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754474AbcBZOhu (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 26 Feb 2016 09:37:50 -0500
Received: by mail-pf0-f172.google.com with SMTP id x65so53132687pfb.1
        for <linux-pm@vger.kernel.org>; Fri, 26 Feb 2016 06:37:50 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <5917491.2o5563OMLE@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Steve Muckle <steve.muckle@linaro.org>, Juri Lelli <Juri.Lelli@arm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On 26-02-16, 15:11, Rafael J. Wysocki wrote:
> A min/max update should trigger ->governor(limits) and then the governor
> is responsible for taking care of the race (if it needs to).
> 
> At least that's how it should work IMO.

Urg, simple thing.

-- 
viresh
