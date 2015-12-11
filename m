From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PICKME 0/2] cpufreq: New ST driver
Date: Fri, 11 Dec 2015 08:49:00 +0530
Message-ID: <20151211031900.GM3612@ubuntu>
References: <1449740537-12619-1-git-send-email-lee.jones@linaro.org>
 <2896628.JCDQCVfIaC@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:35794 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751358AbbLKDTF (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 10 Dec 2015 22:19:05 -0500
Received: by padhk6 with SMTP id hk6so17749535pad.2
        for <linux-pm@vger.kernel.org>; Thu, 10 Dec 2015 19:19:05 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <2896628.JCDQCVfIaC@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Lee Jones <lee.jones@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kernel@stlinux.com, maxime.coquelin@st.com, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, ajitpal.singh@st.com

On 10-12-15, 22:38, Rafael J. Wysocki wrote:
> Do they depend on anything special?

My opp-binding-parsing patches which you applied to bleeding-edge.
Yes, Lee should have mentioned that explicitly.

-- 
viresh
