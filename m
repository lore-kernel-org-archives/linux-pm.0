From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq: Fix incorrect usage of clamp_val()
Date: Tue, 31 May 2016 22:44:40 +0200
Message-ID: <1862829.dZ7UDDBhHr@vostro.rjw.lan>
References: <a5c21ebe773d364b49bc5df9c4f69ff2eb181dbb.1464693539.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:54026 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750813AbcEaUkv (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 31 May 2016 16:40:51 -0400
In-Reply-To: <a5c21ebe773d364b49bc5df9c4f69ff2eb181dbb.1464693539.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org

On Tuesday, May 31, 2016 04:49:42 PM Viresh Kumar wrote:
> clamp_val() doesn't change anything by itself, rather it returns the
> clamped value.
> 
> Fix it.
> 
> Fixes: 0ac587b32f49 ("cpufreq: Use clamp_val() in __cpufreq_driver_target()")
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> Hi Rafael,
> 
> Please merge this with the offending commit if you are fine with rebase,
> else apply this one as well.

Done.

> Sorry for blindly copying code.

Well, I got that wrong myself after all ...

Thanks,
Rafael

