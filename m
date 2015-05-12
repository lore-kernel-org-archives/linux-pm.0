From: Michael Turquette <mike.turquette@linaro.org>
Subject: Re: [PATCH V4 3/3] OPP: Add 'opp-next' in operating-points-v2 bindings
Date: Tue, 12 May 2015 14:47:14 -0700
Message-ID: <20150512214714.16410.59831@quantum>
References: <cover.1430394884.git.viresh.kumar@linaro.org>
 <1ee98ae5b45083e681c7f530e0ae9195e5636119.1430394884.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ie0-f178.google.com ([209.85.223.178]:33366 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933135AbbELVr1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 12 May 2015 17:47:27 -0400
Received: by iebgx4 with SMTP id gx4so14770792ieb.0
        for <linux-pm@vger.kernel.org>; Tue, 12 May 2015 14:47:26 -0700 (PDT)
In-Reply-To: <1ee98ae5b45083e681c7f530e0ae9195e5636119.1430394884.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, rob.herring@linaro.org, arnd.bergmann@linaro.org, nm@ti.com, broonie@kernel.org, sboyd@codeaurora.org
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, grant.likely@linaro.org, olof@lixom.net, Sudeep.Holla@arm.com, devicetree@vger.kernel.org, viswanath.puttagunta@linaro.org, l.stach@pengutronix.de, thomas.petazzoni@free-electrons.com, linux-arm-kernel@lists.infradead.org, ta.omasab@gmail.com, kesavan.abhilash@gmail.com, khilman@linaro.org, santosh.shilimkar@oracle.com, Viresh Kumar <viresh.kumar@linaro.org>

Quoting Viresh Kumar (2015-04-30 05:08:01)
> Many platforms require to switch to a intermediate frequency before
> switching to a final frequency. Or they can switch to only particular
> OPPs from any OPP.
> 
> For these add another property in OPP-v2, 'opp-next'.
> 
> Refer to the bindings for more details.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

We should never encode any aspect of the dvfs transition sequence into
DT. Raw data such as clock frequency or supply voltage might be OK, but
the programming steps should be left entirely to drivers.

So this patch gets a NAK from me.

Regards,
Mike
