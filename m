From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH V2 5/5] cpuidle: menu: Move the update function before its declaration
Date: Mon, 27 Oct 2014 22:53:40 -0400
Message-ID: <CAJvTdKnR1jmD2r0w0A1M=xfWov4uPOxuX+QMGG4oTU8GaG15-A@mail.gmail.com>
References: <1414054881-17713-1-git-send-email-daniel.lezcano@linaro.org>
	<1414054881-17713-5-git-send-email-daniel.lezcano@linaro.org>
	<alpine.LFD.2.11.1410231246500.6969@knanqh.ubzr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yk0-f173.google.com ([209.85.160.173]:43391 "EHLO
	mail-yk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752585AbaJ1Cxl (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 27 Oct 2014 22:53:41 -0400
In-Reply-To: <alpine.LFD.2.11.1410231246500.6969@knanqh.ubzr>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, linaro-kernel@lists.linaro.org, Patch Tracking <patches@linaro.org>

>> This patch does not change the behavior of the governor, it is just code
>> reordering.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>


Acked-by: Len Brown <len.brown@intel.com>
