From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2 07/20] cpufreq: Call schedule_work() for the last
 active policy
Date: Fri, 8 May 2015 08:06:04 +0530
Message-ID: <CAKohpo=SAwAcUPc=Mzo07P5NszhZrrsB4JdtvahcFZT15wYc_Q@mail.gmail.com>
References: <cover.1424345053.git.viresh.kumar@linaro.org>
	<551CBA45.6080702@codeaurora.org>
	<CAKohpo=+xD4vxhB=CrNGMCgVMz-P-745qfieTvJP7YHi6f+xNg@mail.gmail.com>
	<2152819.QdP4XlLrSF@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f50.google.com ([209.85.218.50]:33188 "EHLO
	mail-oi0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752088AbbEHCgF (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 7 May 2015 22:36:05 -0400
Received: by oica37 with SMTP id a37so48840552oic.0
        for <linux-pm@vger.kernel.org>; Thu, 07 May 2015 19:36:04 -0700 (PDT)
In-Reply-To: <2152819.QdP4XlLrSF@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Saravana Kannan <skannan@codeaurora.org>, Linaro Kernel Mailman List <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Stephen Boyd <sboyd@codeaurora.org>, Prarit Bhargava <prarit@redhat.com>

On 8 May 2015 at 03:43, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> What exactly does this mean?

That the $Subject patch is replaced by:

c75de0ac0756 ("cpufreq: Schedule work for the first-online CPU on resume")

as its not that my series has broken what Saravana has found out. But
it was broken even without my series.
