From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v3 0/2] Add stop callback to the cpufreq_driver interface.
Date: Wed, 19 Mar 2014 19:19:13 +0530
Message-ID: <CAKohpomkFQ0PhYja8eKC_NvX+Jc7JpDp8gpHFCDHWeeUQADwcQ@mail.gmail.com>
References: <1394831037-15553-1-git-send-email-dirk.j.brandewie@intel.com>
	<5240506.FBRh89S9Lg@vostro.rjw.lan>
	<CAKohpomc9YrBrG2SJFUuixDTNY6qVhq6X39Qv+=j73dFGxQTdQ@mail.gmail.com>
	<2106941.8EeNr4veQS@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qa0-f43.google.com ([209.85.216.43]:53705 "EHLO
	mail-qa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933886AbaCSNtO (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 19 Mar 2014 09:49:14 -0400
Received: by mail-qa0-f43.google.com with SMTP id j15so8502160qaq.2
        for <linux-pm@vger.kernel.org>; Wed, 19 Mar 2014 06:49:13 -0700 (PDT)
In-Reply-To: <2106941.8EeNr4veQS@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Dirk Brandewie <dirk.brandewie@gmail.com>, "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Patrick Marlier <patrick.marlier@gmail.com>, Dirk Brandewie <dirk.j.brandewie@intel.com>

On 19 March 2014 19:31, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> Let's add ->stop() (or whatever to call it) *specifically* for ->setpolicy
> drivers

setpolicy_stop() ? I know that's a bad name :)
