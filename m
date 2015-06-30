From: Len Brown <lenb@kernel.org>
Subject: Re: Getting rid of i7300_idle's idle notifier?
Date: Tue, 30 Jun 2015 16:09:02 -0400
Message-ID: <CAJvTdK=Pn02LHVjETso8dzmxK3J-8Qm_0-AFg9OHkD7AvfaSeg@mail.gmail.com>
References: <CALCETrVGefbgXzvjC3bTm9DgSr2UkpsPn6P_QwKm1cogZ0AVkQ@mail.gmail.com>
	<CALCETrUb6yhLAZ5P3J86h7DVR-vq0aVD9EHTc3YRPU2E735ETg@mail.gmail.com>
	<20150605065219.GA19628@gmail.com>
	<CALCETrXZ7tSdeDBOSoJ1u06oUgj9tnSE48V1LQWi+XTJQ3pnzg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-la0-f47.google.com ([209.85.215.47]:34420 "EHLO
	mail-la0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750821AbbF3UJE (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 30 Jun 2015 16:09:04 -0400
In-Reply-To: <CALCETrXZ7tSdeDBOSoJ1u06oUgj9tnSE48V1LQWi+XTJQ3pnzg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andy Lutomirski <luto@amacapital.net>
Cc: Ingo Molnar <mingo@kernel.org>, Andy Lutomirski <luto@kernel.org>, Andy Henroid <andrew.d.henroid@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, X86 ML <x86@kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>

> Barely.  I don't have the hardware, I have no idea what the registers
> that i7300_idle pokes are for, and I have no particular desire to
> start reading the datasheet.  I'm not even really sure that i7300
> machines use acpi's processor_idle instead of intel_idle.
>
> I'm happy to give the driver maintainers a few days to respond.  Andy?

i7300 does not use intel_idle.
it is core2-xeon -- pre-nehalem.

Len Brown, Intel Open Source Technology Center
