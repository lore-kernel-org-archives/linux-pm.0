From: Michele DiGiorgio <michele.digiorgio@arm.com>
Subject: Re: [PATCH] thermal: trace: migrating thermal traces to use
 TRACE_DEFINE_ENUM() macros
Date: Thu, 3 Mar 2016 17:10:46 +0000
Message-ID: <56D87016.5030903@arm.com>
References: <1456853934-24715-1-git-send-email-michele.digiorgio@arm.com>
 <20160301132006.1cda539c@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from eu-smtp-delivery-143.mimecast.com ([207.82.80.143]:60804 "EHLO
	eu-smtp-delivery-143.mimecast.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754148AbcCCRK7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 3 Mar 2016 12:10:59 -0500
In-Reply-To: <20160301132006.1cda539c@gandalf.local.home>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Javi Merino <javi.merino@arm.com>, linux-kernel@vger.kernel.org, Punit Agrawal <punit.agrawal@arm.com>, Eduardo Valentin <edubezval@gmail.com>

Hello Steven,

Thanks for acknowledging the patch.

Will you be merging it or should I refer to somebody else?

Kind regards,
Michele

On 01/03/16 18:20, Steven Rostedt wrote:
> On Tue,  1 Mar 2016 17:38:54 +0000
> Michele Di Giorgio <michele.digiorgio@arm.com> wrote:
>
> > Userspace tools are not aware of how to convert the enums provided by
> > the tracepoints to their corresponding strings.
> >
> > Adding TRACE_DEFINE_ENUM() macros allows to make the enums available
> > to userspace to let the tools know what those enum values represent.
> >
> > In particular, for thermal zone trip types what we obtained before was
> > something like:
> >
> > kworker/1:1-460   [001]   320.372732: thermal_zone_trip:    thermal_zone=soc
> >                 id=0 trip=1 trip_type=1
> >
> > Unfortunately, userspace tools do not know how to convert enum values to
> > strings and as a consequence they can only forward the enum value to the
> > output. By using TRACE_DEFINE_ENUM() macros for thermal traces we get the
> > following trace line:
> >
> > kworker/1:1-460   [001]   320.372732: thermal_zone_trip:    thermal_zone=soc
> >                 id=0 trip=1 trip_type=PASSIVE
> >
> > Userspace tools are now able to better understand the meaning of the trip_type
> > and provide the user with more readable information.
> >
>
> Acked-by: Steven Rostedt <rostedt@goodmis.org>
>
> -- Steve
>

IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium. Thank you.

