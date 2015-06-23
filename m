From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 4/8] ARM: STi: STiH407: Provide a node for CPUFreq
Date: Tue, 23 Jun 2015 13:27:37 +0530
Message-ID: <20150623075737.GH16776@linux>
References: <1434987837-24212-1-git-send-email-lee.jones@linaro.org>
 <1434987837-24212-5-git-send-email-lee.jones@linaro.org>
 <20150623021622.GA16776@linux>
 <20150623071045.GC3245@x1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f180.google.com ([209.85.192.180]:33152 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932251AbbFWH5m (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 23 Jun 2015 03:57:42 -0400
Received: by pdjn11 with SMTP id n11so1977961pdj.0
        for <linux-pm@vger.kernel.org>; Tue, 23 Jun 2015 00:57:41 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20150623071045.GC3245@x1>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: rob.herring@linaro.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kernel@stlinux.com, rjw@rjwysocki.net, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, ajitpal.singh@st.com

On 23-06-15, 08:10, Lee Jones wrote:
> > These virtual nodes aren't allowed in DT and you have added them
> > before the bindings patch :).
> 
> This isn't a virtual node, but you bring up a good point.

Hmm, wrong choice of words. Sorry.. 

So, its a node for a virtual device :). The device is CPU and it
already has a node for itself. And so such nodes were discouraged
earlier by DT maintainers.

-- 
viresh
