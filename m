From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2] cpufreq: Avoid attempts to create duplicate symbolic
 links
Date: Mon, 27 Jul 2015 07:57:18 +0530
Message-ID: <20150727022718.GE19944@linux>
References: <1660815.CyKx9SEI9c@vostro.rjw.lan>
 <20150724140943.GC16336@linux>
 <1509688.KKhdi8M36y@vostro.rjw.lan>
 <11080992.c5Q5Du7n5n@vostro.rjw.lan>
 <20150725130002.GC1691@linux>
 <CAJZ5v0i6t36Nr7nFOKjGY5fBjzR=h+rNHcHWYd=eEdapMWQEGQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:34685 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755256AbbG0C1X (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 26 Jul 2015 22:27:23 -0400
Received: by pacan13 with SMTP id an13so43895505pac.1
        for <linux-pm@vger.kernel.org>; Sun, 26 Jul 2015 19:27:23 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAJZ5v0i6t36Nr7nFOKjGY5fBjzR=h+rNHcHWYd=eEdapMWQEGQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Russell King <linux@arm.linux.org.uk>

On 26-07-15, 00:46, Rafael J. Wysocki wrote:
> OK, I'll prepare a new version of that patch then, but as I said this
> choice means that we'll be creating the links to the policy at the
> policy creation time going forward.

Atleast for the rc fix, we should do exactly this. Right.

But we can rethink about getting both my earlier patches merged for
4.3, which did this:

- Keep adding CPUs to a global mask, which didn't had a existing
  policy and were offline when subsys-callback for called for them.
- And then create the links only when the subsys callback is called
  for CPUs, for which policy already exist, as Russell suggested.

-- 
viresh
