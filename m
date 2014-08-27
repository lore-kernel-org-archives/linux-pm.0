From: Lina Iyer <lina.iyer@linaro.org>
Subject: Re: [PATCH v2 2/4] QoS: Enhance framework to support per-cpu PM QoS
 request
Date: Wed, 27 Aug 2014 14:13:00 -0600
Message-ID: <20140827201300.GA79706@ilina-mac.domain>
References: <1407945689-18494-1-git-send-email-lina.iyer@linaro.org>
 <1407945689-18494-3-git-send-email-lina.iyer@linaro.org>
 <7hd2blerqz.fsf@paris.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:43581 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964818AbaH0UNQ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 27 Aug 2014 16:13:16 -0400
Received: by mail-pa0-f50.google.com with SMTP id et14so1152543pad.23
        for <linux-pm@vger.kernel.org>; Wed, 27 Aug 2014 13:13:12 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7hd2blerqz.fsf@paris.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kevin Hilman <khilman@linaro.org>
Cc: daniel.lezcano@linaro.org, ulf.hansson@linaro.org, linux-pm@vger.kernel.org, tglx@linutronix.de, rjw@rjwysocki.net, Praveen Chidambaram <pchidamb@codeaurora.org>

On Wed, Aug 27, 2014 at 11:01:40AM -0700, Kevin Hilman wrote:
>Lina Iyer <lina.iyer@linaro.org> writes:
>
>> QoS request can be better optimized if the request can be set only for
>> the required cpus and not all cpus. This helps save power on other
>> cores, while still gauranteeing the quality of service on the desired
>> cores.
>>
>> Add a new enumeration to specify the PM QoS request type. The enums help
>> specify what is the intended target cpu of the request.
>>
>> Enhance the QoS constraints data structures to support target value for
>> each core. Requests specify if the QoS is applicable to all cores
>> (default) or to a selective subset of the cores or to a core(s).
>>
>> Idle and interested drivers can request a PM QoS value for a constraint
>> across all cpus, or a specific cpu or a set of cpus. Separate APIs have
>> been added to request for individual cpu or a cpumask.  The default
>> behaviour of PM QoS is maintained i.e, requests that do not specify a
>> type of the request will continue to be effected on all cores.
>>
>> The userspace sysfs interface does not support setting cpumask of a PM
>> QoS request.
>>
>> Signed-off-by: Praveen Chidambaram <pchidamb@codeaurora.org>
>> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
>
>I'm curious if you looked at using the per-device QoS API for this
>instead of expending the system-wide API.  IOW, from a per-device QoS
>POV, a CPU is no different than any other device, and since we already
>have the per-device QoS API, I wondered if that might be a better choice
>to implment this per-CPU feature.
>
If you mean dev-pm-qos, then yes. I explored using that. The dev-pm-qos
is an user of the qos framework and holds an pm-qos object, but not in
any other way influences the final value of the QoS constraint other
than specify a request on behalf of the device.  IMHO, What we want is
complementary. When a device specifies a request, we want the request to
be directed at a set of cpus and that is a function of the QoS
framework, hence addressed by these patches to the QoS framework.

>Kevin
>--
>To unsubscribe from this list: send the line "unsubscribe linux-pm" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
