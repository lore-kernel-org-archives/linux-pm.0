From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 0/1] speeding up cpu_up()
Date: Tue, 5 May 2015 09:15:11 +0200
Message-ID: <20150505071510.GA3910@pd.tnic>
References: <1429404795-23260-1-git-send-email-lenb@kernel.org>
 <20150420071556.GB14315@gmail.com>
 <CAJvTdKnYbJbun_UJXbGgKuh7DEBXoQdD6Unbm=Jopuw_C_U4ng@mail.gmail.com>
 <20150501224729.GN10239@pd.tnic>
 <55441D8C.2080509@amd.com>
 <55464925.5050600@amd.com>
 <5547F67D.2080307@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:46579 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756304AbbEEHPN (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 5 May 2015 03:15:13 -0400
Content-Disposition: inline
In-Reply-To: <5547F67D.2080307@amd.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Aravind Gopalakrishnan <aravind.gopalakrishnan@amd.com>, Len Brown <lenb@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, X86 ML <x86@kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>

On Mon, May 04, 2015 at 05:45:17PM -0500, Aravind Gopalakrishnan wrote:
> Tested a delay of 0 on Fam10h and Fam15h Model 30h-3fh and both work fine.

Cool, thanks for testing.

> Feedback from asking internally about this is that we should be OK to move
> to a no-delay default from K8 onwards.

Also cool :-)

@Len: So everything with X86_VENDOR_AMD and c->x86 >= 0xf should be fine.

Thanks.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
