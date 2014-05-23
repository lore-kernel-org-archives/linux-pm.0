From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: Re: [PATCH] PM: trace events for suspend/resume
Date: Fri, 23 May 2014 12:06:23 +0530
Message-ID: <537EEC67.9030909@linux.vnet.ibm.com>
References: <20140519230226.GA14382@linux.intel.com> <2794431.xZpr01emRq@vostro.rjw.lan> <537E7756.1000503@linux.vnet.ibm.com> <1400798669.26671.12.camel@pippen.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e28smtp08.in.ibm.com ([122.248.162.8]:33478 "EHLO
	e28smtp08.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751904AbaEWGhg (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 23 May 2014 02:37:36 -0400
Received: from /spool/local
	by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
	Fri, 23 May 2014 12:07:33 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
	by d28dlp03.in.ibm.com (Postfix) with ESMTP id 653FF1258056
	for <linux-pm@vger.kernel.org>; Fri, 23 May 2014 12:06:39 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
	by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id s4N6bfa09634168
	for <linux-pm@vger.kernel.org>; Fri, 23 May 2014 12:07:41 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
	by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id s4N6bTPB013198
	for <linux-pm@vger.kernel.org>; Fri, 23 May 2014 12:07:29 +0530
In-Reply-To: <1400798669.26671.12.camel@pippen.local.home>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, todd.e.brandt@linux.intel.com, linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com

On 05/23/2014 04:14 AM, Steven Rostedt wrote:
> On Fri, 2014-05-23 at 03:46 +0530, Srivatsa S. Bhat wrote:
>> Hi Todd,
>>
>> This might be a silly question, but the suspend_enter() function invokes
>> ftrace_stop() before suspending the machine, and restarts ftrace after
>> resume. And your patch seems to instrument code further down (deeper)
>> in the suspend/resume path (such as disable_nonboot_cpus() for example).
>> Doesn't the ftrace stop/start pose any problem for this patch?
> 
> ftrace_start/stop() only affects the function tracer and not the
> tracepoints. Those will still be recorded.
> 

Ah, thank you for the clarification.

> Note, we have an invested interest in getting rid of
> ftrace_stop/start(). I rather mark all the suspend code with notrace or
> find another method to protect suspend from function tracing. The
> ftrace_stop/start() was more of a big hammer approach and I had plans
> for getting rid of it in the future. That future is approaching fast :-)
>

Ok.. :-)

 
Regards,
Srivatsa S. Bhat

