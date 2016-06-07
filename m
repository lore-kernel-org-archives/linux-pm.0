From: Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH][RFC] x86, hotplug: Use zero page for monitor when
 resuming from hibernation
Date: Tue, 7 Jun 2016 11:13:49 +0200
Message-ID: <20160607091349.GA1170@pd.tnic>
References: <1465222749-8388-1-git-send-email-yu.c.chen@intel.com>
 <20160607080307.GB13858@amd>
 <57568968.2090100@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:35179 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753432AbcFGJNx (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 7 Jun 2016 05:13:53 -0400
Content-Disposition: inline
In-Reply-To: <57568968.2090100@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Chen Yu <yu.c.chen@intel.com>
Cc: Pavel Machek <pavel@ucw.cz>, x86@kernel.org, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, linux-pm@vger.kernel.org, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Peter Zijlstra <peterz@infradead.org>, Zhu Guihua <zhugh.fnst@cn.fujitsu.com>, Juergen Gross <jgross@suse.com>, "Zheng, Lv" <lv.zheng@intel.com>, Brian Gerst <brgerst@gmail.com>

On Tue, Jun 07, 2016 at 04:44:24PM +0800, Chen Yu wrote:
> I'm doing more test to verify this.

I think it would be better if you looked into doing HLT as Brian
suggested, instead of touching any memory during s/r.

--=20
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imend=C3=B6rffer, Jane Smithard, Graham Nort=
on, HRB 21284 (AG N=C3=BCrnberg)
--=20
