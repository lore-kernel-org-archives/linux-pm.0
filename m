From: Kevin Hilman <khilman@kernel.org>
Subject: Re: [PATCH RFC 3/3] PM / Domains: Introduce generic PM domain for cpu domain
Date: Tue, 16 Jun 2015 08:50:19 -0700
Message-ID: <7h381rzm84.fsf@deeprootsystems.com>
References: <1433456946-53296-1-git-send-email-lina.iyer@linaro.org>
	<1433456946-53296-4-git-send-email-lina.iyer@linaro.org>
	<7hmw07meh6.fsf@deeprootsystems.com>
	<20150611145649.GC1103@linaro.org>
	<7hioao6cd2.fsf@deeprootsystems.com>
	<20150615191434.GA14311@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:34504 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751994AbbFPPuW (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 16 Jun 2015 11:50:22 -0400
Received: by pacgb13 with SMTP id gb13so15276040pac.1
        for <linux-pm@vger.kernel.org>; Tue, 16 Jun 2015 08:50:22 -0700 (PDT)
In-Reply-To: <20150615191434.GA14311@linaro.org> (Lina Iyer's message of "Mon,
	15 Jun 2015 13:14:34 -0600")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lina Iyer <lina.iyer@linaro.org>
Cc: rjw@rjwysocki.net, ulf.hansson@linaro.org, mathieu.poirier@linaro.org, galak@codeaurora.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, msivasub@codeaurora.org, agross@codeaurora.org

Lina Iyer <lina.iyer@linaro.org> writes:

> On Mon, Jun 15 2015 at 12:43 -0600, Kevin Hilman wrote:
>>Lina Iyer <lina.iyer@linaro.org> writes:
>>
>>> On Wed, Jun 10 2015 at 15:38 -0600, Kevin Hilman wrote:
>>>>Lina Iyer <lina.iyer@linaro.org> writes:
>
>
>>I'm pretty sure the generic code will already add devices to genpds if
>>the genpd is using the of_genpd_* stuff.  That is why I'm wondering why
>>the extra stuff for CPUs is needed.
>>
> I dont see that automatically happening. When I attach a device, it
> finds the corresponding genpd provider and attaches the device.  But I
> dont see in any code that creates genpd and find the related device
> nodes and adds them to the genpd.

[summary from our IRC discussion]

You still need to create the genpd, but it's dev_pm_domain_attach()
called by the platform device probe path that will automaticaly try to
attach a device with a power-domains property to the correct PM domain.

Note that this assumes that the genpds are created before the devices
are probed.

Kevin

