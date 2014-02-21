From: Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: Re: [PATCH] cpuidle/mips: remove redundant cpuidle_idle_call()
Date: Fri, 21 Feb 2014 17:27:20 -0500 (EST)
Message-ID: <alpine.LFD.2.11.1402211719140.17677@knanqh.ubzr>
References: <alpine.LFD.2.11.1402171101060.17677@knanqh.ubzr> <20140221214428.GJ19285@linux-mips.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qc0-f173.google.com ([209.85.216.173]:39758 "EHLO
	mail-qc0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754457AbaBUW1X (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 21 Feb 2014 17:27:23 -0500
Received: by mail-qc0-f173.google.com with SMTP id i8so6732289qcq.4
        for <linux-pm@vger.kernel.org>; Fri, 21 Feb 2014 14:27:22 -0800 (PST)
In-Reply-To: <20140221214428.GJ19285@linux-mips.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Paul Burton <paul.burton@imgtec.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org, linux-mips@linux-mips.org

On Fri, 21 Feb 2014, Ralf Baechle wrote:

> On Mon, Feb 17, 2014 at 11:09:45AM -0500, Nicolas Pitre wrote:
> 
> > I noticed commit c0b5d598aefda in linux-next adds a call to 
> > cpuidle_idle_call().  At the same time we're rationalizing the idle 
> > handling code in order to integrate it with the scheduler proper.  
> > Please note that a similar patch to the one below will be necessary once 
> > everything gets merged together.
> 
> So how shall we merge this patch, shall I fold it into c0b5d598aefda or?

Merging it on your side is probably the best option.  There would be a 
window in mainline during which the callback registered with cpuidle 
won't be invoked, but that is not worse than the v3.13 behavior.


Nicolas
