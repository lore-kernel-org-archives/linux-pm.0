From: James Morse <james.morse@arm.com>
Subject: Re: [PATCH] PM / Hibernate: Don't let kasan instrument snapshot.c
Date: Wed, 15 Jun 2016 11:25:18 +0100
Message-ID: <57612D0E.5050209@arm.com>
References: <1464870032-12289-1-git-send-email-james.morse@arm.com> <7230305.BYjCFel4WC@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:36252 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932356AbcFOK1g (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 15 Jun 2016 06:27:36 -0400
In-Reply-To: <7230305.BYjCFel4WC@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Catalin Marinas <catalin.marinas@arm.com>, Pavel Machek <pavel@ucw.cz>

Hi Rafael,

On 15/06/16 00:26, Rafael J. Wysocki wrote:
> Does the arch code need to be annotated in a similar way too?

Only if you do the restore copying from C, both 32bit and 64bit x86 do this copy
in assembly code, which doesn't get instrumented.


Thanks,

James
