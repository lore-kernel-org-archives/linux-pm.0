From: Chen Yu <yu.chen.surf@gmail.com>
Subject: Re: [PATCH][v7] x86, suspend: Save/restore extra MSR registers for suspend
Date: Wed, 25 May 2016 13:02:30 +0800
Message-ID: <CADjb_WR+ZtBf4x=JkdGhfbBNDGL=eskQp8-FADCSAzHkDLPd8w@mail.gmail.com>
References: <c9abdcbc173dd2f57e8990e304376f19287e92ba.1448382971.git.yu.c.chen@intel.com>
	<20151126090940.GA30403@gmail.com>
	<36DF59CE26D8EE47B0655C516E9CE64028677FF5@shsmsx102.ccr.corp.intel.com>
	<CAJvTdKn9XyutRAk4Hf5tarQVkCQ4QQL3wtM5RHYfsMg8P3mhnA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJvTdKn9XyutRAk4Hf5tarQVkCQ4QQL3wtM5RHYfsMg8P3mhnA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@suse.de>, George Spelvin <linux@horizon.com>, "Kaszewski, Marcin" <marcin.kaszewski@intel.com>, Matthew Garrett <mjg59@srcf.ucam.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Chen Yu <yu.c.chen@intel.com>
List-Id: linux-pm@vger.kernel.org

Hi Len,

On Wed, May 25, 2016 at 12:09 AM, Len Brown <lenb@kernel.org> wrote:
> +mjg59, who may be seeing this issue on a skylake laptop
>
> Chen-yu,
>
> Great debugging, but I think there is a more general fix possible than
> this DMI quirk.
>
> I agree that in this example, a grantley server, it seems the BIOS is
> erroneously
> returning a bogus value of MSR_IA32_THERM_CONTROL on resume from S3.
>
> But another scenario is also possible.  Consider a laptop that is resuming HOT
> and the BIOS correctly enables throttling.  If this code were invoked, it would
> restore the COLD setting.
>
> Instead, it seems to me that the ACPI processor driver should upon .resume
> check if throttling should be enabled or not, and proceed accordingly.
> That would always do the "right thing", and would not need a DMI list.
> Does that make sense?
I agree, to let the related drivers customize their restoring process
would be more robust,
and we can not only take care of boot CPU but also nonboot CPUs in this way.
I think we can add something like acpi_processor_reevaluate_tstate in the resume
hook,I'll make a double check.

thanks,
Yu
