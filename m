From: Michael Turquette <mike.turquette@linaro.org>
Subject: Re: [PATCH V4 1/3] OPP: Redefine bindings to overcome shortcomings
Date: Wed, 13 May 2015 17:32:01 -0700
Message-ID: <20150514003201.20636.83883@quantum>
References: <cover.1430394884.git.viresh.kumar@linaro.org>
 <d225e73f183e01fa0b71e4b9248b6a19a3f7d697.1430394884.git.viresh.kumar@linaro.org>
 <20150512214224.16410.15922@quantum> <20150513085528.GA6994@linux>
 <20150513110357.GD3066@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ie0-f181.google.com ([209.85.223.181]:35577 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754711AbbENAcP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 13 May 2015 20:32:15 -0400
Received: by iebpz10 with SMTP id pz10so47651882ieb.2
        for <linux-pm@vger.kernel.org>; Wed, 13 May 2015 17:32:14 -0700 (PDT)
In-Reply-To: <20150513110357.GD3066@sirena.org.uk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, rob.herring@linaro.org, arnd.bergmann@linaro.org, nm@ti.com, sboyd@codeaurora.org, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, grant.likely@linaro.org, olof@lixom.net, Sudeep.Holla@arm.com, devicetree@vger.kernel.org, viswanath.puttagunta@linaro.org, l.stach@pengutronix.de, thomas.petazzoni@free-electrons.com, linux-arm-kernel@lists.infradead.org, ta.omasab@gmail.com, kesavan.abhilash@gmail.com, khilman@linaro.org, santosh.shilimkar@oracle.com

Quoting Mark Brown (2015-05-13 04:03:57)
> On Wed, May 13, 2015 at 02:25:28PM +0530, Viresh Kumar wrote:
> > On 12-05-15, 14:42, Michael Turquette wrote:
> > > Quoting Viresh Kumar (2015-04-30 05:07:59)
> > 
> > > Why should this new binding exist?
> 
> > The answer to this particular query is perhaps simple, i.e. we have
> > unsolved problems that we wanted to solve in a generic way.
> 
> > But probably the bigger question is "Should we really put the OPPs
> > (new or old bindings) in DT".
> 
> And also is trying to do this in a completely generic manner the right
> way of going about things - do we really understand the problem area
> well enough to create a completely generic solution for all cases,
> bearing in mind that once things go into a DT binding they become an ABI?

No, we don't understand the problem space well enough to form an ABI.
And even if we did understand it perfectly today, the constraints and
expressions will change tomorrow.

Putting this stuff in C without any philosophical constraints on whether
or not we can change it later is the way to go.

Regards,
Mike
