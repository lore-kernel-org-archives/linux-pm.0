From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 0/2 v3] speed up cpu_up()
Date: Sun, 10 May 2015 12:44:07 +0200
Message-ID: <20150510104407.GA24027@gmail.com>
References: <1431107287-22022-1-git-send-email-lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:36190 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752199AbbEJKoM (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 10 May 2015 06:44:12 -0400
Content-Disposition: inline
In-Reply-To: <1431107287-22022-1-git-send-email-lenb@kernel.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org


* Len Brown <lenb@kernel.org> wrote:

> Thanks for the feedback, here is a simplifed pair of patches.
> 
> I also like the x2apic optimization, since it addresses additional delays.
>  -- though we may be able to optimize those in the non-x2apic case too.
> 
> thanks,
> Len Brown, Intel Open Source Technology Center

Could you please send it against tip:master, so that it applies 
cleanly to the x2apic optimization which is already applied?

Thanks,

	Ingo
