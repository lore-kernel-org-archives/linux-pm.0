From: Borislav Petkov <bp@alien8.de>
Subject: Re: [RFC PATCH] x86: Move away from /dev/cpu/*/msr
Date: Wed, 15 Jun 2016 19:52:34 +0200
Message-ID: <20160615175234.GF30309@pd.tnic>
References: <20160615100029.GB32588@pd.tnic>
 <CAJvTdKkoMPZTagM_wRSCwbb=NKfBAU8SNMPz2hZuPhPqq_heFA@mail.gmail.com>
 <20160615165618.GF32588@pd.tnic>
 <CAJvTdKnDUDXwmj_Yy=Z-ScugHX_2sHtijk7WESWc26rNqPzGpQ@mail.gmail.com>
 <20160615173926.GD30309@pd.tnic>
 <CAJvTdK=pqSGw6atZn-giqxg4nd-DLTdf_wEhiC3VWGtDYLnUjg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:41408 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751884AbcFORwh (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 15 Jun 2016 13:52:37 -0400
Content-Disposition: inline
In-Reply-To: <CAJvTdK=pqSGw6atZn-giqxg4nd-DLTdf_wEhiC3VWGtDYLnUjg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Thomas Renninger <trenn@suse.com>, Kan Liang <kan.liang@intel.com>, "Peter Zijlstra (Intel)" <peterz@infradead.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>, Linux PM list <linux-pm@vger.kernel.org>

On Wed, Jun 15, 2016 at 01:42:41PM -0400, Len Brown wrote:
> Yes.  Enterprise customers use old kernels.  They need
> at least a snapshot of the utility that works w/o the API update.

Enterprise customers get the proper tool versions too. At least we -
SUSE - make sure that is the case.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
