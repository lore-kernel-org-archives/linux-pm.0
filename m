From: Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH 01/10] x86: assembly, ENTRY for fn, GLOBAL for data
Date: Fri, 17 Feb 2017 12:06:12 +0100
Message-ID: <5bf24311-a812-7c2d-9057-62dcd8d82e42@suse.com>
References: <20170217104757.28588-1-jslaby@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:46553 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754532AbdBQLGR (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 17 Feb 2017 06:06:17 -0500
In-Reply-To: <20170217104757.28588-1-jslaby@suse.cz>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jiri Slaby <jslaby@suse.cz>, mingo@redhat.com
Cc: tglx@linutronix.de, hpa@zytor.com, x86@kernel.org, jpoimboe@redhat.com, linux-kernel@vger.kernel.org, Boris Ostrovsky <boris.ostrovsky@oracle.com>, xen-devel@lists.xenproject.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org

On 17/02/17 11:47, Jiri Slaby wrote:
> This is a start of series to unify use of ENTRY, ENDPROC, GLOBAL, END,
> and other macros across x86. When we have all this sorted out, this will
> help to inject DWARF unwinding info by objtool later.
> 
> So, let us use the macros this way:
> * ENTRY -- start of a global function
> * ENDPROC -- end of a local/global function
> * GLOBAL -- start of a globally visible data symbol
> * END -- end of local/global data symbol
> 
> The goal is forcing ENTRY to emit .cfi_startproc and ENDPROC to emit
> .cfi_endproc.
> 
> This particular patch makes proper use of GLOBAL on data and ENTRY on a
> function which was not the case on 4 locations.
> 
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: <x86@kernel.org>
> Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> Cc: Juergen Gross <jgross@suse.com>
> Cc: <xen-devel@lists.xenproject.org>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Len Brown <len.brown@intel.com>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: <linux-pm@vger.kernel.org>
> ---
>  arch/x86/kernel/acpi/wakeup_64.S | 14 +++++++-------
>  arch/x86/kernel/head_64.S        |  2 +-
>  arch/x86/kernel/mcount_64.S      |  2 +-
>  arch/x86/xen/xen-head.S          |  2 +-
>  4 files changed, 10 insertions(+), 10 deletions(-)

Xen parts:

Reviewed-by: Juergen Gross <jgross@suse.com>


Juergen
