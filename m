From: Alex Shi <alex.shi@linaro.org>
Subject: Re: [PATCH] PM / QoS: Fix device resume latency PM QoS
Date: Mon, 23 Oct 2017 13:12:43 +0800
Message-ID: <733a08d7-0dd6-36d6-fd3c-383bcfcbfd06@linaro.org>
References: <2245486.jYtPfSLF5g@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:52704 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750745AbdJWFMs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 23 Oct 2017 01:12:48 -0400
Received: by mail-pg0-f65.google.com with SMTP id a192so10862681pge.9
        for <linux-pm@vger.kernel.org>; Sun, 22 Oct 2017 22:12:47 -0700 (PDT)
In-Reply-To: <2245486.jYtPfSLF5g@aspire.rjw.lan>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Reinette Chatre <reinette.chatre@intel.com>, Ramesh Thomas <ramesh.thomas@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>



On 10/20/2017 07:27 PM, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The special value of 0 for device resume latency PM QoS means
> "no restriction", but there are two problems with that.
> 
> First, device resume latency PM QoS requests with 0 as the
> value are always put in front of requests with positive
> values in the priority lists used internally by the PM QoS
> framework, causing 0 to be chosen as an effective constraint
> value.  However, that 0 is then interpreted as "no restriction"
> effectively overriding the other requests with specific
> restrictions which is incorrect.
> 
> Second, the users of device resume latency PM QoS have no
> way to specify that *any* resume latency at all should be
> avoided, which is an artificial limitation in general.
> 
> To address these issues, modify device resume latency PM QoS to
> use S32_MAX as the "no constraint" value and 0 as the "no
> latency at all" one and rework its users (the cpuidle menu
> governor, the genpd QoS governor and the runtime PM framework)
> to follow these changes.
> 
> Also add a special "n/a" value to the corresponding user space I/F
> to allow user space to indicate that it cannot accept any resume
> latencies at all for the given device.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=197323
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Reported-by: Reinette Chatre <reinette.chatre@intel.com>


Acked-by: Alex Shi <alex.shi@linaro.org>
