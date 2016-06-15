From: Len Brown <lenb@kernel.org>
Subject: Re: [RFC PATCH] x86: Move away from /dev/cpu/*/msr
Date: Wed, 15 Jun 2016 13:42:41 -0400
Message-ID: <CAJvTdK=pqSGw6atZn-giqxg4nd-DLTdf_wEhiC3VWGtDYLnUjg@mail.gmail.com>
References: <20160615100029.GB32588@pd.tnic> <CAJvTdKkoMPZTagM_wRSCwbb=NKfBAU8SNMPz2hZuPhPqq_heFA@mail.gmail.com>
 <20160615165618.GF32588@pd.tnic> <CAJvTdKnDUDXwmj_Yy=Z-ScugHX_2sHtijk7WESWc26rNqPzGpQ@mail.gmail.com>
 <20160615173926.GD30309@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qk0-f193.google.com ([209.85.220.193]:33380 "EHLO
	mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751884AbcFORmn (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 15 Jun 2016 13:42:43 -0400
In-Reply-To: <20160615173926.GD30309@pd.tnic>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: lkml <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Thomas Renninger <trenn@suse.com>, Kan Liang <kan.liang@intel.com>, "Peter Zijlstra (Intel)" <peterz@infradead.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>, Linux PM list <linux-pm@vger.kernel.org>

> Well, since the utility is part of tools/, it goes with the kernel
> version. Just like perf.
>
> Or are you dying to be able to use new tool on old kernels?

Yes.  Enterprise customers use old kernels.  They need
at least a snapshot of the utility that works w/o the API update.
-- 
Len Brown, Intel Open Source Technology Center
