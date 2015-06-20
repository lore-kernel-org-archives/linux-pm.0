From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V7 2/3] OPP: Allow multiple OPP tables to be passed via DT
Date: Sat, 20 Jun 2015 07:48:41 +0530
Message-ID: <20150620021841.GA1955@linux>
References: <cover.1433434659.git.viresh.kumar@linaro.org>
 <263c128844f5a3c9280c8be71f6c9eb1869a5188.1433434659.git.viresh.kumar@linaro.org>
 <CAL_Jsq+EOOeQw42wZi+H82ovLn8LcQUuK9HGT+FvewdhTf7Q1w@mail.gmail.com>
 <20150617133314.GB15153@linux>
 <CAL_Jsq+SdgAf7=Yq7Jk_1d9jTpAOLCEuEDCZvD=-h=2MWsNfFw@mail.gmail.com>
 <55821F30.2090802@codeaurora.org>
 <20150618022543.GA28820@linux>
 <20150619184403.GC22132@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:33040 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752638AbbFTCSr (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 19 Jun 2015 22:18:47 -0400
Received: by padev16 with SMTP id ev16so96127548pad.0
        for <linux-pm@vger.kernel.org>; Fri, 19 Jun 2015 19:18:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20150619184403.GC22132@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Rob Herring <robherring2@gmail.com>, Rafael Wysocki <rjw@rjwysocki.net>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Arnd Bergmann <arnd.bergmann@linaro.org>, Nishanth Menon <nm@ti.com>, Mark Brown <broonie@kernel.org>, Mike Turquette <mike.turquette@linaro.org>, Grant Likely <grant.likely@linaro.org>, Olof Johansson <olof@lixom.net>, Sudeep Holla <Sudeep.Holla@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Viswanath Puttagunta <viswanath.puttagunta@linaro.org>, Lucas Stach <l.stach@pengutronix.de>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Thomas Abraham <ta.omasab@gmail.com>, Abhilash Kesavan <kesavan.abhilash@gmail.com>, Kevin Hilman <khilman@linaro.org>, Santosh

On 19-06-15, 11:44, Stephen Boyd wrote:
> On 06/18, Viresh Kumar wrote:
> > The problem you stated now was there with the current state of
> > bindings. The name is embedded into the OPP table node and so is fixed
> > for all the CPUs. Moving it to the CPU node will give all CPUs a
> > chance to name it whatever they want to. And the same list has to be
> > replicated to all CPUs sharing the clock rails.
> > 
> 
> Yes I don't see how the name will be different for any CPU, hence
> my complaint/question about duplicate names in each CPU. I guess
> it isn't any worse than clock-names though so I'm fine with it.

So what I wrote about the string being same for all CPUs, is valid
only to CPUs sharing clock line and hence OPPs. If there are CPUs with
independent lines, like in Krait, then the CPUs are free to choose
whatever name they want for the OPP tables, even if they are sharing
the same tables.

-- 
viresh
--
To unsubscribe from this list: send the line "unsubscribe linux-pm" in
