From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 4/6] cpufreq: conservative: Remove declaration of
 cs_dbs_gov
Date: Thu, 19 May 2016 07:43:53 +0530
Message-ID: <20160519021353.GH24777@vireshk-i7>
References: <cover.1463574213.git.viresh.kumar@linaro.org>
 <f51606d0f2c04852b7b5c2f1137238bbc1fe1828.1463574213.git.viresh.kumar@linaro.org>
 <CAJZ5v0gbFaEpRbSXaEr8X5_DjcuWParKdS+mUshmKrLu7xnRTQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f175.google.com ([209.85.192.175]:36638 "EHLO
	mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753303AbcESCN5 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 18 May 2016 22:13:57 -0400
Received: by mail-pf0-f175.google.com with SMTP id c189so25272654pfb.3
        for <linux-pm@vger.kernel.org>; Wed, 18 May 2016 19:13:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gbFaEpRbSXaEr8X5_DjcuWParKdS+mUshmKrLu7xnRTQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On 18-05-16, 23:03, Rafael J. Wysocki wrote:
> On Wed, May 18, 2016 at 2:25 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > The code doesn't use 'cs_dbs_gov' anymore before it is defined and the
> > extra line for declaring it can be removed.
> 
> This sort of conflicts with a patch I've just posted
> (https://patchwork.kernel.org/patch/9122121/) and I'd prefer to go
> with that one if that's not a big deal.

Yeah, drop it.

-- 
viresh
