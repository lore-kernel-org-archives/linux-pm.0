From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 0/3] cpuidle: small improvements & fixes for menu governor (resend)
Date: Thu, 05 Nov 2015 23:34:29 +0100
Message-ID: <1547516.IzrSrfmAQk@vostro.rjw.lan>
References: <1446590059-18897-1-git-send-email-riel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:46355 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1756866AbbKEWFS (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 5 Nov 2015 17:05:18 -0500
In-Reply-To: <1446590059-18897-1-git-send-email-riel@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: riel@redhat.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, rafael.j.wysocki@intel.com, arjan@linux.intel.com, len.brown@intel.com, daniel.lezcano@linaro.org

On Tuesday, November 03, 2015 05:34:16 PM riel@redhat.com wrote:
> While working on a paravirt cpuidle driver for KVM guests, I
> noticed a number of small logic errors in the menu governor
> code.
> 
> These patches should get rid of some artifacts that can break
> the logic in the menu governor under certain corner cases, and
> make idle state selection work better on CPUs with long C1 exit
> latencies.
> 
> I have not seen any adverse effects with them in my (quick)
> tests. As expected, they do not seem to do much on systems with
> many power states and very low C1 exit latencies and target residencies. 

Thanks!

The patches look good to me.

I might apply [1-2/3] right away, but I'm a bit hesitant about the [3/3] (I'd
like it to spend some time in linux-next before it goes to Linus).  Also, we've
lived without these changes for quite some time and I don't want to stretch the
process too much, so I'll queue them up for v4.5 if that's not a problem.

Thanks,
Rafael

