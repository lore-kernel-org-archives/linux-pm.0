From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq: mt8173: use list_for_each_entry*()
Date: Fri, 22 Apr 2016 02:41:38 +0200
Message-ID: <1546830.rP9teHUGyP@vostro.rjw.lan>
References: <0679e197c8c0c4329d3d8190f1777fd61edbaebf.1459823809.git.geliangtang@163.com> <20160405030557.GC20655@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:53017 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751603AbcDVAiq (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 21 Apr 2016 20:38:46 -0400
In-Reply-To: <20160405030557.GC20655@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Geliang Tang <geliangtang@163.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On Tuesday, April 05, 2016 08:35:57 AM Viresh Kumar wrote:
> On 05-04-16, 10:38, Geliang Tang wrote:
> > Use list_for_each_entry*() instead of list_for_each*() to simplify
> > the code.
> > 
> > Signed-off-by: Geliang Tang <geliangtang@163.com>
> > ---
> >  drivers/cpufreq/mt8173-cpufreq.c | 14 ++++----------
> >  1 file changed, 4 insertions(+), 10 deletions(-)
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Applied, thanks!

