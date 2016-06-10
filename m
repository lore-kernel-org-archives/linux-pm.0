From: Lina Iyer <lina.iyer@linaro.org>
Subject: Re: [PATCH 3/5] arm64: dts: msm8916: Add spc compat tag
Date: Fri, 10 Jun 2016 15:16:36 -0600
Message-ID: <20160610211636.GA38979@linaro.org>
References: <1463634020-17252-1-git-send-email-andy.gross@linaro.org>
 <1463634020-17252-4-git-send-email-andy.gross@linaro.org>
 <20160610154857.GA6430@leverpostej>
 <20160610161234.GO13357@hector.attlocal.net>
 <20160610162555.GB6430@leverpostej>
 <20160610164721.GP13357@hector.attlocal.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:35298 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750888AbcFJVQq (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 10 Jun 2016 17:16:46 -0400
Received: by mail-pa0-f48.google.com with SMTP id hl6so26977940pac.2
        for <linux-pm@vger.kernel.org>; Fri, 10 Jun 2016 14:16:46 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20160610164721.GP13357@hector.attlocal.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andy Gross <andy.gross@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, stanimir.varbanov@linaro.org, lorenzo.pieralisi@arm.com

On Fri, Jun 10 2016 at 10:47 -0600, Andy Gross wrote:
>On Fri, Jun 10, 2016 at 05:25:55PM +0100, Mark Rutland wrote:
>> On Fri, Jun 10, 2016 at 11:12:34AM -0500, Andy Gross wrote:
>> > On Fri, Jun 10, 2016 at 04:48:57PM +0100, Mark Rutland wrote:
>> > > [+ Lorenzo]
>> > >
>> > > On Thu, May 19, 2016 at 12:00:18AM -0500, Andy Gross wrote:
<...>
>>
>> > I chose to do this outside of the arm cpuidle driver because I didn't want to
>> > add any more DT information aside from the compatible, and I needed a separate
>> > place for the Qualcomm specific suspend code.
>>
>> Which suspend code is Qualcomm-specific? There shouldn't be anything on
>> the PSCI side, so I can only imagine that device management is left.
>> What am I missing?
>

>Qualcomm won't be supporting the psci suspend feature and will be doing their
>own thing.  As such, they need their own suspend ops.  In addition, we have
>platforms that don't use psci (32 bit).
>
Andy, which PSCI suspend feature are you referring to, here? On 8916, we
do support CPU_SUSPEND in PSCI.

You don't want to call SYSTEM_SUSPEND, as it requires the other CPUs to
be CPU_OFF (hotplugged off) before the last core calls this PSCI
function.

Lina
