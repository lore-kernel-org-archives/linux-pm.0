From: shrybman <shrybman@teksavvy.com>
Subject: Re: [PATCH 1/2] x86 smpboot: fix cpu_init_udelay=10000
Date: Thu, 05 Nov 2015 21:39:26 -0500
Message-ID: <60ad3f7df9604e39d9af180f6b56bb69@teksavvy.com>
References: <1444968869-21435-1-git-send-email-lenb@kernel.org>
	<de363cdbbcfcca1d22569683f7eb9873e0177251.1444968087.git.len.brown@intel.com>
	<0bc26e9524533c38fdbdc95eed2b1448@teksavvy.com>
	<CAJvTdKnagWXhA2sFD79fAx4oudrZ5CSPDFPt+g=+FTLHq27ncA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from ironport2-out.teksavvy.com ([206.248.154.181]:45141 "EHLO
	ironport2-out.teksavvy.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1031154AbbKFCjc convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 5 Nov 2015 21:39:32 -0500
In-Reply-To: <CAJvTdKnagWXhA2sFD79fAx4oudrZ5CSPDFPt+g=+FTLHq27ncA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Len Brown <len.brown@intel.com>, X86 ML <x86@kernel.org>, dparsons@brightdsl.net, Linux PM list <linux-pm@vger.kernel.org>, linux-kernel@vger.kernel.org

> > Is this really what you intended? The else is commented out so if init_udelay is quirked
> > to be 0 it will always be reset to UDELAY_10MS_DEFAULT. Also init_udelay is unsigned, so
> > would UINT_MAX be a better choice?
> 
> Hi Shane,
> Thanks for pointing out this flaw.
> Seems it will make 4.3 10ms slower than 4.2 on these boxes, by default.
> We'll send an incremental patch for 4.4.


Sounds good. Thanks Len.

