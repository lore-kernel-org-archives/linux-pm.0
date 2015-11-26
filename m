From: James Morse <james.morse@arm.com>
Subject: Re: [PATCH v2 10/11] PM / Hibernate: clean cached pages on architectures
 that require it
Date: Thu, 26 Nov 2015 14:23:37 +0000
Message-ID: <565715E9.4080805@arm.com>
References: <1445966960-31724-1-git-send-email-james.morse@arm.com> <1445966960-31724-11-git-send-email-james.morse@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:45327 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752201AbbKZOY1 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 26 Nov 2015 09:24:27 -0500
In-Reply-To: <1445966960-31724-11-git-send-email-james.morse@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Will Deacon <will.deacon@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Kevin Kang <kkang@intrinsyc.com>, Geoff Levand <geoff@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, AKASHI Takahiro <takahiro.akashi@linaro.org>, wangfei <w.f@huawei.com>, Marc Zyngier <marc.zyngier@arm.com>

On 27/10/15 17:29, James Morse wrote:
> Some architectures require code written to memory as if it were data to be
> 'cleaned' from any data caches so that the processor can fetch them as new
> instructions.
> 
> During resume from hibernate, the snapshot code copies some pages directly,
> meaning these architectures do not get a chance to perform their cache
> maintenance. Add a call to flush_icache_range(), which is provided by
> architectures that require it, to perform the maintenance.
> 
> This mirrors the kernel's behaviour when loading kernel modules and when
> mapping executable pages to user space.

While trying to benchmark the impact of this patch on 32bit ARM, I've
discovered the fix is in the wrong place! do_copy_page() isn't used on
the resume path for the pages restored 'in place'.

I will produce another version of the series - hopefully later today.



James
