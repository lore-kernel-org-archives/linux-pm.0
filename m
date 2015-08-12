From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: 3.18: lockdep problems in cpufreq
Date: Wed, 12 Aug 2015 10:08:57 +0100
Message-ID: <20150812090857.GJ7557@n2100.arm.linux.org.uk>
References: <20141214213655.GA11285@n2100.arm.linux.org.uk>
 <CAKohponhkk9BK6-7ScHeZa4R43iooWQFV8YoPLv6LjO40GNq=A@mail.gmail.com>
 <20150518185645.GA28053@n2100.arm.linux.org.uk>
 <2574268.XBqpdL2VLI@vostro.rjw.lan>
 <20150811170357.GA24529@n2100.arm.linux.org.uk>
 <20150812051659.GI32049@linux>
 <20150812072129.GD7557@n2100.arm.linux.org.uk>
 <20150812073530.GA16445@linux>
 <20150812074925.GG7557@n2100.arm.linux.org.uk>
 <20150812081257.GC16445@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:53809 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753784AbbHLJJK (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 12 Aug 2015 05:09:10 -0400
Content-Disposition: inline
In-Reply-To: <20150812081257.GC16445@linux>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Eduardo Valentin <edubezval@gmail.com>, Yadwinder Singh Brar <yadi.brar@samsung.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On Wed, Aug 12, 2015 at 01:42:57PM +0530, Viresh Kumar wrote:
> On 12-08-15, 08:49, Russell King - ARM Linux wrote:
> > The problem will be back-porting it to stable kernels, because I think
> > it's had to be updated at least a couple of times.  I don't have the old
> > versions anymore, so I'm just going to say "not my problem" - sorry.
> 
> Your old 3.18 version :)

And now generate versions for all the stable kernels inbetween.  Now
your problem.  I'm sick of this.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
