From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/1] thermal: cpu_cooling: check for the readiness of
 cpufreq layer
Date: Fri, 28 Nov 2014 07:58:52 +0530
Message-ID: <CAKohpok90KG7ZcY8qq7g-VmhPSCsn83Ut_K_QJqC2b+efWiXkg@mail.gmail.com>
References: <1417024212-1775-1-git-send-email-edubezval@gmail.com>
	<CAKohponxUWVT1mjRfJarNtj-+=rXNOa_ONHUjmdu_+6N+=ZjPQ@mail.gmail.com>
	<20141127140803.GA3342@developer>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f43.google.com ([209.85.218.43]:42921 "EHLO
	mail-oi0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750866AbaK1C2x (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 27 Nov 2014 21:28:53 -0500
Received: by mail-oi0-f43.google.com with SMTP id a3so4146223oib.30
        for <linux-pm@vger.kernel.org>; Thu, 27 Nov 2014 18:28:52 -0800 (PST)
In-Reply-To: <20141127140803.GA3342@developer>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, Lukasz Majewski <l.majewski@samsung.com>, LKML <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Grant Likely <grant.likely@linaro.org>, Kukjin Kim <kgene.kim@samsung.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, Naveen Krishna Chatradhi <ch.naveen@samsung.com>, Rob Herring <robh+dt@kernel.org>, Zhang Rui <rui.zhang@intel.com>

On 27 November 2014 at 19:38, Eduardo Valentin <edubezval@gmail.com> wrote:
>> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
>
> Ok.
>
> though.. "normal practice" says  ack's are oftern used by the maintainer
> of the affected code (quoting Documentation/SubmittingPatches) :-)

Hehe :)

Another paragraph from the same file:

Acked-by: does not necessarily indicate acknowledgement of the entire patch.
For example, if a patch affects multiple subsystems and has an Acked-by: from
one subsystem maintainer then this usually indicates acknowledgement of just
the part which affects that maintainer's code.  Judgement should be used here.
When in doubt people should refer to the original discussion in the mailing
list archives.

So my Acked-by was as cpufreq subsystem Maintainer :)
