From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 2/8] ACPI, x86: fix Dell M6600 ACPI reboot regression via
 DMI
Date: Fri, 6 Jul 2012 13:09:58 +0200
Message-ID: <20120706110958.GF19552@gmail.com>
References: <9f132652d94c96476b0b0a8caf0c10e96ab10fa8.1341032550.git.len.brown@intel.com>
 <76eb9a30db4bc8fd172f9155247264b5f2686d7b.1341032550.git.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <76eb9a30db4bc8fd172f9155247264b5f2686d7b.1341032550.git.len.brown@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, x86@kernel.org, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org


* Len Brown <lenb@kernel.org> wrote:

> From: Zhang Rui <rui.zhang@intel.com>
> 
> Dell Precision M6600 is known to require PCI reboot, so add it to
> the reboot blacklist in pci_reboot_dmi_table[].
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=42749
> 
> cc: x86@kernel.org
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> Signed-off-by: Len Brown <len.brown@intel.com>
> ---
>  arch/x86/kernel/reboot.c | 8 ++++++++
>  1 file changed, 8 insertions(+)

Acked-by: Ingo Molnar <mingo@kernel.org>

Thanks,

	Ingo
