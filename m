From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V5 2/2] cpufreq: Reuse new freq-table helpers
Date: Thu, 07 Jul 2016 15:29:48 +0200
Message-ID: <3343635.EHbr2qf22Z@vostro.rjw.lan>
References: <cover.1467001203.git.viresh.kumar@linaro.org> <29326603f17249f7636fc4ada43b96ad455fecbb.1467001203.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:50687 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751220AbcGGNZM (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 7 Jul 2016 09:25:12 -0400
In-Reply-To: <29326603f17249f7636fc4ada43b96ad455fecbb.1467001203.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, steve.muckle@linaro.org, linuxppc-dev@lists.ozlabs.org

On Monday, June 27, 2016 09:59:34 AM Viresh Kumar wrote:
> This patch migrates few users of cpufreq tables to the new helpers that
> work on sorted freq-tables.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Applied, thanks!

