From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [RFC V7 2/2] OPP: Allow "opp-hz" and "opp-microvolt" to contain
 magic values
Date: Thu, 2 Nov 2017 14:30:33 +0530
Message-ID: <20171102090033.GZ4240@vireshk-i7>
References: <cover.1509453284.git.viresh.kumar@linaro.org>
 <23ba51eaa6b52117458165dccc00a95cf8e86e1d.1509453284.git.viresh.kumar@linaro.org>
 <CAL_JsqKr7MsM6iZ_QYO=iCzXNwANEGQGDLFUEwe0Z-p2Z_aMYw@mail.gmail.com>
 <CAKohpokvQD4Z6YY6MRG8c+hnsS=Z52X4XhyTgC5FTgf7VuaNmw@mail.gmail.com>
 <CAL_JsqK-qtAaM_Ou5NtxcWR3F_q=8rMPJUm-VqGtKhbtWe5SAQ@mail.gmail.com>
 <20171101214333.GG30645@codeaurora.org>
 <20171102045155.GX4240@vireshk-i7>
 <20171102071533.GM30645@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f44.google.com ([74.125.83.44]:46227 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755274AbdKBJAi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 2 Nov 2017 05:00:38 -0400
Received: by mail-pg0-f44.google.com with SMTP id k7so4503677pga.3
        for <linux-pm@vger.kernel.org>; Thu, 02 Nov 2017 02:00:38 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20171102071533.GM30645@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Rob Herring <robh+dt@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@kernel.org>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Rafael Wysocki <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Rajendra Nayak <rnayak@codeaurora.org>, Sudeep Holla <sudeep.holla@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 02-11-17, 00:15, Stephen Boyd wrote:
> Sorry I'm not following. We're going to need to have platform
> specific code that understands platform specific bindings that
> aren't shoved into the generic OPP bindings.

At least I am not targeting any platform specific binding right now.
The way I see this to work is:

- We will reuse earlier bindings and allow opp-hz and opp-microvolt to
  contain special values (this patch).
- Platform specific DT entries will put corner numbers in opp-hz (or
  opp-microvolt) fields.
- Some platform specific driver (in OPP or genpd) will be used to
  convert OPP into a performance state (corner) value. Now that can
  simply read opp-hz (or opp-microvolt) and return its value.
- OPP core will request for a performance state (code is already
  merged for that).

And so there is no platform specific binding here. Do you want to do
this differently ?

-- 
viresh
