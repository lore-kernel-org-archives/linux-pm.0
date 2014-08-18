From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [PATCH v2 2/4] QoS: Enhance framework to support per-cpu PM QoS request
Date: Mon, 18 Aug 2014 16:55:41 -0700
Message-ID: <7h4mx9wdxe.fsf@paris.lan>
References: <1407945689-18494-1-git-send-email-lina.iyer@linaro.org>
	<1407945689-18494-3-git-send-email-lina.iyer@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f179.google.com ([209.85.192.179]:56935 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751245AbaHRXzo (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 18 Aug 2014 19:55:44 -0400
Received: by mail-pd0-f179.google.com with SMTP id v10so8405123pde.10
        for <linux-pm@vger.kernel.org>; Mon, 18 Aug 2014 16:55:43 -0700 (PDT)
In-Reply-To: <1407945689-18494-3-git-send-email-lina.iyer@linaro.org> (Lina
	Iyer's message of "Wed, 13 Aug 2014 10:01:27 -0600")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lina Iyer <lina.iyer@linaro.org>
Cc: daniel.lezcano@linaro.org, ulf.hansson@linaro.org, linux-pm@vger.kernel.org, tglx@linutronix.de, rjw@rjwysocki.net, Praveen Chidambaram <pchidamb@codeaurora.org>

Hi Lina,

Lina Iyer <lina.iyer@linaro.org> writes:

> QoS request can be better optimized if the request can be set only for
> the required cpus and not all cpus. This helps save power on other
> cores, while still gauranteeing the quality of service on the desired
> cores.
>
> Add a new enumeration to specify the PM QoS request type. The enums help
> specify what is the intended target cpu of the request.
>
> Enhance the QoS constraints data structures to support target value for
> each core. Requests specify if the QoS is applicable to all cores
> (default) or to a selective subset of the cores or to a core(s).
>
> Idle and interested drivers can request a PM QoS value for a constraint
> across all cpus, or a specific cpu or a set of cpus. Separate APIs have
> been added to request for individual cpu or a cpumask.  The default
> behaviour of PM QoS is maintained i.e, requests that do not specify a
> type of the request will continue to be effected on all cores.
>
> The userspace sysfs interface does not support setting cpumask of a PM
> QoS request.
>
> Signed-off-by: Praveen Chidambaram <pchidamb@codeaurora.org>
> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>

I agree this is a needed feature.  I didn't study it in detail yet, but
after a quick glance, it looks like a good approach.  

However, I did start to wonder how this will behave in the context of
the hotplug.  For example, what if a constraint is setup with a cpumask,
then one of those CPUs is hotplugged away.  

Kevin
