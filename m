From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/2] cpufreq: serialize calls to __cpufreq_governor()
Date: Mon, 29 Sep 2014 17:25:58 +0530
Message-ID: <CAKohpom+eoJJGnXmGK1ZPPzoSRwQm8OVtR_0sP5waevXWWiDTQ@mail.gmail.com>
References: <efa1d8ae3e7b227b73a951d6072fa211d3cfe593.1410235439.git.viresh.kumar@linaro.org>
	<54294299.1060208@redhat.com>
	<CAKohpo=WumLcZAH1ezwBV1yCYO_q9mzSMb+2ZnQOf_r+50ToGQ@mail.gmail.com>
	<5429477F.3050008@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qa0-f49.google.com ([209.85.216.49]:39156 "EHLO
	mail-qa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750717AbaI2Lz7 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 29 Sep 2014 07:55:59 -0400
Received: by mail-qa0-f49.google.com with SMTP id n8so8620085qaq.22
        for <linux-pm@vger.kernel.org>; Mon, 29 Sep 2014 04:55:59 -0700 (PDT)
In-Reply-To: <5429477F.3050008@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Prarit Bhargava <prarit@redhat.com>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, =?UTF-8?Q?Robert_Sch=C3=B6ne?= <robert.schoene@tu-dresden.de>, Saravana Kannan <skannan@codeaurora.org>

On 29 September 2014 17:20, Prarit Bhargava <prarit@redhat.com> wrote:
> Send me what you have in mind -- I can always take a look and put it through
> tests as well.

The last set of changes I gave to Robert:

git://git.linaro.org/people/viresh.kumar/linux.git /cpufreq/governor-fixes
