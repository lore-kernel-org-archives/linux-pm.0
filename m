From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v4] powernv, cpufreq: cpufreq driver for powernv platform
Date: Fri, 28 Mar 2014 10:55:12 +0530
Message-ID: <CAKohpomuwkVVOgEbk4ARE+N6eo_tii9Msd1FbTgZfFK8Dvm9Uw@mail.gmail.com>
References: <1395852947-22290-1-git-send-email-ego@linux.vnet.ibm.com>
	<1395852947-22290-2-git-send-email-ego@linux.vnet.ibm.com>
	<CAKohponPb+b=8Pa=te3CkiN6QPAUAukngqLSdG4vxc9pUkD8OQ@mail.gmail.com>
	<20140327093050.GA27777@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f175.google.com ([209.85.214.175]:33510 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751069AbaC1FZN (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 28 Mar 2014 01:25:13 -0400
Received: by mail-ob0-f175.google.com with SMTP id uy5so5398280obc.34
        for <linux-pm@vger.kernel.org>; Thu, 27 Mar 2014 22:25:12 -0700 (PDT)
In-Reply-To: <20140327093050.GA27777@in.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "ego@linux.vnet.ibm.com" <ego@linux.vnet.ibm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>, Linux PM list <linux-pm@vger.kernel.org>, Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>, "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, Anton Blanchard <anton@samba.org>

On 27 March 2014 15:00, Gautham R Shenoy <ego@linux.vnet.ibm.com> wrote:
> As of now, I prefer this patch be based on code that is in the -next
> tree. I'll get rid of the per-core locking once the serialization
> patch of the core is accepted.

Okay, its pushed in -next now :)
