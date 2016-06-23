From: Yu Chen <yu.chen.surf@gmail.com>
Subject: Re: [LKP] [PATCH] x86: fix rdmsr MSR_PLATFORM_INFO unsafe warning in
 kvm guest
Date: Thu, 23 Jun 2016 15:37:51 +0800
Message-ID: <CADjb_WRQDYKoYqmfpfhHN_5rui_90rS0DD2JxRh6d5Wp5TMsgQ@mail.gmail.com>
References: <1466558908-3524-1-git-send-email-wanpeng.li@hotmail.com> <alpine.DEB.2.11.1606230908140.5839@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:32880 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750960AbcFWHhx (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 23 Jun 2016 03:37:53 -0400
In-Reply-To: <alpine.DEB.2.11.1606230908140.5839@nanos>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Wanpeng Li <kernellwp@gmail.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, kvm@vger.kernel.org, Linux PM list <linux-pm@vger.kernel.org>, the arch/x86 maintainers <x86@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Jacob Pan <jacob.jun.pan@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Paolo Bonzini <pbonzini@redhat.com>, Zhang Rui <rui.zhang@intel.com>, lkp@01.org, Wanpeng Li <wanpeng.li@hotmail.com>, Chen Yu <yu.c.chen@intel.com>

On Thu, Jun 23, 2016 at 3:09 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
> On Wed, 22 Jun 2016, Wanpeng Li wrote:
>> After commit (fc141535ad8 : "x86 tsc_msr: Extend to include Intel Core
>
> Where did you find that commit? It's neither in Linus tree nor in tip.
>
It is in Len's tree, we are planing to resend the patchset with Wanpeng's fix
merged with a credit to him in commit msg, thanks for Wanpeng's effort.
thanks all.
