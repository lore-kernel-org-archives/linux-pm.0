From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 2/4][V2] time : set broadcast irq affinity
Date: Mon, 11 Mar 2013 21:00:43 +0000
Message-ID: <201303112100.43543.arnd@arndb.de>
References: <1362219013-18173-1-git-send-email-daniel.lezcano@linaro.org> <51396B39.3090504@linaro.org> <alpine.LFD.2.02.1303080817230.22263@ionos>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:62648 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753588Ab3CKVAz (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 11 Mar 2013 17:00:55 -0400
In-Reply-To: <alpine.LFD.2.02.1303080817230.22263@ionos>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, john.stultz@linaro.org, viresh.kumar@linaro.org, jacob.jun.pan@linux.intel.com, LAK <linux-arm-kernel@lists.infradead.org>, santosh.shilimkar@ti.com, linux-pm@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, linaro-kernel@lists.linaro.org, patches@linaro.org, rickard.andersson@stericsson.com, vincent.guittot@linaro.org, linus.walleij@stericsson.com

On Friday 08 March 2013, Thomas Gleixner wrote:
> On Fri, 8 Mar 2013, Daniel Lezcano wrote:
> > On 03/06/2013 10:48 AM, Thomas Gleixner wrote:
> > I was wondering if it would be possible to take the 3/4 and 4/4
> > otherwise the flag dependency will prevent to send those to the
> > maintainer's tree until they gain visibility on it.
> 
> I can take them with the ack of arm soc folks.

Sounds good,

Acked-by: Arnd Bergmann <arnd@arndb.de>
