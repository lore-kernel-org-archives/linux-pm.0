From: Oleksandr Natalenko <oleksandr@natalenko.name>
Subject: Re: [BUG] oops in cpufreq driver with AMD Kaveri CPU
Date: Tue, 12 Aug 2014 08:55:27 +0300
Message-ID: <1827037.Yd5d4GH5Ub@spock>
References: <4708675.eITUXPv8Ih@spock> <2651364.4shODVy8cx@spock> <CAOh2x=k2xpfqz+VjYpPbQy6Z5aeo8DxkYmk7JSmrAZxQOJSU9Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from natalenko.name ([78.47.77.148]:54669 "EHLO natalenko.name"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751444AbaHLFza (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 12 Aug 2014 01:55:30 -0400
In-Reply-To: <CAOh2x=k2xpfqz+VjYpPbQy6Z5aeo8DxkYmk7JSmrAZxQOJSU9Q@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>

On Tuesday 12 August 2014 11:22:28 Viresh Kumar wrote:
> Yeah, because this is happening while the notifiers are being served.
> Can you debug it a bit to go to the exact notifier routine where this
> crashes?

What should I do to debug it? Is that necessary to recompile kernel with full 
debug?

> Which patch are you talking about here?

I thought about this one [1], but I guess that's not my case.

[1] https://lkml.org/lkml/2014/7/16/815

-- 
Oleksandr post-factum Natalenko, MSc
pf-kernel community
https://natalenko.name/
