From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [BUG] oops in cpufreq driver with AMD Kaveri CPU
Date: Wed, 13 Aug 2014 10:02:26 +0530
Message-ID: <CAKohpomF9QLLG-6evXWeUvrR9k7Y8ypVNdXyE4cAi=EFOQviHQ@mail.gmail.com>
References: <4708675.eITUXPv8Ih@spock>
	<CAOh2x=nJTuKKKyM72MUFSkrsH1eh1YgRUbfLcTCpfZzO85q80w@mail.gmail.com>
	<1449757.YVvGmvgCpE@spock>
	<3606476.mQLS7miLfb@spock>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f53.google.com ([209.85.218.53]:45486 "EHLO
	mail-oi0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750743AbaHMEc1 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 13 Aug 2014 00:32:27 -0400
Received: by mail-oi0-f53.google.com with SMTP id e131so7311658oig.40
        for <linux-pm@vger.kernel.org>; Tue, 12 Aug 2014 21:32:27 -0700 (PDT)
In-Reply-To: <3606476.mQLS7miLfb@spock>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Oleksandr Natalenko <oleksandr@natalenko.name>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>

On 12 August 2014 23:48, Oleksandr Natalenko <oleksandr@natalenko.name> wrote:
> Hmm, looks like I've put pr_info to policy notifier instead of transition
> notifier. Will fix it now and post new logs.

That's why you should have copied the diff here, so that I could have
confirmed if what you have done is correct or not.
