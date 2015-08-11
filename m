From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v4 2/2] dt: power: st: Provide bindings for ST's OPPs
Date: Tue, 11 Aug 2015 17:31:24 +0530
Message-ID: <20150811120124.GH5509@linux>
References: <20150729221526.GE3159@codeaurora.org>
 <20150730084634.GD9319@x1>
 <CAL_JsqKQLQ15qSt95zBZykzzPhcUrtZzhk29a76n+r_3719AiA@mail.gmail.com>
 <20150731163715.GV3159@codeaurora.org>
 <20150803034642.GV899@linux>
 <20150810132247.GH3249@x1>
 <20150811080023.GB5509@linux>
 <20150811093039.GA18282@x1>
 <20150811100941.GG5509@linux>
 <20150811115425.GE18282@x1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:32910 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934148AbbHKMB3 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 11 Aug 2015 08:01:29 -0400
Received: by pabyb7 with SMTP id yb7so129038679pab.0
        for <linux-pm@vger.kernel.org>; Tue, 11 Aug 2015 05:01:29 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20150811115425.GE18282@x1>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Stephen Boyd <sboyd@codeaurora.org>, Rob Herring <robherring2@gmail.com>, Nishanth Menon <nm@ti.com>, kernel@stlinux.com, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Rafael Wysocki <rjw@rjwysocki.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Sebastian Reichel <sre@kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Arnd Bergmann <arnd.bergmann@linaro.org>, Ajit Pal Singh <ajitpal.singh@st.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 11-08-15, 12:54, Lee Jones wrote:
> The framework does not need to parse this information.  It is used
> solely by the platform driver, whose job it is to decide which OPPs
> are appropriate for the running platform.

The OPP layer needs to parse OPP nodes in DT. But for doing that it
needs to know which OPPs to pick from the table as, in cases like
yours or qcom, not all OPPs might be available.

One of the ways to do that is:
- the platform reads its efuses (or whatever) and encodes the
  information into a string.
- This string should match with the strings present (somewhere) in the
  OPP table. That location can be like what I proposed few mails back.
- Then the *generic* OPP code can parse only those OPP nodes which
  match with that string.

This way, we can avoid pushing the platform code to parse OPP tables.

> Back to my question; how would you like arbitrary version information,
> which means different things to different vendors to be used in
> shared/generic/framework code?

Exactly like I wrote above. The platform just needs to give a string
that should match with the OPPs ..

-- 
viresh
