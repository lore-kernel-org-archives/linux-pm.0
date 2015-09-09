From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V2 3/9] cpufreq: ondemand: only queue canceled works from update_sampling_rate()
Date: Wed, 09 Sep 2015 22:10:12 +0200
Message-ID: <110936806.IYePDC4zPm@vostro.rjw.lan>
References: <cover.1437999691.git.viresh.kumar@linaro.org> <32794142.WpJFa6Ni1D@vostro.rjw.lan> <20150909023020.GI7639@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:64892 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752066AbbIITmW (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 9 Sep 2015 15:42:22 -0400
In-Reply-To: <20150909023020.GI7639@linux>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, preeti.lkml@gmail.com, open list <linux-kernel@vger.kernel.org>

On Wednesday, September 09, 2015 08:00:20 AM Viresh Kumar wrote:
> On 09-09-15, 03:06, Rafael J. Wysocki wrote:
> > I've just realized that if you combined this patch with the [6/9],
> > you wouldn't need to make any changes to gov_queue_work() at all,
> > because that patch removes the case in point entirely.
> 
> Yeah, but then these are really two separate issues at hand and so I
> solved them separately. Lemme know how you want to see that and I can
> change :)

I don't want to make artificial changes.

If you can address two problems in one go with one relatively simple patch,
why don't you do that?

Thanks,
Rafael

