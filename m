From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v4 2/2] dt: power: st: Provide bindings for ST's OPPs
Date: Wed, 12 Aug 2015 16:38:41 +0530
Message-ID: <20150812110841.GC20238@linux>
References: <20150803034642.GV899@linux>
 <20150810132247.GH3249@x1>
 <20150811080023.GB5509@linux>
 <20150811093039.GA18282@x1>
 <20150811100941.GG5509@linux>
 <20150811115425.GE18282@x1>
 <20150811120124.GH5509@linux>
 <20150811132756.GG18282@x1>
 <20150811142812.GJ5509@linux>
 <20150811151736.GO18282@x1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:32928 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754167AbbHLLIq (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 12 Aug 2015 07:08:46 -0400
Received: by pabyb7 with SMTP id yb7so12548344pab.0
        for <linux-pm@vger.kernel.org>; Wed, 12 Aug 2015 04:08:45 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20150811151736.GO18282@x1>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Stephen Boyd <sboyd@codeaurora.org>, Rob Herring <robherring2@gmail.com>, Nishanth Menon <nm@ti.com>, kernel@stlinux.com, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Rafael Wysocki <rjw@rjwysocki.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Sebastian Reichel <sre@kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Arnd Bergmann <arnd.bergmann@linaro.org>, Ajit Pal Singh <ajitpal.singh@st.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 11-08-15, 16:17, Lee Jones wrote:
> This would work if we only had a single variable to contend with, but
> what I showed you in my previous example is that we have 3 variables
> to consider; cut (version), pcode and substrate.
> 
> Using the two (simple) examples I provided, how would your suggestion
> look in our case?

So the solution I gave is for picking the microvolt based on pcode.
The other two (cut, substrate) aren't about picking microvolt, but if
the OPP is available or not. Right?

If these terms are generic enough, then we can add something similar
to what you have added..

@Stephen ?

-- 
viresh
