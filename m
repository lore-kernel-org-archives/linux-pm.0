From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [RFC V7 2/2] OPP: Allow "opp-hz" and "opp-microvolt" to contain
 magic values
Date: Thu, 14 Dec 2017 13:00:01 +0530
Message-ID: <20171214073001.GX3322@vireshk-i7>
References: <CAL_JsqKr7MsM6iZ_QYO=iCzXNwANEGQGDLFUEwe0Z-p2Z_aMYw@mail.gmail.com>
 <CAKohpokvQD4Z6YY6MRG8c+hnsS=Z52X4XhyTgC5FTgf7VuaNmw@mail.gmail.com>
 <CAL_JsqK-qtAaM_Ou5NtxcWR3F_q=8rMPJUm-VqGtKhbtWe5SAQ@mail.gmail.com>
 <20171101214333.GG30645@codeaurora.org>
 <20171102045155.GX4240@vireshk-i7>
 <20171102071533.GM30645@codeaurora.org>
 <20171102090033.GZ4240@vireshk-i7>
 <CAPDyKFryn5=GMs+hiRcxGOC1U=-LL9RQdnY3cWniyE+4pwQDog@mail.gmail.com>
 <20171130005029.GC19419@codeaurora.org>
 <20171130065907.GI11413@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f51.google.com ([74.125.83.51]:35495 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751121AbdLNHaG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 14 Dec 2017 02:30:06 -0500
Received: by mail-pg0-f51.google.com with SMTP id q20so2899246pgv.2
        for <linux-pm@vger.kernel.org>; Wed, 13 Dec 2017 23:30:06 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20171130065907.GI11413@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Kevin Hilman <khilman@kernel.org>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Rafael Wysocki <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Rajendra Nayak <rnayak@codeaurora.org>, Sudeep Holla <sudeep.holla@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 30-11-17, 12:29, Viresh Kumar wrote:
> On 29-11-17, 16:50, Stephen Boyd wrote:
> > Sorry it still makes zero sense to me. It seems that we're trying
> > to make the OPP table parsing generic just for the sake of code
> > brevity.
> 
> Not just the code but bindings as well to make sure we don't add a new
> property (similar to earlier ones) for every platform that wants to
> use performance states.

@Stephen: Do you have any feedback on my previous email? If no, then I
would like to refresh this version with the feedback received from
Rob.

-- 
viresh
