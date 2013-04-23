From: Lukasz Majewski <l.majewski@samsung.com>
Subject: Re: [RFC PATCH 0/2] cpufreq: Introduce LAB cpufreq governor.
Date: Tue, 23 Apr 2013 09:28:24 +0200
Message-ID: <20130423092824.66a6e8d2@amdc308.digital.local>
References: <1364804657-16590-1-git-send-email-jonghwa3.lee@samsung.com>
 <CAOh2x=nPJa0GReiN=OHLG=m4Gq51F=4VppdaQL20xi-aUa8x2Q@mail.gmail.com>
 <20130409123719.7399d5ad@amdc308.digital.local>
 <CAKohpomL-mdx6DdFiGwJzDSeWr6Gw-_F4T-D-Jz9TNH5MSgjbw@mail.gmail.com>
 <20130409184440.4cd87c1b@amdc308.digital.local>
 <CAKfTPtD6MK9ogq7mOijSxLSsH0n65Xra48XfRSB3DFs35GT=2g@mail.gmail.com>
 <20130410104452.661902af@amdc308.digital.local>
 <CAKfTPtDOG94CU=y9oohuJA-bqGpNFehTnebcvTcnQf5iYjwJTA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:46747 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754940Ab3DWH2v (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 23 Apr 2013 03:28:51 -0400
In-reply-to: <CAKfTPtDOG94CU=y9oohuJA-bqGpNFehTnebcvTcnQf5iYjwJTA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Viresh Kumar <viresh.kumar@linaro.org>, Jonghwa Lee <jonghwa3.lee@samsung.com>, Linux PM list <linux-pm@vger.kernel.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>

Hi Vincent,

> >> Hi Lukasz,
> >>
> >> I've got same comment on my current patch and I'm preparing a new
> >> version that can pack tasks more agressively based on the same
> >> buddy mecanism. This will be done at the cost of performance of
> >> course.  
> >
> > Can you share your development tree?  
> 
> The dev is not finished yet but i will share it as soon as possible

May I ask how the work with "more aggressive tasks packing" is going?

-- 
Best regards,

Lukasz Majewski

Samsung R&D Poland (SRPOL) | Linux Platform Group
