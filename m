From: Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH v5 00/15] arm64: kernel: Add support for hibernate/suspend-to-disk
Date: Tue, 23 Feb 2016 10:29:02 -0800
Message-ID: <7h37sjuvpt.fsf@baylibre.com>
References: <1455637767-31561-1-git-send-email-james.morse@arm.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:36288 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755019AbcBWS3E (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 23 Feb 2016 13:29:04 -0500
Received: by mail-pa0-f43.google.com with SMTP id yy13so114324722pab.3
        for <linux-pm@vger.kernel.org>; Tue, 23 Feb 2016 10:29:04 -0800 (PST)
In-Reply-To: <1455637767-31561-1-git-send-email-james.morse@arm.com> (James
	Morse's message of "Tue, 16 Feb 2016 15:49:12 +0000")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: James Morse <james.morse@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, Will Deacon <will.deacon@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Geoff Levand <geoff@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, AKASHI Takahiro <takahiro.akashi@linaro.org>, Marc Zyngier <marc.zyngier@arm.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org

James Morse <james.morse@arm.com> writes:

> This version of hibernate is based on v4.5-rc4, with the contents of the arm64
> for-next/pgtable branch and Ard's v6sub1 "arm64: split linear and kernel
> mappings" series [0]. The patches shared with kexec still come from v13 [1].

FYI... in addition to juno-r2, I've now tested this version on the
Mediatek mt8173-evb platform as well, using an exteral MMC card as swap,
and everything worked well.

Tested-by: Kevin Hilman <khilman@baylibre.com>

Kevin
