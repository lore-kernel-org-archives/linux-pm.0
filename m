From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 05/13] cpufreq: e_powersave: call CPUFREQ_POSTCHANGE
 notfier in error cases
Date: Wed, 19 Jun 2013 20:24:41 +0530
Message-ID: <CAKohpomzWEX+VSNHzBAEJ1aFQtiODBTJfr1PSKxqDvXoWTtg3Q@mail.gmail.com>
References: <cover.1371630975.git.viresh.kumar@linaro.org>
	<859db6d3cfc0efbd5b96783967c10cfcb8b5a51a.1371630975.git.viresh.kumar@linaro.org>
	<20130619122202.GB32292@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oa0-f44.google.com ([209.85.219.44]:33938 "EHLO
	mail-oa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756724Ab3FSOym (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 19 Jun 2013 10:54:42 -0400
Received: by mail-oa0-f44.google.com with SMTP id l10so6742161oag.31
        for <linux-pm@vger.kernel.org>; Wed, 19 Jun 2013 07:54:41 -0700 (PDT)
In-Reply-To: <20130619122202.GB32292@verge.net.au>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Simon Horman <horms@verge.net.au>, Dave Jones <davej@redhat.com>
Cc: rjw@sisk.pl, linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, robin.randhawa@arm.com, Steve.Bannister@arm.com, Liviu.Dudau@arm.com, charles.garcia-tobin@arm.com, arvind.chauhan@arm.com, dave.martin@arm.com

On 19 June 2013 17:52, Simon Horman <horms@verge.net.au> wrote:
> I have no objections to this change but at the same time I don't
> feel that I know the code well enough to review it.

Probably I made a mistake adding your name. Don't know how I
made up my mind that you are the main contributor for this.

Probably Dave is?
