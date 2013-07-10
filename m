From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [v3.10 regression] deadlock on cpu hotplug
Date: Wed, 10 Jul 2013 12:04:12 +0530
Message-ID: <CAKohpomDednjDAtGR7Ccj3-mnRHpotUnFcDKjw=u9Y-Svq7swA@mail.gmail.com>
References: <1443144.WnBWEpaopK@amdc1032>
	<51DB724F.9050708@linux.vnet.ibm.com>
	<1754044.EVIH1UZj6p@amdc1032>
	<51DC0B0D.9070201@linux.vnet.ibm.com>
	<51DCDF1C.1000208@linux.vnet.ibm.com>
	<CAKohpokbo+X5bEYweBuSqr5bkdRsb-XHT7SrMWybwAvkfDsGBQ@mail.gmail.com>
	<51DCF982.4070707@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qa0-f49.google.com ([209.85.216.49]:53412 "EHLO
	mail-qa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750768Ab3GJGeN (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 10 Jul 2013 02:34:13 -0400
Received: by mail-qa0-f49.google.com with SMTP id hu16so3364478qab.8
        for <linux-pm@vger.kernel.org>; Tue, 09 Jul 2013 23:34:12 -0700 (PDT)
In-Reply-To: <51DCF982.4070707@linux.vnet.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Michael Wang <wangyun@linux.vnet.ibm.com>
Cc: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Borislav Petkov <bp@alien8.de>, Jiri Kosina <jkosina@suse.cz>, Tomasz Figa <t.figa@samsung.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

On 10 July 2013 11:34, Michael Wang <wangyun@linux.vnet.ibm.com> wrote:
> Thanks for the confirm :) seems like the root cause is very likely
> related with the problem Srivatsa discovered.
>
> I think the fix in his mail worth a try, but I need more investigations
> to confirm that's the right way...

Its not a fix really, but with that we can atleast confirm that we are on
the right path and the problem is exactly what he described.
