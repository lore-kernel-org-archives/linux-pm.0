From: Ran Shalit <ranshalit@gmail.com>
Subject: Q: cpuidle results in degredation in ethernet performance ?
Date: Sat, 1 Aug 2015 22:34:50 +0300
Message-ID: <CAJ2oMhKw0gpFMKOd-iYe_hYh56Q62XgpW+MJmyiGhdkGn1RTMg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-io0-f170.google.com ([209.85.223.170]:36177 "EHLO
	mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751373AbbHATev (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 1 Aug 2015 15:34:51 -0400
Received: by ioeg141 with SMTP id g141so114049176ioe.3
        for <linux-pm@vger.kernel.org>; Sat, 01 Aug 2015 12:34:50 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

Hello,

Maybe if someone here understands cpuidel he can help me...

I am using omap, with cpuidel and I have some strange behaviour only
when cpuidle is used:
1.  I test ethernet bandwidth with iperf
2. With large packet test (16k), I get same bandwidth in version with
cpuidle support as in version without cpuidel supported.
3. With small packet test (<2000 bytes), I get high degredation in
performance in version with cpuidle. On viewing statistics I see that
the cpu gets into cpu inactive state (C3 state -  not retention yet,
only cpu not active). I guess this is the cuase of the degredation.
With large packets I get no increment in C3 state usage.
4. I think that menu governer behaviour might explain this, but I
don't understand it deeply enough.

Can anyone shed a light on this ? Is there anything I can do to overcome this ?

Thank you!
Ran
