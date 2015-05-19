From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V5 00/14] cpufreq: Don't loose cpufreq history on CPU
 hotplug
Date: Tue, 19 May 2015 07:57:46 +0530
Message-ID: <20150519022746.GE5102@linux>
References: <cover.1431924457.git.viresh.kumar@linaro.org>
 <5515479.9CSMtpamVj@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f169.google.com ([209.85.192.169]:32816 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751073AbbESC1t (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 18 May 2015 22:27:49 -0400
Received: by pdbqa5 with SMTP id qa5so2835308pdb.0
        for <linux-pm@vger.kernel.org>; Mon, 18 May 2015 19:27:49 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <5515479.9CSMtpamVj@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, sboyd@codeaurora.org, prarit@redhat.com, skannan@codeaurora.org, Srivatsa Bhat <srivatsa@mit.edu>

On 19-05-15, 02:34, Rafael J. Wysocki wrote:
> I've applied patches [1-6/14] from your previous series.  Should I replace them
> with the new ones?

Never realised that you have applied more of these. Yeah, apply
everything other than 1-6. Thanks.

-- 
viresh
