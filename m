From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V3 1/2] cpufreq: qoriq: Remove __exit macro from .exit callback
Date: Tue, 26 Apr 2016 02:03:16 +0200
Message-ID: <1537942.znLWuyUMVk@vostro.rjw.lan>
References: <1461056407-22542-1-git-send-email-hongtao.jia@nxp.com> <20160419091151.GA2905@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:60192 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751095AbcDZAAR (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 25 Apr 2016 20:00:17 -0400
In-Reply-To: <20160419091151.GA2905@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Jia Hongtao <hongtao.jia@nxp.com>
Cc: linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, scott.wood@nxp.com, yuantian.tang@nxp.com

On Tuesday, April 19, 2016 02:41:51 PM Viresh Kumar wrote:
> On 19-04-16, 17:00, Jia Hongtao wrote:
> > .exit callback (qoriq_cpufreq_cpu_exit()) is also used during suspend.
> > So __exit macro should be removed or the function will be discarded.
> > 
> > Signed-off-by: Jia Hongtao <hongtao.jia@nxp.com>
> > ---
> >  drivers/cpufreq/qoriq-cpufreq.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Applied, thanks!

