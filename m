From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH] ACPI: small formatting fixes
Date: Mon, 12 Dec 2016 14:32:12 -0800
Message-ID: <1481581932.29291.6.camel@perches.com>
References: <20161212072541.28435-1-nick.desaulniers@gmail.com>
         <20161212085620.GA738@amd> <20161212175654.ydc7rx3edqoacnp7@lostoracle.net>
         <1481567955.1764.28.camel@perches.com> <20161212222216.GA18201@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtprelay0097.hostedemail.com ([216.40.44.97]:55889 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932282AbcLLWcQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Dec 2016 17:32:16 -0500
In-Reply-To: <20161212222216.GA18201@amd>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Nick Desaulniers <nick.desaulniers@gmail.com>, rjw@rjwysocki.net, len.brown@intel.com, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, 2016-12-12 at 23:22 +0100, Pavel Machek wrote:
> On Mon 2016-12-12 10:39:15, Joe Perches wrote:
> > On Mon, 2016-12-12 at 09:56 -0800, Nick Desaulniers wrote:
> > > A quick cleanup that passes scripts/checkpatch.pl -f <file>.
[]
> > > diff --git a/arch/x86/kernel/acpi/cstate.c b/arch/x86/kernel/acpi/cstate.c
[]
> > It's generally better not to convert
> > these printk(KERN_DEBUG uses.
> > 
> > There are behavior differences between
> > 	printk(KERN_DEBUG ...);
> > and
> > 	pr_debug(...);
> > 
> > The first will always be emitted as long
> > as the console level is appropriate.
> > 
> > The second depends on a #define DEBUG
> > before it gets emitted or a kernel 
> > with CONFIG_DYNAMIC_DEBUG enabled and
> > this entry specifically enabled in the
> > control file.
> 
> Hmm. Perhaps pr_debug should be called pr_c_debug() or something? This
> is rather nice trap.

Yeah, I've suggested veriants like pr_always_debug (from 2009)
http://lkml.iu.edu/hypermail/linux/kernel/0910.0/00399.html

