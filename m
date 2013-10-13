From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH v2] platform: x86: asus-wmi: add fan control
Date: Sun, 13 Oct 2013 16:17:29 +0100
Message-ID: <20131013151729.GA4028@srcf.ucam.org>
References: <1381236524-19633-1-git-send-email-felipe.contreras@gmail.com>
 <CAHR064ge8zew7uMeD+_LXR3ju5ARGG1y8utLOFzOLexny_DPLA@mail.gmail.com>
 <1381421199.4248.2.camel@x230.lan>
 <CAMP44s04+_aP7KpVMTUjdNcRWMg6PC6HBaNhF_uhAHm=fhmTcw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMP44s04+_aP7KpVMTUjdNcRWMg6PC6HBaNhF_uhAHm=fhmTcw@mail.gmail.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: "corentin.chary@gmail.com" <corentin.chary@gmail.com>, "acpi4asus-user@lists.sourceforge.net" <acpi4asus-user@lists.sourceforge.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Sun, Oct 13, 2013 at 04:29:34AM -0500, Felipe Contreras wrote:

> I don't see anything in acpi_ex_system_memory_space_handler() that
> takes into consideration virtual addresses.

The spec doesn't seem to constrain it to physical addresses (it just 
refers to "Control Methods read and write data to locations in address 
spaces (for example, System memory and System I/O)", so I'd lean towards 
changing the behaviour of acpica rather than adding virt_to_phys().

-- 
Matthew Garrett | mjg59@srcf.ucam.org
