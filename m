From: Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH] PM / QOS: Remove the global notifiers
Date: Mon, 13 Mar 2017 14:32:20 -0700
Message-ID: <m2efy0c17f.fsf@baylibre.com>
References: <8361bf69d667d7092c2b3b0ecabf147c7324ec33.1487752071.git.viresh.kumar@linaro.org>
        <CAPDyKFpdTFkrTp5T_YfeuiciR-UUWk4GP6Pmjcg56fVc+6T6mQ@mail.gmail.com>
        <CAPDyKFph6YKDJ5Vce_Zfw=LW4dXptkN=Yj=3FRcC3ht98JCv4w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f48.google.com ([74.125.83.48]:35404 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753321AbdCMVcX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Mar 2017 17:32:23 -0400
Received: by mail-pg0-f48.google.com with SMTP id b129so70589803pgc.2
        for <linux-pm@vger.kernel.org>; Mon, 13 Mar 2017 14:32:22 -0700 (PDT)
In-Reply-To: <CAPDyKFph6YKDJ5Vce_Zfw=LW4dXptkN=Yj=3FRcC3ht98JCv4w@mail.gmail.com>
        (Ulf Hansson's message of "Mon, 13 Mar 2017 17:04:00 +0100")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Rafael Wysocki <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>

Ulf Hansson <ulf.hansson@linaro.org> writes:

> On 13 March 2017 at 17:01, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>> On 22 February 2017 at 09:28, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>>> They were never used in the kernel, not sure why they got merged into
>>> the kernel though. Get rid of them.
>>
>> commit b66213cdb002b08b29603d488c451dfe25e2ca20
>> Author: Jean Pihet <j-pihet@ti.com>
>> Date:   Thu Aug 25 15:35:47 2011 +0200
>>
>>     PM QoS: Add global notification mechanism for device constraints
>>
>>     Add a global notification chain that gets called upon changes to the
>>     aggregated constraint value for any device.
>>     The notification callbacks are passing the full constraint request data
>>     in order for the callees to have access to it. The current use is for the
>>     platform low-level code to access the target device of the constraint.
>>
>>     Signed-off-by: Jean Pihet <j-pihet@ti.com>
>>     Reviewed-by: Kevin Hilman <khilman@ti.com>
>>     Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
>>
>> It was a while ago since they were added, but it seems like
>
> Slipped on the keyboard, sorry for the noise.
>
> I was about to say, that it was a while ago these were added, but
> still not being used. Thus let's remove them.
>
> Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

Agreed.  If we still have no users, let's remove them.

Acked-by: Kevin Hilman <khilman@baylibre.com>

Kevin
