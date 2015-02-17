From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 04/18] cpufreq: Manage fallback policies in a list
Date: Tue, 17 Feb 2015 13:36:47 +0530
Message-ID: <CAKohpokrTCSZHUHiAfGumRh9zk590KSQii9U-1u+y194KY0PDg@mail.gmail.com>
References: <cover.1422346933.git.viresh.kumar@linaro.org>
	<6147604.f4mimnOd4x@vostro.rjw.lan>
	<54D2CD76.2030609@codeaurora.org>
	<1746505.56yzpQ04cT@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f171.google.com ([209.85.214.171]:33683 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756139AbbBQIGr (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 17 Feb 2015 03:06:47 -0500
Received: by mail-ob0-f171.google.com with SMTP id gq1so50627597obb.2
        for <linux-pm@vger.kernel.org>; Tue, 17 Feb 2015 00:06:47 -0800 (PST)
In-Reply-To: <1746505.56yzpQ04cT@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Saravana Kannan <skannan@codeaurora.org>, Linaro Kernel Mailman List <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Stephen Boyd <sboyd@codeaurora.org>, Prarit Bhargava <prarit@redhat.com>

On 5 February 2015 at 23:11, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> I'm still concerned about the case when the last policy CPU is physically
> going away, in which we do the offline as a preliminary step and then
> will go for full CPU device unregistration.

I need more clarity on how this happens. So, on a physical hotplug out:
- We first do cpu offline, i.e. hotplug notifier gets called.
- And then during unregistration the sysfs remove will get called?

I haven't taken care of this as I never understood what actually happens
in terms of code sequencing ..

Will take care of that in next revision once I get answers to above queries.

--
viresh
