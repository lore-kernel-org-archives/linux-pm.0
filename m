From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH] x86/power/64: Use char arrays for asm function names
Date: Wed, 10 May 2017 07:49:22 +0200
Message-ID: <20170510054922.y6pds2gexwt6fked@gmail.com>
References: <20170509210051.GA36504@beast>
 <4065405.RHJSHBFYFE@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:33399 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750946AbdEJFt1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 10 May 2017 01:49:27 -0400
Content-Disposition: inline
In-Reply-To: <4065405.RHJSHBFYFE@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, linux-pm@vger.kernel.org, Daniel Micay <danielmicay@gmail.com>


* Rafael J. Wysocki <rjw@rjwysocki.net> wrote:

> On Tuesday, May 09, 2017 02:00:51 PM Kees Cook wrote:
> > This switches the hibernate_64.S function names into character arrays
> > to match other areas of the kernel where this is done (e.g., linker
> > scripts). Specifically this fixes a compile-time error noticed by the
> > future CONFIG_FORTIFY_SOURCE routines that complained about PAGE_SIZE
> > being copied out of the "single byte" core_restore_code variable.
> > 
> > Additionally drops the "acpi_save_state_mem" exern which does not
> > appear to be used anywhere else in the kernel.
> > 
> > Cc: Daniel Micay <danielmicay@gmail.com>
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> 
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Or I can queue this up if that's preferred.

LGTM too!

Acked-by: Ingo Molnar <mingo@kernel.org>

Thanks,

	Ingo
