From: Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH 02/10] x86: assembly, use ENDPROC for functions
Date: Fri, 17 Feb 2017 12:08:19 +0100
Message-ID: <5d296d92-12f4-8863-1f37-f8f75d836f6c@suse.com>
References: <20170217104757.28588-1-jslaby@suse.cz>
 <20170217104757.28588-2-jslaby@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:47574 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932505AbdBQLXw (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 17 Feb 2017 06:23:52 -0500
In-Reply-To: <20170217104757.28588-2-jslaby@suse.cz>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jiri Slaby <jslaby@suse.cz>, mingo@redhat.com
Cc: tglx@linutronix.de, hpa@zytor.com, x86@kernel.org, jpoimboe@redhat.com, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org, Boris Ostrovsky <boris.ostrovsky@oracle.com>, xen-devel@lists.xenproject.org

On 17/02/17 11:47, Jiri Slaby wrote:
> Somewhere END was used to end a function, elsewhere, nothing was used.
> So unify it and mark them all by ENDPROC.
> 
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: <x86@kernel.org>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: <linux-pm@vger.kernel.org>
> Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> Cc: Juergen Gross <jgross@suse.com>
> Cc: <xen-devel@lists.xenproject.org>
> ---
>  arch/x86/entry/entry_64.S            | 40 ++++++++++++++++++------------------
>  arch/x86/entry/entry_64_compat.S     |  4 ++--
>  arch/x86/kernel/mcount_64.S          | 10 +++++----
>  arch/x86/power/hibernate_asm_64.S    |  2 ++
>  arch/x86/realmode/rm/reboot.S        |  1 +
>  arch/x86/realmode/rm/trampoline_64.S |  4 ++++
>  arch/x86/realmode/rm/wakeup_asm.S    |  1 +
>  arch/x86/xen/xen-asm_64.S            |  2 ++
>  arch/x86/xen/xen-head.S              |  2 +-
>  arch/x86/xen/xen-pvh.S               |  2 +-
>  10 files changed, 40 insertions(+), 28 deletions(-)

Xen parts:

Reviewed-by: Juergen Gross <jgross@suse.com>


Juergen
