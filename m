From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 04/18] cpufreq: Manage fallback policies in a list
Date: Wed, 4 Feb 2015 11:48:48 +0530
Message-ID: <CAKohpomfsYGtkguJzF+Z_2PfWM_qKwzuoxQPg2YLQmMn4P7Dyw@mail.gmail.com>
References: <cover.1422346933.git.viresh.kumar@linaro.org>
	<4877089.HgQ3LJW3cC@vostro.rjw.lan>
	<CAKohponngR7eaWB-1D-knnc5R92b-0KQavperWH4ouT-ftp=Gg@mail.gmail.com>
	<4059137.7s0tgd0HrB@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f179.google.com ([209.85.214.179]:35322 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751072AbbBDGSs (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 4 Feb 2015 01:18:48 -0500
Received: by mail-ob0-f179.google.com with SMTP id wp4so12352713obc.10
        for <linux-pm@vger.kernel.org>; Tue, 03 Feb 2015 22:18:48 -0800 (PST)
In-Reply-To: <4059137.7s0tgd0HrB@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linaro Kernel Mailman List <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Stephen Boyd <sboyd@codeaurora.org>, Prarit Bhargava <prarit@redhat.com>, Saravana Kannan <skannan@codeaurora.org>

On 3 February 2015 at 20:34, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> No, it won't be the same.  The per-CPU memory is special.

> The general idea of the existing code is sane in my view.  It connects the
> fallback policy information with the given CPU directly, which generally is
> a good idea.  Storing that information in the per-CPU memory isn't a good
> idea, however.

Okay, will see what can be done.
