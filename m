From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: 3.18: lockdep problems in cpufreq
Date: Wed, 12 Aug 2015 08:49:25 +0100
Message-ID: <20150812074925.GG7557@n2100.arm.linux.org.uk>
References: <20141214213655.GA11285@n2100.arm.linux.org.uk>
 <CAKohponhkk9BK6-7ScHeZa4R43iooWQFV8YoPLv6LjO40GNq=A@mail.gmail.com>
 <20150518185645.GA28053@n2100.arm.linux.org.uk>
 <2574268.XBqpdL2VLI@vostro.rjw.lan>
 <20150811170357.GA24529@n2100.arm.linux.org.uk>
 <20150812051659.GI32049@linux>
 <20150812072129.GD7557@n2100.arm.linux.org.uk>
 <20150812073530.GA16445@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:53619 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753797AbbHLHtg (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 12 Aug 2015 03:49:36 -0400
Content-Disposition: inline
In-Reply-To: <20150812073530.GA16445@linux>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Eduardo Valentin <edubezval@gmail.com>, Yadwinder Singh Brar <yadi.brar@samsung.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On Wed, Aug 12, 2015 at 01:05:30PM +0530, Viresh Kumar wrote:
> On 12-08-15, 08:21, Russell King - ARM Linux wrote:
> > Maybe not - I often lose track of which patches are in what state -
> > tracking the state of 250+ patches over many months and in some cases
> > _years_ is not easy.
> 
> I agree..
> 
> > That's still no reason for Eduardo to _completely_ ignore this thread,
> > especially when Rafael explicitly tried to get comment from Eduardo.
> 
> Oh, no. I am not trying to be anybody's advocate here. I was just
> highlighting the point here, that I remembered.
> 
> Even I was quite busy then and couldn't get back to it.
> 
> Lets fix this now. I believe you have a patch for this based on latest
> kernel? Mind pasting that here for quick review?

I don't think it's changed much since the original, but I've posted
what's in linux-next as of today, and it doesn't conflict with anything.
So there's no excuse about getting it merged.

The problem will be back-porting it to stable kernels, because I think
it's had to be updated at least a couple of times.  I don't have the old
versions anymore, so I'm just going to say "not my problem" - sorry.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
