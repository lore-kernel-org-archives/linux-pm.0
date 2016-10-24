From: Sinan Kaya <okaya@codeaurora.org>
Subject: Re: [PATCH V4 2/3] Revert "ACPI,PCI,IRQ: remove SCI penalize
 function"
Date: Sun, 23 Oct 2016 23:48:40 -0400
Message-ID: <6fb06d82-13aa-555b-72fc-06e670f9fd28@codeaurora.org>
References: <1476915664-27231-1-git-send-email-okaya@codeaurora.org>
 <1476915664-27231-3-git-send-email-okaya@codeaurora.org>
 <20161021015814.GC31044@localhost> <20161021144535.GB877@localhost>
 <2a824792-486a-6251-4931-c5cc6fd67978@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2a824792-486a-6251-4931-c5cc6fd67978@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-acpi@vger.kernel.org, rjw@rjwysocki.net, bhelgaas@google.com, ravikanth.nalla@hpe.com, linux@rainbow-software.org, timur@codeaurora.org, cov@codeaurora.org, jcm@redhat.com, alex.williamson@redhat.com, Len Brown <len.brown@intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, linux-pm@vger.kernel.org, linux-pci@vger.kernel.org, agross@codeaurora.org, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Pavel Machek <pavel@ucw.cz>, linux-arm-msm@vger.kernel.org, wim@djo.tudelft.nl, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On 10/21/2016 12:13 PM, Sinan Kaya wrote:
>> Wait a minute, I still have a question here: what about other ACPI
>> > arches (ia64, arm64)?  Don't they need to call acpi_penalize_sci_irq()
>> > somewhere?
>> > 
> ACPI ARM64 architecture implements reduced ACPI profile which doesn't
> have GED object.

I actually wanted to mean that ARM64 architecture doesn't have *GPE* object
implemented on ACPI reduced profile.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
