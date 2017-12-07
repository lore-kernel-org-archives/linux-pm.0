From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: longhaul: Set transition_delay_us to 20 ms
Date: Thu, 7 Dec 2017 10:10:19 +0530
Message-ID: <20171207044019.kxwusyl5qoxq7zta@vireshk-mac-ubuntu>
References: <alpine.LRH.2.21.1711241741080.10361@math.ut.ee>
 <ed89c17b60d7183144ab4ac4b125fbed373fe670.1511838689.git.viresh.kumar@linaro.org>
 <alpine.LRH.2.21.1712051017060.2774@math.ut.ee>
 <alpine.LRH.2.21.1712051054170.2774@math.ut.ee>
 <CAJZ5v0henViynygKTRqpYWr6mfm_LJALH6wurNhxM_AXLU4Kzg@mail.gmail.com>
 <alpine.LRH.2.21.1712062020200.11844@math.ut.ee>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f171.google.com ([209.85.192.171]:46117 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752194AbdLGEkY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 6 Dec 2017 23:40:24 -0500
Received: by mail-pf0-f171.google.com with SMTP id c204so3777710pfc.13
        for <linux-pm@vger.kernel.org>; Wed, 06 Dec 2017 20:40:24 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.21.1712062020200.11844@math.ut.ee>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Meelis Roos <mroos@linux.ee>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Rafael Wysocki <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, "4 . 14+" <stable@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On 06-12-17, 20:21, Meelis Roos wrote:
> 30000 was not reliable.
> 
> I created root cron job
> @reboot sleep 120; /sbin/reboot
> 
> and by the evening it was dead again.
> 
> Will try 50000 tomorrow.

Lets make it similar to what it was before my original patch modified
it, to avoid all corner cases.

Please test against 200 ms, 200000 value here.

-- 
viresh
