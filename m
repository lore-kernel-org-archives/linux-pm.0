From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V4 1/3] OPP: Redefine bindings to overcome shortcomings
Date: Fri, 15 May 2015 19:45:25 +0530
Message-ID: <20150515141525.GK6348@linux>
References: <cover.1430394884.git.viresh.kumar@linaro.org>
 <d225e73f183e01fa0b71e4b9248b6a19a3f7d697.1430394884.git.viresh.kumar@linaro.org>
 <20150512214224.16410.15922@quantum>
 <20150513085528.GA6994@linux>
 <20150513110357.GD3066@sirena.org.uk>
 <20150514003201.20636.83883@quantum>
 <CAKohpokeKtcJdrBcPZBBPR2zfJgpvuM_=wRaX5q1Uto2qx1oHQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ig0-f173.google.com ([209.85.213.173]:38407 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752854AbbEOOP3 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 15 May 2015 10:15:29 -0400
Received: by igcau1 with SMTP id au1so26870297igc.1
        for <linux-pm@vger.kernel.org>; Fri, 15 May 2015 07:15:29 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAKohpokeKtcJdrBcPZBBPR2zfJgpvuM_=wRaX5q1Uto2qx1oHQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Michael Turquette <mike.turquette@linaro.org>
Cc: Mark Brown <broonie@kernel.org>, Rafael Wysocki <rjw@rjwysocki.net>, rob.herring@linaro.org, arnd.bergmann@linaro.org, nm@ti.com, sboyd@codeaurora.org, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, grant.likely@linaro.org, olof@lixom.net, Sudeep.Holla@arm.com, devicetree@vger.kernel.org, viswanath.puttagunta@linaro.org, l.stach@pengutronix.de, thomas.petazzoni@free-electrons.com, linux-arm-kernel@lists.infradead.org, ta.omasab@gmail.com, kesavan.abhilash@gmail.com, khilman@linaro.org, santosh.shilimkar@oracle.com

On 14-05-15, 03:25, Michael Turquette wrote:
> No, we don't understand the problem space well enough to form an ABI.

And why do you think so? We have been facing many problems since a
long time which we are trying to solve here.

I agree that it might not be right to try too many things which may
not be required later, but most of the things we have now in new
bindings are actually required.

> Putting this stuff in C without any philosophical constraints on whether
> or not we can change it later is the way to go.

I don't agree to that :)

-- 
viresh
