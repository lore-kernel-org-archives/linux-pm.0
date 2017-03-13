From: Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH] cpufreq: User/admin documentation update and
 consolidation
Date: Mon, 13 Mar 2017 16:54:38 -0600
Message-ID: <20170313165438.13eba0a7@lwn.net>
References: <2879165.8iN5Cik88G@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from ms.lwn.net ([45.79.88.28]:56446 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751921AbdCMWyk (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 13 Mar 2017 18:54:40 -0400
In-Reply-To: <2879165.8iN5Cik88G@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>

On Thu, 09 Mar 2017 16:28:32 +0100
"Rafael J. Wysocki" <rjw@rjwysocki.net> wrote:

> The user/admin documentation of cpufreq is badly outdated.  It
> conains stale and/or inaccurate information along with things
> that are not particularly useful.  Also, some of the important
> pieces are missing from it.
> 
> For this reason, add a new user/admin document for cpufreq
> containing current information to admin-guide and drop the old
> outdated .txt documents it is replacing.

Out of curiosity, how did you generate this?  Neither "git am" nor
"patch" wants to deal with it.  Can I ask for a retry?

Thanks,

jon
