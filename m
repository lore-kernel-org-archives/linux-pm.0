From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 04/18] cpufreq: Manage fallback policies in a list
Date: Tue, 3 Feb 2015 09:40:58 +0530
Message-ID: <CAKohponngR7eaWB-1D-knnc5R92b-0KQavperWH4ouT-ftp=Gg@mail.gmail.com>
References: <cover.1422346933.git.viresh.kumar@linaro.org>
	<43d728016b775d1b0fc02c981eb0520ac08297f5.1422346933.git.viresh.kumar@linaro.org>
	<4877089.HgQ3LJW3cC@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f175.google.com ([209.85.214.175]:35750 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965100AbbBCEK7 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 2 Feb 2015 23:10:59 -0500
Received: by mail-ob0-f175.google.com with SMTP id va2so8571099obc.6
        for <linux-pm@vger.kernel.org>; Mon, 02 Feb 2015 20:10:58 -0800 (PST)
In-Reply-To: <4877089.HgQ3LJW3cC@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linaro Kernel Mailman List <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Stephen Boyd <sboyd@codeaurora.org>, Prarit Bhargava <prarit@redhat.com>, Saravana Kannan <skannan@codeaurora.org>

On 3 February 2015 at 06:11, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> This becomes quite inefficient on a system with many CPUs having different
> policies.  My approach would be to somehow attach the fallback policy information
> to the CPU device object.

It will be same as the per-cpu approach which we are fed up of.
