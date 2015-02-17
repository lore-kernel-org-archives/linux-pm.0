From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 04/18] cpufreq: Manage fallback policies in a list
Date: Tue, 17 Feb 2015 19:15:19 +0100
Message-ID: <35613222.up9lS5n2CM@vostro.rjw.lan>
References: <cover.1422346933.git.viresh.kumar@linaro.org> <1746505.56yzpQ04cT@vostro.rjw.lan> <CAKohpokrTCSZHUHiAfGumRh9zk590KSQii9U-1u+y194KY0PDg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:49399 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754561AbbBQRwH (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 17 Feb 2015 12:52:07 -0500
In-Reply-To: <CAKohpokrTCSZHUHiAfGumRh9zk590KSQii9U-1u+y194KY0PDg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Saravana Kannan <skannan@codeaurora.org>, Linaro Kernel Mailman List <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Stephen Boyd <sboyd@codeaurora.org>, Prarit Bhargava <prarit@redhat.com>

On Tuesday, February 17, 2015 01:36:47 PM Viresh Kumar wrote:
> On 5 February 2015 at 23:11, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > I'm still concerned about the case when the last policy CPU is physically
> > going away, in which we do the offline as a preliminary step and then
> > will go for full CPU device unregistration.
> 
> I need more clarity on how this happens. So, on a physical hotplug out:
> - We first do cpu offline, i.e. hotplug notifier gets called.

Yes.

> - And then during unregistration the sysfs remove will get called?

The CPU device goes away then and that should trigger the remove of all the
sysfs directories under it.


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
