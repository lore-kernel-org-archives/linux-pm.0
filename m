From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 2/4] sched: cpufreq: Keep track of cpufreq utilization
 update flags
Date: Tue, 19 Dec 2017 09:11:18 +0530
Message-ID: <20171219034118.GP19815@vireshk-i7>
References: <20456740.6R3DDKEUDv@aspire.rjw.lan>
 <20171218045945.GG19815@vireshk-i7>
 <CAJZ5v0h+bvbe6DbMn+9DXbbctKG4POTsvEf_eL8R0nLajKXBTA@mail.gmail.com>
 <20171218115943.GL19815@vireshk-i7>
 <20171218121453.GH19821@e110439-lin>
 <20171219031237.GM19815@vireshk-i7>
 <CAJWu+ooGRedM_w6xBwhb+ype0SMmM8w-uEjjpzaTWmp-GueZDg@mail.gmail.com>
 <20171219032217.GN19815@vireshk-i7>
 <20171219032647.GO19815@vireshk-i7>
 <CAJWu+oo+_30hFy16Fnu=dmJV3u-8_EVZw1j2pBC5PbEMBrnWUg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pl0-f42.google.com ([209.85.160.42]:33312 "EHLO
        mail-pl0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933266AbdLSDlV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Dec 2017 22:41:21 -0500
Received: by mail-pl0-f42.google.com with SMTP id 1so4734057plv.0
        for <linux-pm@vger.kernel.org>; Mon, 18 Dec 2017 19:41:21 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAJWu+oo+_30hFy16Fnu=dmJV3u-8_EVZw1j2pBC5PbEMBrnWUg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Joel Fernandes <joelaf@google.com>
Cc: Patrick Bellasi <patrick.bellasi@arm.com>, "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Linux PM <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <juri.lelli@redhat.com>, Todd Kjos <tkjos@android.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On 18-12-17, 19:30, Joel Fernandes wrote:
> Yes that's clean to me but then as Rafael said, the use of this flag
> will be too specific for schedutil-only sg_cpu->flags clearing purpose
> right?

And so would be the extra parameter ?

-- 
viresh
