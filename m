From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH v2] cpufreq: tests: Providing cpufreq regression test
Date: Wed, 23 Jul 2014 17:02:28 +0200
Message-ID: <20140723150228.GE2856@lunn.ch>
References: <1405678985-21677-1-git-send-email-l.majewski@samsung.com>
 <1405926154-27214-1-git-send-email-l.majewski@samsung.com>
 <CAKohpondk7Cty8MhTcjyzZW8Z0o4AVupYE0rRnG4YJf+SmDyjg@mail.gmail.com>
 <20140723093824.5e51918f@amdc2363>
 <CAKohpok++gPcNk9-E4MsFdNBy8qL7oLYvatk1EvcW1OHwroZXQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from vps0.lunn.ch ([178.209.37.122]:51858 "EHLO vps0.lunn.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757100AbaGWPHe (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 23 Jul 2014 11:07:34 -0400
Content-Disposition: inline
In-Reply-To: <CAKohpok++gPcNk9-E4MsFdNBy8qL7oLYvatk1EvcW1OHwroZXQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Lukasz Majewski <l.majewski@samsung.com>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Thomas Abraham <ta.omasab@gmail.com>, Linux PM list <linux-pm@vger.kernel.org>, Lukasz Majewski <l.majewski@majess.pl>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "thomas.ab@samsung.com" <thomas.ab@samsung.com>, Sachin Kamat <spk.linux@gmail.com>, Tomasz Figa <t.figa@samsung.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Marek Szyprowski <m.szyprowski@samsung.com>

On Wed, Jul 23, 2014 at 02:19:54PM +0530, Viresh Kumar wrote:
> On 23 July 2014 13:08, Lukasz Majewski <l.majewski@samsung.com> wrote:
> > Do you want to say that we have enough tests and we don't need more ?
> 
> No. We don't have any tests at all :)

Not really true. I've found bugs triggering opps using cpufreq-bench.
http://marc.info/?l=linux-pm&m=138165517321579&w=2

and i hope you learned from that experience and run this tool when
making changes to the core.

There is an old writeup of cpufreq-bench here:
https://lwn.net/Articles/339862/

and the code itself is in the mainline tree, tools/power/cpupower/bench

	Andrew
