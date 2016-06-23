From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] x86: fix rdmsr MSR_PLATFORM_INFO unsafe warning in kvm
 guest
Date: Thu, 23 Jun 2016 09:09:22 +0200 (CEST)
Message-ID: <alpine.DEB.2.11.1606230908140.5839@nanos>
References: <1466558908-3524-1-git-send-email-wanpeng.li@hotmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1466558908-3524-1-git-send-email-wanpeng.li@hotmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Wanpeng Li <kernellwp@gmail.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, Linux PM list <linux-pm@vger.kernel.org>, linux-acpi@vger.kernel.org, lkp@01.org, x86@kernel.org, Wanpeng Li <wanpeng.li@hotmail.com>, Len Brown <len.brown@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Zhang Rui <rui.zhang@intel.com>, Chen Yu <y.c.chen@intel.com>, Paolo Bonzini <pbonzini@redhat.com>, =?ISO-8859-2?Q?Radim_Kr=E8m=E1=F8?= <rkrcmar@redhat.com>, jacob.jun.pan@intel.com, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>
List-Id: linux-pm@vger.kernel.org

On Wed, 22 Jun 2016, Wanpeng Li wrote:
> After commit (fc141535ad8 : "x86 tsc_msr: Extend to include Intel Core 

Where did you find that commit? It's neither in Linus tree nor in tip.

Thanks,

	tglx
