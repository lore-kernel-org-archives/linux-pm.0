From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 04/18] cpufreq: Manage fallback policies in a list
Date: Thu, 19 Feb 2015 08:54:52 +0530
Message-ID: <CAKohpomLy3zn8JbpcAHxymzh=Mvkaij4kW0TVeXXk1VEht2BXg@mail.gmail.com>
References: <cover.1422346933.git.viresh.kumar@linaro.org>
	<1746505.56yzpQ04cT@vostro.rjw.lan>
	<CAKohpokrTCSZHUHiAfGumRh9zk590KSQii9U-1u+y194KY0PDg@mail.gmail.com>
	<35613222.up9lS5n2CM@vostro.rjw.lan>
	<CAKohpomw8+CnKXx=gF+OKPjrO3hC93Tdjimpx3Ba+He5xq3C8w@mail.gmail.com>
	<54E500ED.20001@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f176.google.com ([209.85.214.176]:50401 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751728AbbBSDYw (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 18 Feb 2015 22:24:52 -0500
Received: by mail-ob0-f176.google.com with SMTP id wo20so10078113obc.7
        for <linux-pm@vger.kernel.org>; Wed, 18 Feb 2015 19:24:52 -0800 (PST)
In-Reply-To: <54E500ED.20001@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Saravana Kannan <skannan@codeaurora.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linaro Kernel Mailman List <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Stephen Boyd <sboyd@codeaurora.org>, Prarit Bhargava <prarit@redhat.com>

On 19 February 2015 at 02:45, Saravana Kannan <skannan@codeaurora.org> wrote:
> During logical hotplug, you only get the hotplug notifiers.
> During physical hotplug, you get the subsys_remove.

>From Rafael's mail it looked like we also get hotplug notifiers..

So it will be hoplug notifier followed by subsys, and that would be a special
case then..

> So, we have all the information needed to distinguish. Remove the sysfs
> entries only in subsys-remove.

But hotplug notifiers would have already done most of the work we wanted.
And this will be a special case then.

Also, a policy might be shared by multiple CPUs and we need to take that
into account as well here..

So, not that straight forward as I can see it..

Also, are you aware of any way to emulate that ?
