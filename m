From: Thara Gopinath <thara.gopinath@linaro.org>
Subject: Re: [PATCH 2/2] PM / Domains: Extend generic power domain debugfs.
Date: Mon, 12 Jun 2017 14:51:40 -0400
Message-ID: <593EE2BC.8080500@linaro.org>
References: <1495756293-29534-1-git-send-email-thara.gopinath@linaro.org>
 <1495756293-29534-3-git-send-email-thara.gopinath@linaro.org>
 <CAPDyKFpfXqPc2fjHkJVmUP8kmwE4Ec-bcs_Fk=t0F1sSnfWRVQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qt0-f174.google.com ([209.85.216.174]:35130 "EHLO
        mail-qt0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751444AbdFLSvm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Jun 2017 14:51:42 -0400
Received: by mail-qt0-f174.google.com with SMTP id w1so137604284qtg.2
        for <linux-pm@vger.kernel.org>; Mon, 12 Jun 2017 11:51:42 -0700 (PDT)
In-Reply-To: <CAPDyKFpfXqPc2fjHkJVmUP8kmwE4Ec-bcs_Fk=t0F1sSnfWRVQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Kevin Hilman <khilman@baylibre.com>

On 06/07/2017 09:51 AM, Ulf Hansson wrote:
> On 26 May 2017 at 01:51, Thara Gopinath <thara.gopinath@linaro.org> wrote:
>> This patch extends the existing generic power domain debugfs.
>> Changes involve the following
>> - Remove the current flat format of displaying generic power domain
>>   summary.
>> - Introduce a unique debugfs entry for each generic power domain with the
>>   following attributes
>>         - current_state - Displays current state of the domain.
>>         - devices - Displays the devices associated with this domain.
>>         - slaves - Displays the sub power domains.
> 
> Maybe "sub_domains" is a better name for the node then?
> 
>>         - on_time - Displays the time the domain was in on state in ms.
> 
> /s/on_time/active_time
> 
>>         - idle_time - Displays the time the domain was in any of the idle
>>                         states in ms.
> 
> /s/idle_time/total_idle_time
> 
>>         - idle_states - Displays the various idle states and the time
>>                         spent in each idle state in ms.
>>
>> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
> 
> Besides the nitpicks above, this looks okay to me, however please
> address Geerts comments as well.
Will fix all the above comments and re-send

> 
> [...]
> 
> Kind regards
> Uffe
> 


-- 
Regards
Thara
