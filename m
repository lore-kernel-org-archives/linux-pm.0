From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 3/5] intel_pstate: remove intel_pstate.get()
Date: Fri, 16 Jun 2017 22:06:12 -0400
Message-ID: <CAJvTdKn79YOuJqGV47o920mKkSe9=g5sTmOyMBm8m0OLjUFYNw@mail.gmail.com>
References: <1496889556-17923-1-git-send-email-lenb@kernel.org>
 <1963166.eOk3pBXQhq@aspire.rjw.lan> <CAJvTdKmmHSM8FJq=1d4vQAYg=orgHb7OFRLmZ7EH2yWM7mQcAg@mail.gmail.com>
 <1534231.XqQ6Lv6Ybd@aspire.rjw.lan> <CAJZ5v0itMGFq3PZSoy23ybSXfhP_-v4WKWXCT6A0dOssED-gwA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qk0-f179.google.com ([209.85.220.179]:36589 "EHLO
        mail-qk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752163AbdFQCGN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 16 Jun 2017 22:06:13 -0400
In-Reply-To: <CAJZ5v0itMGFq3PZSoy23ybSXfhP_-v4WKWXCT6A0dOssED-gwA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, X86 ML <x86@kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, "H. Peter Anvin" <hpa@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Linux PM list <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>

> On a second thought, in order to compute the frequency, user space
> needs to know the scaling and the max_pstate_physical value too, which
> may not be straightforward to obtain (on some Atoms, for example).

unless you run turbostat:-)

> So why don't we leave the tracepoint as is for now?

sure, no problem.
-- 
Len Brown, Intel Open Source Technology Center
