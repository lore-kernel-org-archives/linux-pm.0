From: Axel Haslam <ahaslam@baylibre.com>
Subject: Re: [RFC v4 1/8] PM / Domains: structure changes for multiple states
Date: Wed, 22 Apr 2015 16:50:35 +0200
Message-ID: <5537B53B.4070808@baylibre.com>
References: <1429695935-15815-1-git-send-email-ahaslam@baylibre.com>	<1429695935-15815-2-git-send-email-ahaslam@baylibre.com> <CAMuHMdXs_Wytg7xwyQP=+L8enzoT2JBg78YTFe59Zp5K8vbq_A@mail.gmail.com> <5537A0B5.5000507@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:35835 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932874AbbDVOuj (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 22 Apr 2015 10:50:39 -0400
Received: by widdi4 with SMTP id di4so180979647wid.0
        for <linux-pm@vger.kernel.org>; Wed, 22 Apr 2015 07:50:38 -0700 (PDT)
In-Reply-To: <5537A0B5.5000507@baylibre.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@linaro.org>, =?UTF-8?B?S3J6eXN6dG9mIEtvesWCb3dza2k=?= <k.kozlowski.k@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Benoit Cousson <bcousson@baylibre.com>, Linux PM list <linux-pm@vger.kernel.org>

Hi Geert,

>>
>> While your series now looks compilable for all patch steps, it's not
>> bisectable: the right hook won't be called until the platform is
>> converted to support multiple states.
>>
>> I think you can fix this by e.g. using -1 for the target_state on
>> non-converted
>> platforms, and doing:
>>
>>          if (target_state < 0) {
>>                  if (!genpd->power_on)
>>                          return 0;
>>          } else {
>>                  if (!genpd->states[target_state].power_on)
>>                          return 0;
>>          }
>>
>> and
>>
>>          ret = target_state < 0 ? genpd->power_on(genpd)
>>                                 :
>> genpd->states[target_state].power_on(genpd);
>>
>> The checks for a negative target_state can be removed only after
>> all platforms have been converted.
>>

instead of adding checks for negative target state,
i think we can use a single state as a placeholder for the
old callbacks.

would this be an acceptable solution?

on init i can add something like:

+       if (genpd->power_off || genpd->power_on) {
+               pr_warn("Using old genpd callbacks\n");
+               genpd->state_count = 1;
+               genpd->states[0].name = "OFF";
+               genpd->states[0].power_off = genpd->power_off;
+               genpd->states[0].power_off_latency_ns =
+                       genpd->power_off_latency_ns;
+               genpd->states[0].power_on = genpd->power_on;
+               genpd->states[0].power_on_latency_ns =
+                               genpd->power_on_latency_ns;
+       }
+

this way, old callbacks are called in case the platform
has not been converted yet.

Regards
Axel
