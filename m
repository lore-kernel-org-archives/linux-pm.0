From: Geoff Levand <geoff@infradead.org>
Subject: Re: [PATCH v2 02/11] arm64: Fold proc-macros.S into assembler.h
Date: Mon, 16 Nov 2015 10:44:52 -0800
Message-ID: <1447699492.31339.2.camel@infradead.org>
References: <1445966960-31724-1-git-send-email-james.morse@arm.com>
	 <1445966960-31724-3-git-send-email-james.morse@arm.com>
	 <20151114212515.GF20429@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:39854 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751301AbbKPSpD (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 16 Nov 2015 13:45:03 -0500
In-Reply-To: <20151114212515.GF20429@amd>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>, James Morse <james.morse@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, Will Deacon <will.deacon@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Kevin Kang <kkang@intrinsyc.com>, Catalin Marinas <catalin.marinas@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, AKASHI Takahiro <takahiro.akashi@linaro.org>, wangfei <w.f@huawei.com>, Marc Zyngier <marc.zyngier@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org

Hi,

On Sat, 2015-11-14 at 22:25 +0100, Pavel Machek wrote:
> On Tue 2015-10-27 17:29:11, James Morse wrote:

> > From: Geoff Levand <geoff@infradead.org>
> Why the two stars?

I have a newer version that fixed that typo in
my kexec-v11 branch:

http://git.kernel.org/cgit/linux/kernel/git/geoff/linux-kexec.git/commit/?h=kexec-v11&id=afbeea6ab2e1aa3ea8c4683521ac155667f86ca1

-Geoff


