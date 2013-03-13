From: Axel Lin <axel.lin@ingics.com>
Subject: Re: [PATCH 2/2] thermal: db8500: Fix missing mutex_unlock() in probe
 error paths
Date: Wed, 13 Mar 2013 16:17:35 +0800
Message-ID: <CAFRkauDSqaRVvv+Ai9Bw2XZO5d9+jB67gC0Pr3xxvs2D+KE_sg@mail.gmail.com>
References: <1363102940.3160.2.camel@phoenix>
	<1363103009.3160.3.camel@phoenix>
	<CAJLyvQxJ05HGtz79F-JKB0K9gdh5cwz3vjVbhn2vHnTWz54iMQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f169.google.com ([209.85.217.169]:56920 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750844Ab3CMIRh (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 13 Mar 2013 04:17:37 -0400
Received: by mail-lb0-f169.google.com with SMTP id m4so710263lbo.0
        for <linux-pm@vger.kernel.org>; Wed, 13 Mar 2013 01:17:36 -0700 (PDT)
In-Reply-To: <CAJLyvQxJ05HGtz79F-JKB0K9gdh5cwz3vjVbhn2vHnTWz54iMQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Hongbo Zhang <hongbo.zhang@linaro.org>
Cc: Zhang Rui <rui.zhang@intel.com>, Hongbo Zhang <hongbo.zhang@stericsson.com>, Viresh Kumar <viresh.kumar@linaro.org>, Francesco Lavra <francescolavra.fl@gmail.com>, linux-pm@vger.kernel.org

2013/3/13 Hongbo Zhang <hongbo.zhang@linaro.org>:
> On 12 March 2013 23:43, Axel Lin <axel.lin@ingics.com> wrote:
>
> It is better to say some commit message here I think.

In this case, the subject line is *very clear* about the change.
I think it is ok to avoid duplicate the same commit message.

Regards,
Axel
