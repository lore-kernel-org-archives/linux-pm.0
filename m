From: Mikko Perttunen <mikko.perttunen@kapsi.fi>
Subject: Re: [PATCH v7 01/16] clk: tegra: Add binding for the Tegra124 DFLL
 clocksource
Date: Fri, 13 Feb 2015 12:19:30 +0200
Message-ID: <54DDCFB2.9070800@kapsi.fi>
References: <1420723339-30735-1-git-send-email-mikko.perttunen@kapsi.fi> <1420723339-30735-2-git-send-email-mikko.perttunen@kapsi.fi> <20150212135440.GG20811@tbergstrom-lnx.Nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kapsi.fi ([217.30.184.167]:59919 "EHLO mail.kapsi.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752068AbbBMKTh (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 13 Feb 2015 05:19:37 -0500
In-Reply-To: <20150212135440.GG20811@tbergstrom-lnx.Nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter De Schrijver <pdeschrijver@nvidia.com>
Cc: swarren@wwwdotorg.org, thierry.reding@gmail.com, gnurou@gmail.com, rjw@rjwysocki.net, viresh.kumar@linaro.org, mturquette@linaro.org, pwalmsley@nvidia.com, vinceh@nvidia.com, pgaikwad@nvidia.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tuomas.tynkkynen@iki.fi, Tuomas Tynkkynen <ttynkkynen@nvidia.com>

On 02/12/2015 03:54 PM, Peter De Schrijver wrote:
> On Thu, Jan 08, 2015 at 03:22:04PM +0200, Mikko Perttunen wrote:
>> From: Tuomas Tynkkynen <ttynkkynen@nvidia.com>
>>
>> The DFLL is the main clocksource for the fast CPU cluster on Tegra124
>> and also provides automatic CPU rail voltage scaling as well. The DFLL
>> is a separate IP block from the usual Tegra124 clock-and-reset
>> controller, so it gets its own node in the device tree.
>>
>
> Please add devicetree@vger.kernel.org to the next CC list.

Will do. Thanks for the acks!

>
> Peter.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-tegra" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

