From: "Doug Smythies" <dsmythies@telus.net>
Subject: RE: [PATCH v3] cpufreq: intel_pstate: Generic governors support
Date: Mon, 21 Nov 2016 15:54:38 -0800
Message-ID: <004501d24452$a06d2440$e1476cc0$@net>
Mime-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cmta20.telus.net ([209.171.16.93]:38717 "EHLO cmta20.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752505AbcKUXyn (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 21 Nov 2016 18:54:43 -0500
References: 7V8gc8F0cCdRJ7V8lcAyAi
In-Reply-To: 7V8gc8F0cCdRJ7V8lcAyAi
Content-Language: en-ca
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "'Rafael J. Wysocki'" <rjw@rjwysocki.net>
Cc: 'Srinivas Pandruvada' <srinivas.pandruvada@linux.intel.com>, 'Linux Kernel Mailing List' <linux-kernel@vger.kernel.org>, 'Linux PM list' <linux-pm@vger.kernel.org>

On 2016.11.17 14:34 Rafael J. Wysocki wrote:

> v2 -> v3:
> The previous iteration didn't work correcty if ondemand was the default
>  governor, because it didn't set policy->cur during initialization and
>  that caused cpufreq_dbs_governor_start() to return an error (thanks to
>  Srinovas for finding that bug).

Just for the sake of due diligence:

I re-tested v3 with all the same tests I had done with previous versions,
with the same positive results that I got with v2.

On my test computer, I also re-created the v2 failure discovered by
Srinivas, and confirm it is O.K. with v3.

On the v2 thread you said:

> I'll add a Tested-by tag from you to it if you don't mind.

That would be fine.

... Doug


