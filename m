From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] power: supply: sbs-battery: simplify DT parsing
Date: Wed, 07 Sep 2016 09:58:10 +0200
Message-ID: <4977026.Nm6AJ7K8UK@wuerfel>
References: <20160906131643.1930011-1-arnd@arndb.de> <20160906235523.ff4opq56gg4ln6xv@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:60496 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751174AbcIGH55 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 7 Sep 2016 03:57:57 -0400
In-Reply-To: <20160906235523.ff4opq56gg4ln6xv@earth>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Phil Reid <preid@electromag.com.au>, YH Huang <yh.huang@mediatek.com>, Joshua Clayton <stillcompiling@gmail.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On Wednesday, September 7, 2016 1:55:23 AM CEST Sebastian Reichel wrote:
> 
> Patch looks fine to me. Actually I already asked Phil to
> implement your change [0]. I just queued it to power-supply's
> for-next branch.
> 
> [0] https://marc.info/?l=linux-pm&m=147273382018953&w=2

Glad to see we had the same thought. ;-)

I see that we went for different defaults for chip->poll_retry_count:
I concluded that '0' would be the correct default, while you suggested '1'
in your reply.

Can you double-check the code and see which one is right?

	Arnd
