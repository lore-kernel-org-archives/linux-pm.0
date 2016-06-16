From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] PM / Hibernate: Don't let kasan instrument snapshot.c
Date: Thu, 16 Jun 2016 03:22:36 +0200
Message-ID: <10410002.s5W5iLN5MG@vostro.rjw.lan>
References: <1464870032-12289-1-git-send-email-james.morse@arm.com> <7230305.BYjCFel4WC@vostro.rjw.lan> <57612D0E.5050209@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:44870 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753214AbcFPBS0 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 15 Jun 2016 21:18:26 -0400
In-Reply-To: <57612D0E.5050209@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: James Morse <james.morse@arm.com>
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Catalin Marinas <catalin.marinas@arm.com>, Pavel Machek <pavel@ucw.cz>

On Wednesday, June 15, 2016 11:25:18 AM James Morse wrote:
> Hi Rafael,
> 
> On 15/06/16 00:26, Rafael J. Wysocki wrote:
> > Does the arch code need to be annotated in a similar way too?
> 
> Only if you do the restore copying from C, both 32bit and 64bit x86 do this copy
> in assembly code, which doesn't get instrumented.

OK, that's what I wanted to know.

Thanks!

