From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V5 3/3] OPP: Add binding for 'opp-suspend'
Date: Thu, 21 May 2015 11:19:35 +0530
Message-ID: <20150521054935.GG22904@linux>
References: <cover.1432091956.git.viresh.kumar@linaro.org>
 <618b02107af650bcb3246e165095bbca207d511a.1432091956.git.viresh.kumar@linaro.org>
 <555D6DD3.7000404@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f172.google.com ([209.85.192.172]:36497 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754115AbbEUFtk (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 21 May 2015 01:49:40 -0400
Received: by pdfh10 with SMTP id h10so95876834pdf.3
        for <linux-pm@vger.kernel.org>; Wed, 20 May 2015 22:49:39 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <555D6DD3.7000404@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, rob.herring@linaro.org, arnd.bergmann@linaro.org, broonie@kernel.org, mike.turquette@linaro.org, sboyd@codeaurora.org, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, grant.likely@linaro.org, olof@lixom.net, Sudeep.Holla@arm.com, devicetree@vger.kernel.org, viswanath.puttagunta@linaro.org, l.stach@pengutronix.de, thomas.petazzoni@free-electrons.com, linux-arm-kernel@lists.infradead.org, ta.omasab@gmail.com, kesavan.abhilash@gmail.com, khilman@linaro.org, santosh.shilimkar@oracle.com

On 21-05-15, 00:32, Nishanth Menon wrote:
> Why not just mark it as a property of an OPP rather than a phandle? just
> thinking that this might setup a precedence for future needs like
> "shutdown OPP" or "Reboot OPP" or something different that some other
> SoC might have..

AFAIU, a property should be present in the OPP if and only if any OPP
can set it. But in this case, only one OPP from the entire list can
set it. So, its more a property of the list rather than every OPP
within it. And then there wouldn't be any need to code that would
check bugs in dtbs where multiple OPPs have it set.

-- 
viresh
