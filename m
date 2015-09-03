From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V2 Resend 0/5] PM / OPP: Add debugfs support
Date: Thu, 03 Sep 2015 03:05:12 +0200
Message-ID: <1528146.dlEkeu6D3U@vostro.rjw.lan>
References: <cover.1441083292.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:42735 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754822AbbICAha (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 2 Sep 2015 20:37:30 -0400
In-Reply-To: <cover.1441083292.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: sboyd@codeaurora.org, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, nm@ti.com, khilman@linaro.org

On Tuesday, September 01, 2015 10:28:31 AM Viresh Kumar wrote:
> Hi Guys,
> 
> This series is targeted towards exposing opp information at user space.
> I wasn't really sure about adding them to sysfs, as its mostly static
> (fixed) data and so debugfs looked to be better place.
> 
> This series starts with 2 cleanup patches, and then moves all opp stuff
> to a new directory, as its expanding enough now.
> 
> The last patch adds debugfs support for OPPs and works for both old and
> new v2 bindings.
> 
> Rebased over: pm/bleeding-edge branch.
> 
> V2->V2-Resend:
> - V2 1/6 is dropped as its already merged, rest unchanged.
> 
> V1->V2:
> - Moved the second patch to the top as its a fix (Dan Carpenter &
>   Stephen).
> - Also updated it to fix things properly.
> - rearranged opp entry in drivers/base/power/Makefile (Stephen)
> - Device-directory name also includes its parent name now, to make it
>   more unique (Stephen).
> - Migrate debugfs directory properly if unregistered for the owner
>   device (Stephen).
> 
> Viresh Kumar (5):
>   PM / OPP: reuse of_parse_phandle()
>   PM / OPP: Prefix exported opp routines with dev_pm_opp_
>   PM / OPP: Move opp core to its own directory
>   PM / OPP: Move cpu specific code to opp/cpu.c
>   PM / OPP: Add debugfs support

This series is generally fine by me, but it causes too much code churn
to happen for pushing it into 4.3 at this point.  I can queue it up
for the next merge widnow.

Thanks,
Rafael

