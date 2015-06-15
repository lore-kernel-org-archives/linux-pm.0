From: Lina Iyer <lina.iyer@linaro.org>
Subject: Re: [PATCH RFC 3/3] PM / Domains: Introduce generic PM domain for
 cpu domain
Date: Mon, 15 Jun 2015 13:14:34 -0600
Message-ID: <20150615191434.GA14311@linaro.org>
References: <1433456946-53296-1-git-send-email-lina.iyer@linaro.org>
 <1433456946-53296-4-git-send-email-lina.iyer@linaro.org>
 <7hmw07meh6.fsf@deeprootsystems.com>
 <20150611145649.GC1103@linaro.org>
 <7hioao6cd2.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:35653 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752742AbbFOTOc (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 15 Jun 2015 15:14:32 -0400
Received: by pacyx8 with SMTP id yx8so71202223pac.2
        for <linux-pm@vger.kernel.org>; Mon, 15 Jun 2015 12:14:31 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7hioao6cd2.fsf@deeprootsystems.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kevin Hilman <khilman@kernel.org>
Cc: rjw@rjwysocki.net, ulf.hansson@linaro.org, mathieu.poirier@linaro.org, galak@codeaurora.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, msivasub@codeaurora.org, agross@codeaurora.org

On Mon, Jun 15 2015 at 12:43 -0600, Kevin Hilman wrote:
>Lina Iyer <lina.iyer@linaro.org> writes:
>
>> On Wed, Jun 10 2015 at 15:38 -0600, Kevin Hilman wrote:
>>>Lina Iyer <lina.iyer@linaro.org> writes:


>I'm pretty sure the generic code will already add devices to genpds if
>the genpd is using the of_genpd_* stuff.  That is why I'm wondering why
>the extra stuff for CPUs is needed.
>
I dont see that automatically happening. When I attach a device, it
finds the corresponding genpd provider and attaches the device.  But I
dont see in any code that creates genpd and find the related device
nodes and adds them to the genpd.

May be I am missing something.

-- Lina
