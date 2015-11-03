From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 1/2] x86 smpboot: fix cpu_init_udelay=10000
Date: Tue, 3 Nov 2015 00:16:55 -0500
Message-ID: <CAJvTdKnagWXhA2sFD79fAx4oudrZ5CSPDFPt+g=+FTLHq27ncA@mail.gmail.com>
References: <1444968869-21435-1-git-send-email-lenb@kernel.org>
	<de363cdbbcfcca1d22569683f7eb9873e0177251.1444968087.git.len.brown@intel.com>
	<0bc26e9524533c38fdbdc95eed2b1448@teksavvy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f67.google.com ([209.85.215.67]:35247 "EHLO
	mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750742AbbKCFQ5 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 3 Nov 2015 00:16:57 -0500
In-Reply-To: <0bc26e9524533c38fdbdc95eed2b1448@teksavvy.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: shrybman <shrybman@teksavvy.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, dparsons@brightdsl.net, X86 ML <x86@kernel.org>, Len Brown <len.brown@intel.com>

> Is this really what you intended? The else is commented out so if init_udelay is quirked
> to be 0 it will always be reset to UDELAY_10MS_DEFAULT. Also init_udelay is unsigned, so
> would UINT_MAX be a better choice?

Hi Shane,
Thanks for pointing out this flaw.
Seems it will make 4.3 10ms slower than 4.2 on these boxes, by default.
We'll send an incremental patch for 4.4.

Len Brown, Intel Open Source Technology Center
