From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v5] cpufreq: fix governor start/stop race condition
Date: Thu, 20 Jun 2013 09:16:02 +0530
Message-ID: <CAKohpon7PjFpzeEPHdQ4SAGmhJ7T1UqrQB86zq9M7aarvNdx1A@mail.gmail.com>
References: <1371114118-19488-1-git-send-email-chenxg@marvell.com>
	<CAFgnuDe1bUub92uE1H9Fc9U7AJCYL=WKdyDe2bg00yEr=kMEbQ@mail.gmail.com>
	<CAKohpo=ADC_MGpXFp-QssYS70PHwBBA6qzrWhYGEqZeeaZHLDQ@mail.gmail.com>
	<2925371.ZJMOdCiC6f@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oa0-f54.google.com ([209.85.219.54]:36870 "EHLO
	mail-oa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935557Ab3FTDqD (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 19 Jun 2013 23:46:03 -0400
Received: by mail-oa0-f54.google.com with SMTP id o6so7350504oag.41
        for <linux-pm@vger.kernel.org>; Wed, 19 Jun 2013 20:46:02 -0700 (PDT)
In-Reply-To: <2925371.ZJMOdCiC6f@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Xiaoguang Chen <chenxg.marvell@gmail.com>, Xiaoguang Chen <chenxg@marvell.com>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, njiang1@marvell.com, zjwu@marvell.com, ylmao@marvell.com

On 20 June 2013 04:19, Rafael J. Wysocki <rjw@sisk.pl> wrote:

> Well, sentences that don't start from upper-case letters don't look like
> separate sentences

s/sequences/sentences for your initial mail.

I misunderstood it as, you want to name cpu{0|1|2} as CPU{1|2|3}..
Obviously sentences must start with capitals.

> and when I see "cpus" written like this I tend to read
> it as "cups" with a typo.

Hmm..
