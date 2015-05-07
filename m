From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V2 07/20] cpufreq: Call schedule_work() for the last active policy
Date: Fri, 08 May 2015 00:13:54 +0200
Message-ID: <2152819.QdP4XlLrSF@vostro.rjw.lan>
References: <cover.1424345053.git.viresh.kumar@linaro.org> <551CBA45.6080702@codeaurora.org> <CAKohpo=+xD4vxhB=CrNGMCgVMz-P-745qfieTvJP7YHi6f+xNg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:61834 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750907AbbEGVsu (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 7 May 2015 17:48:50 -0400
In-Reply-To: <CAKohpo=+xD4vxhB=CrNGMCgVMz-P-745qfieTvJP7YHi6f+xNg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Saravana Kannan <skannan@codeaurora.org>, Linaro Kernel Mailman List <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Stephen Boyd <sboyd@codeaurora.org>, Prarit Bhargava <prarit@redhat.com>

On Thursday, April 02, 2015 10:32:54 AM Viresh Kumar wrote:
> On 2 April 2015 at 09:10, Saravana Kannan <skannan@codeaurora.org> wrote:
> > Ok, I don't think this will work after the next patch/end of the series.
> 
> Sigh, Its broken today as well. See my another patch:
> 
> [PATCH] cpufreq: Schedule work for the first-online CPU on resume
> 
> This patch is dropped now.

What exactly does this mean?


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
