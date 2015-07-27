From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2] cpufreq: Avoid attempts to create duplicate symbolic
 links
Date: Mon, 27 Jul 2015 20:09:35 +0530
Message-ID: <20150727143935.GB18535@linux>
References: <1660815.CyKx9SEI9c@vostro.rjw.lan>
 <CAJZ5v0i6t36Nr7nFOKjGY5fBjzR=h+rNHcHWYd=eEdapMWQEGQ@mail.gmail.com>
 <20150727022718.GE19944@linux>
 <4080510.IQ60sVQvbL@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f178.google.com ([209.85.192.178]:36254 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753380AbbG0Ojk (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 27 Jul 2015 10:39:40 -0400
Received: by pdjr16 with SMTP id r16so54073953pdj.3
        for <linux-pm@vger.kernel.org>; Mon, 27 Jul 2015 07:39:39 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4080510.IQ60sVQvbL@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Russell King <linux@arm.linux.org.uk>

On 27-07-15, 15:45, Rafael J. Wysocki wrote:
> Say the subsys add callback runs for a CPU and it doesn't have a policy.
> If it is offline, we ignore it and the add callback won't be executed
> for it again.
> 
> In turn, if it is online, we create a policy for it and we should (right
> away) link the policy to all of the CPUs that were offline when the subsys add
> callback was called for them.  That's what we do today.
> 
> Is there anything missing in that?

So the code is working properly after your patch, but I was talking
on the lines of what Russell suggested.

We should play with the links only when we receive add-dev/remove-dev
from subsys callbacks. The exception to that will be the offline CPUs
for which add-dev is called before their policy existed.

-- 
viresh
