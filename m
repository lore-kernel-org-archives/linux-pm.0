From: Javi Merino <javi.merino@arm.com>
Subject: Re: [PATCH] thermal: trace: migrating thermal traces to use
 TRACE_DEFINE_ENUM() macros
Date: Tue, 8 Mar 2016 09:58:52 +0000
Message-ID: <20160308095851.GA3037@e104805>
References: <1456853934-24715-1-git-send-email-michele.digiorgio@arm.com>
 <20160301132006.1cda539c@gandalf.local.home>
 <56D87016.5030903@arm.com>
 <744357E9AAD1214791ACBA4B0B9092633A972721@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:60682 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932107AbcCHJ64 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 8 Mar 2016 04:58:56 -0500
Content-Disposition: inline
In-Reply-To: <744357E9AAD1214791ACBA4B0B9092633A972721@SHSMSX101.ccr.corp.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Zhang, Rui" <rui.zhang@intel.com>
Cc: Michele DiGiorgio <michele.digiorgio@arm.com>, Steven Rostedt <rostedt@goodmis.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Punit Agrawal <punit.agrawal@arm.com>, Eduardo Valentin <edubezval@gmail.com>

On Tue, Mar 08, 2016 at 09:48:42AM +0000, Zhang, Rui wrote:
> Punit and Javi,
> 
> What do you think of this? I'd like to get your ACK before taking it.

Sorry, I didn't realize you were waiting for us.  I'm quite happy for
this to go in:

Acked-by: Javi Merino <javi.merino@arm.com>

> >  -----Original Message-----
> > From: linux-pm-owner@vger.kernel.org [mailto:linux-pm-
> > owner@vger.kernel.org] On Behalf Of Michele DiGiorgio
> > Sent: Friday, March 04, 2016 1:11 AM
> > To: Steven Rostedt <rostedt@goodmis.org>
> > Cc: linux-pm@vger.kernel.org; Ingo Molnar <mingo@redhat.com>; Javi
> > Merino <javi.merino@arm.com>; linux-kernel@vger.kernel.org; Punit
> > Agrawal <punit.agrawal@arm.com>; Eduardo Valentin <edubezval@gmail.com>
> > Subject: Re: [PATCH] thermal: trace: migrating thermal traces to use
> > TRACE_DEFINE_ENUM() macros
> > 
> > Hello Steven,
> > 
> > Thanks for acknowledging the patch.
> > 
> > Will you be merging it or should I refer to somebody else?
> > 
> > Kind regards,
> > Michele
> > 
> > On 01/03/16 18:20, Steven Rostedt wrote:
> > > On Tue,  1 Mar 2016 17:38:54 +0000
> > > Michele Di Giorgio <michele.digiorgio@arm.com> wrote:
> > >
> > > > Userspace tools are not aware of how to convert the enums provided
> > > > by the tracepoints to their corresponding strings.
> > > >
> > > > Adding TRACE_DEFINE_ENUM() macros allows to make the enums available
> > > > to userspace to let the tools know what those enum values represent.
> > > >
> > > > In particular, for thermal zone trip types what we obtained before
> > > > was something like:
> > > >
> > > > kworker/1:1-460   [001]   320.372732: thermal_zone_trip:
> > thermal_zone=soc
> > > >                 id=0 trip=1 trip_type=1
> > > >
> > > > Unfortunately, userspace tools do not know how to convert enum
> > > > values to strings and as a consequence they can only forward the
> > > > enum value to the output. By using TRACE_DEFINE_ENUM() macros for
> > > > thermal traces we get the following trace line:
> > > >
> > > > kworker/1:1-460   [001]   320.372732: thermal_zone_trip:
> > thermal_zone=soc
> > > >                 id=0 trip=1 trip_type=PASSIVE
> > > >
> > > > Userspace tools are now able to better understand the meaning of the
> > > > trip_type and provide the user with more readable information.
> > > >
> > >
> > > Acked-by: Steven Rostedt <rostedt@goodmis.org>
> > >
> > > -- Steve
> > >
> > 
> > IMPORTANT NOTICE: The contents of this email and any attachments are
> > confidential and may also be privileged. If you are not the intended recipient,
> > please notify the sender immediately and do not disclose the contents to any
> > other person, use it for any purpose, or store or copy the information in any
> > medium. Thank you.
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-pm" in the body
> > of a message to majordomo@vger.kernel.org More majordomo info at
> > http://vger.kernel.org/majordomo-info.html
