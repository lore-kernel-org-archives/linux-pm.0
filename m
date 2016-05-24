From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH][v7] x86, suspend: Save/restore extra MSR registers for suspend
Date: Tue, 24 May 2016 12:09:56 -0400
Message-ID: <CAJvTdKn9XyutRAk4Hf5tarQVkCQ4QQL3wtM5RHYfsMg8P3mhnA@mail.gmail.com>
References: <c9abdcbc173dd2f57e8990e304376f19287e92ba.1448382971.git.yu.c.chen@intel.com>
	<20151126090940.GA30403@gmail.com>
	<36DF59CE26D8EE47B0655C516E9CE64028677FF5@shsmsx102.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <36DF59CE26D8EE47B0655C516E9CE64028677FF5@shsmsx102.ccr.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Chen, Yu C" <yu.c.chen@intel.com>
Cc: Ingo Molnar <mingo@kernel.org>, "mingo@redhat.com" <mingo@redhat.com>, "tglx@linutronix.de" <tglx@linutronix.de>, "hpa@zytor.com" <hpa@zytor.com>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "pavel@ucw.cz" <pavel@ucw.cz>, "Brown, Len" <len.brown@intel.com>, "luto@kernel.org" <luto@kernel.org>, "bp@suse.de" <bp@suse.de>, "linux@horizon.com" <linux@horizon.com>, "Kaszewski, Marcin" <marcin.kaszewski@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>
List-Id: linux-pm@vger.kernel.org

+mjg59, who may be seeing this issue on a skylake laptop

Chen-yu,

Great debugging, but I think there is a more general fix possible than
this DMI quirk.

I agree that in this example, a grantley server, it seems the BIOS is
erroneously
returning a bogus value of MSR_IA32_THERM_CONTROL on resume from S3.

But another scenario is also possible.  Consider a laptop that is resuming HOT
and the BIOS correctly enables throttling.  If this code were invoked, it would
restore the COLD setting.

Instead, it seems to me that the ACPI processor driver should upon .resume
check if throttling should be enabled or not, and proceed accordingly.
That would always do the "right thing", and would not need a DMI list.
Does that make sense?

thanks,
Len Brown, Intel Open Source Technology Center
