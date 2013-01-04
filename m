From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 1/3] cpufreq: Manage only online cpus
Date: Fri, 04 Jan 2013 12:32:54 +0100
Message-ID: <1908625.BmKqKVnVdj@vostro.rjw.lan>
References: <98330b2deb910453a356404b8cf774c94326bc42.1355636864.git.viresh.kumar@linaro.org> <6008147.vspAd29d9L@vostro.rjw.lan> <CAKohpo=ok5aH77ycMKPAdHgUkf2HcwMgik+6eZp1Du1QVYxPZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:59784 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753837Ab3ADL1R (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 4 Jan 2013 06:27:17 -0500
In-Reply-To: <CAKohpo=ok5aH77ycMKPAdHgUkf2HcwMgik+6eZp1Du1QVYxPZQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-dev@lists.linaro.org, nicolas.pitre@linaro.org, amit.kucheria@linaro.org, mathieu.poirier@linaro.org, linux-kernel@vger.kernel.org, cpufreq@vger.kernel.org, pdsw-power-team@arm.com, linux-pm@vger.kernel.org

On Friday, January 04, 2013 10:44:36 AM Viresh Kumar wrote:
> On 3 January 2013 17:32, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > True, but have those bugs been introduced recently (ie. in v3.8-rc1 or later)?
> 
> Don't know... I feel they were always there, its just that nobody
> tested it that way :)

That exactly is my point. :-)

If they have always been there, I don't see much reason for hurrying with the
fixes, so I'll queue them up for v3.9.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
