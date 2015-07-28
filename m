From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v4 1/2] dt: cpufreq: st: Provide bindings for ST's
 CPUFreq implementation
Date: Tue, 28 Jul 2015 14:05:13 +0530
Message-ID: <20150728083513.GA26276@linux>
References: <1438010430-5802-1-git-send-email-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:33787 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752209AbbG1IfV (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 28 Jul 2015 04:35:21 -0400
Received: by padck2 with SMTP id ck2so66352880pad.0
        for <linux-pm@vger.kernel.org>; Tue, 28 Jul 2015 01:35:20 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1438010430-5802-1-git-send-email-lee.jones@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>, rob.herring@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kernel@stlinux.com, rjw@rjwysocki.net, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, ajitpal.singh@st.com, sre@kernel.org, dbaryshkov@gmail.com

On 27-07-15, 16:20, Lee Jones wrote:
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
> 
> Changelog:
>  - Using OPP-v2
>  - Moved (and linked) a bunch of documentation to ../power/
> 
>  .../devicetree/bindings/cpufreq/cpufreq-st.txt     | 40 ++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/cpufreq/cpufreq-st.txt

For both patches:

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

But I would like Rob to have a look as well :)
-- 
viresh
