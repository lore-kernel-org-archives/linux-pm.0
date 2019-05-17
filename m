From: Dennis Wassenberg <dennis.wassenberg@secunet.com>
Subject: Question regarding intel_pstate in case of disabled smt
Date: Fri, 17 May 2019 12:24:11 +0200
Message-ID: <8d859cb0-0646-4f52-b060-3816d689aade@secunet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Kernel development list <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi all,

I would like to ask a question regarding cpu frequency scaling / cpu performance using intel_pstate with activated HWP.
I think the special CPU doesn't matter. I checked it with i7-8550U and i7-8565U. Currently I am not sure if this is a
bug. Thats why I am asking...

Using intel_pstate default settings (min_perf_pct=10, max_perf_pct=100, no_turbo=0) everything behaves as expected. If I
change max_perf_pct and/or no_turbo i can observe that the cpu frequency doesn't increase that much compared to the
default settings under load.

But if I disable smt, the settings of the pstate driver does not seem to change anything. If I set no_turbo and/or
max_perf_pct to a lower value than 100 I can not notice that there is a change at the cpu frequency scaling. For
example: If I set min_perf_pct=max_perf_pct=5 the cpu frequency of the 4 online cpus will be above 4 GHz in case of smt
is disabled. If smt is enabled the cpu frequency of the 8 cpus is 400 MHz. The same occurred if I disable turbo by
setting no_turbo to 1. If smt is disbaled the frequency will be above 4 GHz in load situations. If smt is enabled the
cpu frequency is 1,80 GHz.

If I use intel_pstate with disabled HWP it behaves the same if smt is enabled or disabled. So, it makes no difference if
smt is enabled or disabled . The cpu frequency will adapt exactly to the configured settings.

So, is this intended that HWP does not consider the pstate settings if smt is disabled?

Thank you & best regards,

Dennis
