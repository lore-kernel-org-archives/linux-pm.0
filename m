From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/2] dt-bindings: mediatek: Add MT8173 cpufreq driver
 binding
Date: Wed, 24 Jun 2015 14:30:34 +0530
Message-ID: <20150624090034.GG27188@linux>
References: <1433766561-1330-1-git-send-email-pi-cheng.chen@linaro.org>
 <1433766561-1330-2-git-send-email-pi-cheng.chen@linaro.org>
 <CALx668UShfd3HW1ptzHnMr9xAUVyLGt=q2CmYHn3vqASZug6kw@mail.gmail.com>
 <20150624010621.GB6424@linux>
 <CALx668XyOBydyYeBtnX0-pfHbdirkZXSUrk3vbLQ2fYWvSax3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f171.google.com ([209.85.192.171]:35971 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751762AbbFXJAi (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 24 Jun 2015 05:00:38 -0400
Received: by pdcu2 with SMTP id u2so26305284pdc.3
        for <linux-pm@vger.kernel.org>; Wed, 24 Jun 2015 02:00:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CALx668XyOBydyYeBtnX0-pfHbdirkZXSUrk3vbLQ2fYWvSax3w@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pi-Cheng Chen <pi-cheng.chen@linaro.org>
Cc: mturquette@baylibre.com, Mike Turquette <mturquette@linaro.org>, Matthias Brugger <matthias.bgg@gmail.com>, Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linaro Kernel Mailman List <linaro-kernel@lists.linaro.org>, linux-mediatek@lists.infradead.org

On 24-06-15, 16:57, Pi-Cheng Chen wrote:
> Yes. So should it be:
> - operating-points: Refer to
> Documentation/devicetree/bindings/power/opp.txt
>   for details

Right.

-- 
viresh
