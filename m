From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 00/12] cpufreq: Fix governor races - part 2
Date: Thu, 18 Jun 2015 10:49:46 +0530
Message-ID: <20150618051946.GD28820@linux>
References: <cover.1434019473.git.viresh.kumar@linaro.org>
 <2124579.Ezk09YdVq9@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:33703 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751299AbbFRFTz (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 18 Jun 2015 01:19:55 -0400
Received: by padev16 with SMTP id ev16so52894367pad.0
        for <linux-pm@vger.kernel.org>; Wed, 17 Jun 2015 22:19:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <2124579.Ezk09YdVq9@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Preeti U Murthy <preeti@linux.vnet.ibm.com>, ke.wang@spreadtrum.com, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, ego@linux.vnet.ibm.com, paulus@samba.org, shilpa.bhat@linux.vnet.ibm.com, prarit@redhat.com, robert.schoene@tu-dresden.de, skannan@codeaurora.org

On 16-06-15, 01:29, Rafael J. Wysocki wrote:
> Given the Preeti's comments on these patches I don't think they are quite
> ready and the 4.2 merge window is next week.  I don't think this series is
> 4.2 material, so please target it at the next one.

I agreed to this earlier, yes. But will it be possible to push
[1-5]/12 for 4.2 ? Its not that they are really important and
something like that, but there is no point sending these trivial
patches to lists (they are already Reviewed-by Preeti, leaving 3/12
which I have asked her to review today). Wanna avoid unnecessary
noise over lists, that's it.

I see that these are not anymore in patchwork, so you might want me to
send them again. Will do that once you confirm.

Thanks.

-- 
viresh
