From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 04/18] cpufreq: Manage fallback policies in a list
Date: Tue, 03 Feb 2015 16:04:51 +0100
Message-ID: <4059137.7s0tgd0HrB@vostro.rjw.lan>
References: <cover.1422346933.git.viresh.kumar@linaro.org> <4877089.HgQ3LJW3cC@vostro.rjw.lan> <CAKohponngR7eaWB-1D-knnc5R92b-0KQavperWH4ouT-ftp=Gg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:53829 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S965534AbbBCOl5 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 3 Feb 2015 09:41:57 -0500
In-Reply-To: <CAKohponngR7eaWB-1D-knnc5R92b-0KQavperWH4ouT-ftp=Gg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Linaro Kernel Mailman List <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Stephen Boyd <sboyd@codeaurora.org>, Prarit Bhargava <prarit@redhat.com>, Saravana Kannan <skannan@codeaurora.org>

On Tuesday, February 03, 2015 09:40:58 AM Viresh Kumar wrote:
> On 3 February 2015 at 06:11, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > This becomes quite inefficient on a system with many CPUs having different
> > policies.  My approach would be to somehow attach the fallback policy information
> > to the CPU device object.
> 
> It will be same as the per-cpu approach which we are fed up of.

No, it won't be the same.  The per-CPU memory is special.

The general idea of the existing code is sane in my view.  It connects the
fallback policy information with the given CPU directly, which generally is
a good idea.  Storing that information in the per-CPU memory isn't a good
idea, however.


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
