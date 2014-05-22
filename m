From: Paul Bolle <pebolle@tiscali.nl>
Subject: Re: [PATCH] cpufreq: s5pv210: remove unused call of pr_err()
Date: Thu, 22 May 2014 08:41:34 +0200
Message-ID: <1400740894.21254.8.camel@x220>
References: <1400702036.30334.6.camel@x220>
	 <CAK9yfHz2kdfkf+o7fKMRu=nMXxbcHJ227bjpvA=WXt6ptH3QRA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cpsmtpb-ews05.kpnxchange.com ([213.75.39.8]:54103 "EHLO
	cpsmtpb-ews05.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751184AbaEVGlh (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 22 May 2014 02:41:37 -0400
In-Reply-To: <CAK9yfHz2kdfkf+o7fKMRu=nMXxbcHJ227bjpvA=WXt6ptH3QRA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

Sachin,

On Thu, 2014-05-22 at 08:52 +0530, Sachin Kamat wrote:
> The config symbol itself is not defined and hence could be removed.
> However I feel, the
> error message could be retained after trimming down the arguments a bit.

My reasoning is, of course, that never used code can simply be dropped.

But you want to print an error here. That's fine with me. I prefer if
you'd submit a patch that does that, as I have no idea whatsoever why an
error is needed here nor what that error should say.

I do hope you don't mind me prodding you if that takes too long, and
this pointless check of CONFIG_PM_VERBOSE is still here after, say,
another development cycle.


Paul Bolle

