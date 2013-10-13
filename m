From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2] platform: x86: asus-wmi: add fan control
Date: Sun, 13 Oct 2013 04:29:34 -0500
Message-ID: <CAMP44s04+_aP7KpVMTUjdNcRWMg6PC6HBaNhF_uhAHm=fhmTcw@mail.gmail.com>
References: <1381236524-19633-1-git-send-email-felipe.contreras@gmail.com>
	<CAHR064ge8zew7uMeD+_LXR3ju5ARGG1y8utLOFzOLexny_DPLA@mail.gmail.com>
	<1381421199.4248.2.camel@x230.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1381421199.4248.2.camel@x230.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthew Garrett <matthew.garrett@nebula.com>
Cc: "corentin.chary@gmail.com" <corentin.chary@gmail.com>, "acpi4asus-user@lists.sourceforge.net" <acpi4asus-user@lists.sourceforge.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Oct 10, 2013 at 11:06 AM, Matthew Garrett
<matthew.garrett@nebula.com> wrote:
> On Thu, 2013-10-10 at 16:59 +0100, Corentin Chary wrote:
>
>>
>> This doesn't really seems to be related to wmi, and is likely to be
>> available only on a subset of models. Maybe it should a separate
>> driver instead ?
>
> This version seems to be implemented entirely in WMI, and it's using the
> same WMI GUID as asus-wmi - implementing it here seems appropriate. I am
> concerned about the phys/virt thing, though. The ACPI interpreter is
> running in the kernel, not the hardware - are we artificially limiting
> SystemMemory opregions to physical addresses?

I don't see anything in acpi_ex_system_memory_space_handler() that
takes into consideration virtual addresses.

-- 
Felipe Contreras
