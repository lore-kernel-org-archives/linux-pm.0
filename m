From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 01/16] PM / OPP: Add 'supply-names' binding
Date: Wed, 21 Oct 2015 18:48:32 +0530
Message-ID: <20151021131832.GG7784@ubuntu>
References: <cover.1441972771.git.viresh.kumar@linaro.org>
 <2b87b162eabd1570ae2311e1ef8655acda72f678.1441972771.git.viresh.kumar@linaro.org>
 <55F72C97.2030306@kernel.org>
 <20151016002243.GA23912@codeaurora.org>
 <20151016060227.GS19018@linux>
 <20151016191658.GA16437@codeaurora.org>
 <20151017041055.GZ19018@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:35848 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750827AbbJUNSh (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 21 Oct 2015 09:18:37 -0400
Received: by pacfv9 with SMTP id fv9so57252897pac.3
        for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2015 06:18:36 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20151017041055.GZ19018@linux>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Rob Herring <robh@kernel.org>, Rafael Wysocki <rjw@rjwysocki.net>, nm@ti.com, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, rob.herring@linaro.org, lee.jones@linaro.org, Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, open list <linux-kernel@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

On 17-10-15, 09:40, Viresh Kumar wrote:
> Hehe, no.
> 
> Okay here is the problem statement:
> 
> We have two supplies for a device and the device node will have
> something like:
> 
> name1-supply = <&supply1>;
> name2-supply = <&supply2>;
> 
> And the OPP node needs to have voltages for both of them:
> 
> opp-microvolt = <X1 Y1 Z1>, <X2 Y2 Z2>;
> 
> Where XYZ(1) are for supply1 and XYZ(2) are for supply2.
> 
> Now we need to identify the supplies for which the values are present
> here and their order as well. How do we do that?
> 
> The way I am suggesting is to add a property in opp node which will
> keep "name1" and "name2" in it.

Any more comments? Acks ? I want to close this series :)

-- 
viresh
