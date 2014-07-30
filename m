From: Punit Agrawal <punit.agrawal@arm.com>
Subject: Re: [PATCH 0/3] Add trace to thermal framework
Date: Wed, 30 Jul 2014 12:40:04 +0100
Message-ID: <9hhy4vb5b3f.fsf@arm.com>
References: <1402486305-4017-1-git-send-email-punit.agrawal@arm.com>
	<1406631050-14975-1-git-send-email-punit.agrawal@arm.com>
	<20140729133327.GA3336@developer>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from fw-tnat.cambridge.arm.com ([217.140.96.21]:52964 "EHLO
	cam-smtp0.cambridge.arm.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752307AbaG3LkR (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 30 Jul 2014 07:40:17 -0400
In-Reply-To: <20140729133327.GA3336@developer> (Eduardo Valentin's message of
	"Tue, 29 Jul 2014 09:33:27 -0400")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, javi.merino@arm.com, rui.zhang@intel.com, rostedt@goodmis.org

Eduardo Valentin <edubezval@gmail.com> writes:

> On Tue, Jul 29, 2014 at 11:50:47AM +0100, Punit Agrawal wrote:
>> Hi linux-pm,
>> 
>> This is the second posting of the patches to add trace to the thermal
>> framework.
>> 
>> The linux thermal framework doesn't have any support for tracing. This
>> makes it hard to run workloads and observe the thermal behaviour of
>> the system without actively polling files in sysfs or enabling debug
>> builds.
>> 
>> This patch set introduces trace events in the framework to allow
>> observing the behaviour of the different components in the
>> framework. The events added trace temperature changes, trip points and
>> cooling device state changes.
>> 
>> changes since rfc:
>> * Fixed an issue where incorrect trip point was traced when using fair
>> share
>> * Trace the numeric value of trip_type instead of using __print_symbolic
>
> Pulled the series.

Thanks Eduardo.

>
> Thanks.
>
>> 
>> Punit Agrawal (3):
>>   thermal: trace: Trace temperature changes
>>   thermal: trace: Trace when a cooling device's state is updated
>>   thermal: trace: Trace when temperature is above a trip point
>> 
>>  drivers/thermal/fair_share.c   |   12 ++++++
>>  drivers/thermal/step_wise.c    |    5 ++-
>>  drivers/thermal/thermal_core.c |    7 ++++
>>  include/trace/events/thermal.h |   87 ++++++++++++++++++++++++++++++++++++++++
>>  4 files changed, 110 insertions(+), 1 deletion(-)
>>  create mode 100644 include/trace/events/thermal.h
>> 
>> -- 
>> 1.7.10.4
>> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
