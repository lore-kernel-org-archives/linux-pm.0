From: Dave Martin <Dave.Martin@arm.com>
Subject: Re: [PATCH v2] arm: vexpress: tc2: fix hotplug/idle/kexec race on
 cluster power down
Date: Mon, 30 Sep 2013 17:33:06 +0100
Message-ID: <20130930163305.GB3209@localhost.localdomain>
References: <1380297282-13021-1-git-send-email-lorenzo.pieralisi@arm.com>
 <alpine.LFD.2.03.1309271209450.312@syhkavp.arg>
 <20130930162904.GA5164@quad.lixom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from fw-tnat.cambridge.arm.com ([217.140.96.21]:50352 "EHLO
	cam-smtp0.cambridge.arm.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755224Ab3I3Qdg (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 30 Sep 2013 12:33:36 -0400
Content-Disposition: inline
In-Reply-To: <20130930162904.GA5164@quad.lixom.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>, Kevin Hilman <khilman@linaro.org>, linux-pm@vger.kernel.org, Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, linux-arm-kernel@lists.infradead.org

On Mon, Sep 30, 2013 at 09:29:04AM -0700, Olof Johansson wrote:
> On Fri, Sep 27, 2013 at 12:12:25PM -0400, Nicolas Pitre wrote:
> > Acked-by: Nicolas Pitre <nico@linaro.org>
> > 
> > ARM-SOC dudes: would you please pick this up?
> 
> I can't tell if this is actually needed for 3.12, since kexec isn't supported
> without the set of patches that Dave Martin just posted.

I believe some problems have been seen when mixing hotplug with idle,
even if kexec is out of the picture.  This was a known issue before I
started playing with kexec.

This should be considered a separate patch.

Cheers
---Dave

> 
> Anyway, the fix is tiny so I applied it to the for-3.12 fixes branch anyway.
> 
> 
> -Olof
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
