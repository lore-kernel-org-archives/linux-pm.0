From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 2/2] x86: speed cpu_up by quirking cpu_init_udelay
Date: Fri, 8 May 2015 20:27:32 +0200
Message-ID: <20150508182731.GF3904@pd.tnic>
References: <418898b5b9a6d76e7fbbd2af7cc988de1a5a287d.1431066425.git.len.brown@intel.com>
 <170f6f6e9ac4aa4d8ec1ed5000bee95463897337.1431066425.git.len.brown@intel.com>
 <20150508083250.GB4137@pd.tnic>
 <CAJvTdKk3TM1PMUgGeWCxThzVknfBc8xMK-dJkbxJrwkWhjGzLg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:43898 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753270AbbEHS1e (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 8 May 2015 14:27:34 -0400
Content-Disposition: inline
In-Reply-To: <CAJvTdKk3TM1PMUgGeWCxThzVknfBc8xMK-dJkbxJrwkWhjGzLg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: X86 ML <x86@kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>

On Fri, May 08, 2015 at 02:15:42PM -0400, Len Brown wrote:
> I agree with you. Further, you made me think about it, and while it
> was helpful when I wrote the patch, I don't think any printk() is
> needed upstream.

Yeah, you're right.

If a user did override it with cpu_init_udelay, it'll be in
/proc/cmdline. And dmesg, and so on...

> see v3 just sent.

Looks ok.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
