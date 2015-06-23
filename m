From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 5/8] ARM: STi: STiH407: Move PWM nodes STiH407 =>
 STiH407-family
Date: Tue, 23 Jun 2015 13:25:59 +0530
Message-ID: <20150623075559.GG16776@linux>
References: <1434987837-24212-1-git-send-email-lee.jones@linaro.org>
 <1434987837-24212-6-git-send-email-lee.jones@linaro.org>
 <20150623021708.GB16776@linux>
 <20150623070822.GB3245@x1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f178.google.com ([209.85.192.178]:36119 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752967AbbFWH4D (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 23 Jun 2015 03:56:03 -0400
Received: by pdcu2 with SMTP id u2so1868826pdc.3
        for <linux-pm@vger.kernel.org>; Tue, 23 Jun 2015 00:56:03 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20150623070822.GB3245@x1>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kernel@stlinux.com, rjw@rjwysocki.net, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, ajitpal.singh@st.com

On 23-06-15, 08:08, Lee Jones wrote:
> Because the CPUFreq regulator is controlled with PWM and CPUFreq will
> fail on STiH410 (my main development platform) without it.

I see, probably this should find a place in the cover-letter :)

> It's safe for you to ignore it though.

Thanks :)

-- 
viresh
