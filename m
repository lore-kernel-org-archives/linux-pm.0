From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 04/18] cpufreq: Manage fallback policies in a list
Date: Wed, 18 Feb 2015 09:53:07 +0530
Message-ID: <CAKohpomw8+CnKXx=gF+OKPjrO3hC93Tdjimpx3Ba+He5xq3C8w@mail.gmail.com>
References: <cover.1422346933.git.viresh.kumar@linaro.org>
	<1746505.56yzpQ04cT@vostro.rjw.lan>
	<CAKohpokrTCSZHUHiAfGumRh9zk590KSQii9U-1u+y194KY0PDg@mail.gmail.com>
	<35613222.up9lS5n2CM@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f182.google.com ([209.85.214.182]:52940 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751568AbbBREXI (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 17 Feb 2015 23:23:08 -0500
Received: by mail-ob0-f182.google.com with SMTP id nt9so59870299obb.13
        for <linux-pm@vger.kernel.org>; Tue, 17 Feb 2015 20:23:07 -0800 (PST)
In-Reply-To: <35613222.up9lS5n2CM@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Saravana Kannan <skannan@codeaurora.org>, Linaro Kernel Mailman List <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Stephen Boyd <sboyd@codeaurora.org>, Prarit Bhargava <prarit@redhat.com>

On 17 February 2015 at 23:45, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>> - And then during unregistration the sysfs remove will get called?

I meant subsys-remove here, sorry :(

> The CPU device goes away then and that should trigger the remove of all the
> sysfs directories under it.

How will the cpufreq core know about it? cpufreq_remove_dev() will get called?

Is there a way to emulate it? So that I can test it in my setup..
