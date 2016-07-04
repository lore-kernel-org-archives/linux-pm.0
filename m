From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2 0/3] cpufreq: intel_pstate: trivial improvements
Date: Mon, 04 Jul 2016 15:03:40 +0200
Message-ID: <3551723.Jfuh0gHEp9@vostro.rjw.lan>
References: <1467022038-924-1-git-send-email-jszhang@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:63331 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753542AbcGDM7I (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 4 Jul 2016 08:59:08 -0400
In-Reply-To: <1467022038-924-1-git-send-email-jszhang@marvell.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jisheng Zhang <jszhang@marvell.com>
Cc: srinivas.pandruvada@linux.intel.com, lenb@kernel.org, viresh.kumar@linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On Monday, June 27, 2016 06:07:15 PM Jisheng Zhang wrote:
> The first patch fixes incorrect placement of __initdata
> 
> The second patch is to add __init/__initdata marker to some functions
> or varaiables so that we can discard them.
> 
> The third patch declares pid_params/pstate_funcs/hwp_active as
> __read_mostly, under the fact that they are mostly read and not
> written to.
> 
> 
> Since v1:
>  - add Viresh's ack
>  - fix the third patch commit msg: remove duplicated words
> 
> Jisheng Zhang (3):
>   intel_pstate: Fix incorrect placement of __initdata
>   intel_pstate: add __init/__initdata marker to some functions/variables
>   intel_pstate: Declare pid_params/pstate_funcs/hwp_active __read_mostly
> 
>  drivers/cpufreq/intel_pstate.c | 30 +++++++++++++++---------------
>  1 file changed, 15 insertions(+), 15 deletions(-)

All [1-3/3] applied (with tags), thanks!

