From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq: cpufreq_register_driver should return -ENODEV if init fails
Date: Tue, 30 May 2017 23:42:29 +0200
Message-ID: <2895488.RT6FizubEO@aspire.rjw.lan>
References: <1495813051-146077-1-git-send-email-darcari@redhat.com> <20170529043215.GA5752@vireshk-i7> <78060adf-a388-daea-e587-4670c269778e@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:61273 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750811AbdE3VtV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 May 2017 17:49:21 -0400
In-Reply-To: <78060adf-a388-daea-e587-4670c269778e@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: David Arcari <darcari@redhat.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, linux-acpi@vger.kernel.org

On Tuesday, May 30, 2017 08:05:44 AM David Arcari wrote:
> On 05/29/2017 12:32 AM, Viresh Kumar wrote:
> > You sent it to the wrong list and missed Rafael too. MAINTAINERS file should
> > help getting these details in the future.
> 
> Oops - my bad.
> 
> Rafael - is this OK as is or would you prefer I resend this?

No need to resend, thanks!

I've actually queued it up already.

Thanks,
Rafael
