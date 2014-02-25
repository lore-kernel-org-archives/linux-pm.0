From: Sebastian Capella <sebastian.capella@linaro.org>
Subject: Re: [PATCH RFC v1 1/3] ARM: Add irq disabled version of soft_restart.
Date: Tue, 25 Feb 2014 15:24:09 -0800
Message-ID: <20140225232409.18229.4284@capellas-linux>
References: <1392774729-3235-1-git-send-email-sebastian.capella@linaro.org>
 <1392774729-3235-2-git-send-email-sebastian.capella@linaro.org>
 <20140222102616.GG21483@n2100.arm.linux.org.uk>
 <20140224231345.10580.62916@capellas-linux> <530C4CAE.5000202@ti.com>
 <alpine.DEB.2.02.1402251125500.21251@ionos.tec.linutronix.de>
 <530CCFB5.5030205@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:51624 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752142AbaBYXYN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 25 Feb 2014 18:24:13 -0500
Received: by mail-pa0-f52.google.com with SMTP id fb1so111311pad.39
        for <linux-pm@vger.kernel.org>; Tue, 25 Feb 2014 15:24:13 -0800 (PST)
In-Reply-To: <530CCFB5.5030205@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Russ Dill <Russ.Dill@ti.com>, Thomas Gleixner <tglx@linutronix.de>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linaro-kernel@lists.linaro.org, linux-arm-kernel@lists.infradead.org, Andrew Morton <akpm@linux-foundation.org>, Will Deacon <will.deacon@arm.com>, Robin Holt <holt@sgi.com>

Quoting Russ Dill (2014-02-25 09:15:33)
> On 02/25/2014 02:27 AM, Thomas Gleixner wrote:
> > If you want escape the tracer and in that case you really want it 
> > being on a different stack, use raw_local_irq_* which are not
> > traced.
> 
> So it might make sense to change soft_restart to use the
> raw_local_irq_* calls.

I've added this change.  So far it's working well.

Thanks!

Sebastian
