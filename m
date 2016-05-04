From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq: Use IS_ENABLED() instead of checking for built-in or module
Date: Wed, 04 May 2016 23:21:12 +0200
Message-ID: <1640438.89cURul1Mm@vostro.rjw.lan>
References: <1461716053-17722-1-git-send-email-javier@osg.samsung.com> <20160427020140.GU17047@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:43453 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752541AbcEDVSB (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 4 May 2016 17:18:01 -0400
In-Reply-To: <20160427020140.GU17047@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Javier Martinez Canillas <javier@osg.samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

On Wednesday, April 27, 2016 07:31:40 AM Viresh Kumar wrote:
> On 26-04-16, 20:14, Javier Martinez Canillas wrote:
> > The IS_ENABLED() macro checks if a Kconfig symbol has been enabled either
> > built-in or as a module, use that macro instead of open coding the same.
> > 
> > Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
> > 
> > ---
> > 
> >  drivers/cpufreq/e_powersaver.c    | 14 +++++++-------
> >  drivers/cpufreq/ppc_cbe_cpufreq.h |  2 +-
> >  2 files changed, 8 insertions(+), 8 deletions(-)
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Applied, thanks!

