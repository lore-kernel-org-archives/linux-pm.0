From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: cpufrequency ondemand governor question
Date: Thu, 9 Jan 2014 10:23:26 +0530
Message-ID: <CAKohpokkWyHLfcK-6DWQd3MwDybaf6bKE1XRnp7Wg1=QOwLT2g@mail.gmail.com>
References: <CAH9_wRPXO4gJJ1hvcmxu3c+Ja9VG5SBJMtnVHFwv_uHWudhA7A@mail.gmail.com>
	<CANLsYkwCNrd-Js3tjeHRt=Zu3A-qwsAp9RwKhUSh4eeyd4QJiA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f170.google.com ([209.85.214.170]:60674 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750986AbaAIEx0 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 8 Jan 2014 23:53:26 -0500
Received: by mail-ob0-f170.google.com with SMTP id uy5so788923obc.29
        for <linux-pm@vger.kernel.org>; Wed, 08 Jan 2014 20:53:26 -0800 (PST)
In-Reply-To: <CANLsYkwCNrd-Js3tjeHRt=Zu3A-qwsAp9RwKhUSh4eeyd4QJiA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Sriram V <vshrirama@gmail.com>, Lists linaro-dev <linaro-dev@lists.linaro.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On 9 January 2014 02:30, Mathieu Poirier <mathieu.poirier@linaro.org> wrote:
> On 8 January 2014 13:35, Sriram V <vshrirama@gmail.com> wrote:
>> I am seeing a behaviour where the load variations are very frequency
>> between 1ghz and 300mhz in a very short interval of time giving the
>> ping-pong effect. \
>> Is there a way of avoiding this Also, is it possible to find out which
>> task is causing this behaviour.
>>
>> All this happens in a couple of sampling periods of ondemand.

> I am not specifically familiar with the ondemand governor but have
> amply dealt with governor matters.  On way to deal with the ping pong
> effect is to increase the amount of time the frequency needs to stay
> at a certain level before going back down.

These are the tunables present with ondemand governor:

struct od_dbs_tuners {
unsigned int ignore_nice_load;
unsigned int sampling_rate;
unsigned int sampling_down_factor;
unsigned int up_threshold;
unsigned int powersave_bias;
unsigned int io_is_busy;
};

And none of them tracks the time for which you should stay at a particular
freq :)

Though you can play with sampling_down_factor and up_threshold to
achieve what you want. For their details, please refer:
Documentation/cpu-freq/governors.txt

Please give us values of these tunables from sysfs for your case, if you
aren't able to make your system better by playing with above tunables.
