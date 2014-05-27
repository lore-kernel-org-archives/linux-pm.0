From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V3 4/8] driver/core: cpu: initialize opp table
Date: Tue, 27 May 2014 13:30:09 +0200
Message-ID: <11801597.a0CDeJOEp5@vostro.rjw.lan>
References: <cover.1400736536.git.viresh.kumar@linaro.org> <CAKohponagSjOVbn-C64yh7=py9kE0m2VGbdquo_1+UzbPFsJ+w@mail.gmail.com> <CAKohpokZSw430PWjJfYOPA6KXOJiKFhxRi4BuEf6ouMgUHQ+gw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:64429 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751577AbaE0LNF (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 27 May 2014 07:13:05 -0400
In-Reply-To: <CAKohpokZSw430PWjJfYOPA6KXOJiKFhxRi4BuEf6ouMgUHQ+gw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Arvind Chauhan <arvind.chauhan@arm.com>, Ips Gandhi <inderpal.s@samsung.com>, Nishanth Menon <nm@ti.com>, Chander Kashyap <chander.kashyap@linaro.org>, Pavel Machek <pavel@ucw.cz>, "Brown, Len" <len.brown@intel.com>, Sudeep Holla <sudeep.holla@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Amit Daniel Kachhap <amit.daniel@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, Shawn Guo <shawn.guo@linaro.org>

On Tuesday, May 27, 2014 05:48:27 AM Viresh Kumar wrote:
> On 27 May 2014 05:34, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > We are also using it for cpu->dev_id, but that's not so important. This
> > routine wouldn't have existed if you wouldn't have asked for it. It is
> > just a wrapper over of_init_opp_table, which also has a dummy
> > implementation when its not supported.
> >
> > So, it might not be worth enough for any other code to use it. :)
> > And so I added it here.
> >
> > Let me know how/where do you want it and I will resend it quickly.
> 
> There is another option here, add these print messages in
> of_init_opp_table() ? That's the only difference new wrapper has.

Yeah, put them into of_init_opp_table() rather I'd say.

Rafael

