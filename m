From: Prarit Bhargava <prarit@redhat.com>
Subject: Re: cpupower reports uninitialized values for offline cpus
Date: Thu, 01 Oct 2015 09:11:55 -0400
Message-ID: <560D311B.8090507@redhat.com>
References: <560ADF55.6090901@redhat.com> <2397035.37ChXSYNtU@skinner> <560C292B.5030905@redhat.com> <3211183.5fvOAutzxZ@skinner>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42313 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933358AbbJANL4 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 1 Oct 2015 09:11:56 -0400
In-Reply-To: <3211183.5fvOAutzxZ@skinner>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: Jacob Tanenbaum <jtanenba@redhat.com>, linux-pm@vger.kernel.org



On 10/01/2015 08:29 AM, Thomas Renninger wrote:
> On Wednesday, September 30, 2015 02:25:47 PM Prarit Bhargava wrote:
>> On 09/30/2015 12:23 PM, Thomas Renninger wrote:
> ...
>> Yeah, we'd have to add an additional state to the CPU hotplug callback state
>> machine (CPU_ADD_PHYSICAL?) to identify when a cpu was hot-added.  I
>> suppose it could be done but it seems like an awful lot of churn for little
>> gain.
> 
> It shouldn't be that hard.
> If I find some time I give it a try.
> This is a rather central piece of kernel code and affects
> more or less all architectures, so getting this finally mainline
> may take a while...
> 
> So it would be nice if somewhen in the future we have 2 independent
> fixes:
> 
> The cpupower one as you wrote before, ignoring cores without
> topology sysfs info (but not simply checking for "is core offline"),
> better check whether the directory or a specific file exists.
> 
> And a kernel one which still shows topology info of soft offlined
> cores which with above cpupower solution will result in previous
> output (offlined cores listed, but with valid topology info).
> 
> Makes sense?

Yup, makes sense.  Jacob (Jake) is going to handle the cpupower stuff right
away.  I'll dive into the topology stuff in a little bit and/or assist Jake with it.

Thanks Thomas :)

P.

> 
>       Thomas
> 
