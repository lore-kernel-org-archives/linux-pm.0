From: Florian Fainelli <f.fainelli@gmail.com>
Subject: cpuidle and cpufreq coupling?
Date: Wed, 19 Jul 2017 15:54:29 -0700
Message-ID: <d56144f8-cb62-a458-d69d-8e2a65cbe434@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qk0-f170.google.com ([209.85.220.170]:34969 "EHLO
        mail-qk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753601AbdGSWyd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 19 Jul 2017 18:54:33 -0400
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, viresh.kumar@linaro.org, rjw@rjwysocki.net, code@mmayer.net, daniel.lezcano@linaro.org

Hi,

We have a particular ARM CPU design that is drawing quite a lot of
current upon exit from WFI, and it does so in a way even before the
first instruction out of WFI is executed. That means we cannot influence
directly the exit from WFI other than by changing the state in which it
would be previously entered because of this "dead" time during which the
internal logic needs to ramp up back where it left.

A naive approach to solving this problem because we have CPU frequency
scaling available would be to do the following:

- just before entering WFI, switch to a low frequency OPP
- enter WFI
- upon exit from WFI, ramp up the frequency back to e.g: highest OPP

Some of the parts that I am not exactly clear on would be:

- would that qualify as a cpuidle governor of some kind that ties in
which cpufreq?
- would using cpufreq_driver_fast_switch() be an appropriate API to use
from outside

Thanks!
-- 
Florian
