From: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH v2] arm: vexpress: tc2: fix hotplug/idle/kexec race on
 cluster power down
Date: Mon, 30 Sep 2013 09:29:04 -0700
Message-ID: <20130930162904.GA5164@quad.lixom.net>
References: <1380297282-13021-1-git-send-email-lorenzo.pieralisi@arm.com>
 <alpine.LFD.2.03.1309271209450.312@syhkavp.arg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pb0-f42.google.com ([209.85.160.42]:42253 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754561Ab3I3Q3e (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 30 Sep 2013 12:29:34 -0400
Received: by mail-pb0-f42.google.com with SMTP id un15so5816819pbc.15
        for <linux-pm@vger.kernel.org>; Mon, 30 Sep 2013 09:29:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.03.1309271209450.312@syhkavp.arg>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>, Kevin Hilman <khilman@linaro.org>, Dave Martin <dave.martin@arm.com>

On Fri, Sep 27, 2013 at 12:12:25PM -0400, Nicolas Pitre wrote:
> Acked-by: Nicolas Pitre <nico@linaro.org>
> 
> ARM-SOC dudes: would you please pick this up?

I can't tell if this is actually needed for 3.12, since kexec isn't supported
without the set of patches that Dave Martin just posted.

Anyway, the fix is tiny so I applied it to the for-3.12 fixes branch anyway.


-Olof
