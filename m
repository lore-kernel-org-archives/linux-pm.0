From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] intel_idle: stop exposing platform acronyms in sysfs
Date: Wed, 1 Mar 2017 00:55:40 +0100
Message-ID: <CAJZ5v0id82bcw-i2dVhu-XsvG2PkBTRw3VtYUJ0KwzMo=YrzhA@mail.gmail.com>
References: <c76f694bed60071096502e065313726e399df563.1488317499.git.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <c76f694bed60071096502e065313726e399df563.1488317499.git.len.brown@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>, Thomas Renninger <trenn@suse.de>
List-Id: linux-pm@vger.kernel.org

On Tue, Feb 28, 2017 at 10:32 PM, Len Brown <lenb@kernel.org> wrote:
> From: Len Brown <len.brown@intel.com>
>
> Cosmetic only -- no functional change in this patch.
>
> sysfs before:
>
> state4/desc:MWAIT 0x20
> state4/name:C6-HSW
>
> sysfs after:
>
> state4/desc:MWAIT 0x20
> state4/name:C6
>
> We remove the platform acronyms from the end of the state name
> (-HSW in this case) for three reasonse.
>
> 1. more consistency with acpi_idle, which prints C1, C2, C3 etc.
>
> 2. users know what platform they are on already
>    an acronym for the processor code name here
>    seems to cause more confusion than clarity.
>
> 3. less clutter in "cpupower monitor" output,
>    which truncates the names to 4 columns.
>
> The precise definition of the state continues to be available in "desc".
>
> Cc: Thomas Renninger <trenn@suse.de>
> Reported-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
> Signed-off-by: Len Brown <len.brown@intel.com>

I think I can apply this one right away if you want me to do that.

Thanks,
Rafael
