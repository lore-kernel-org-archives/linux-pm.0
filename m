From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: PROBLEM: Resume form hibernate broken by setting NX on gap
Date: Sat, 11 Jun 2016 00:33:31 +0200
Message-ID: <2733358.ov5sOzsSmy@vostro.rjw.lan>
References: <573DF82D.50006@deltatee.com> <6452365.7hjtWaBW7Y@vostro.rjw.lan> <575B3EF1.3060507@deltatee.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:59832 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752023AbcFJW33 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 10 Jun 2016 18:29:29 -0400
In-Reply-To: <575B3EF1.3060507@deltatee.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Logan Gunthorpe <logang@deltatee.com>
Cc: Kees Cook <keescook@chromium.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Stephen Smalley <sds@tycho.nsa.gov>, Ingo Molnar <mingo@kernel.org>, Ingo Molnar <mingo@redhat.com>, the arch/x86 maintainers <x86@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>, Denys Vlasenko <dvlasenk@redhat.com>, Brian Gerst <brgerst@gmail.com>

On Friday, June 10, 2016 04:28:01 PM Logan Gunthorpe wrote:
> 
> On 10/06/16 04:29 PM, Rafael J. Wysocki wrote:
> > OK, I have a theory, but I need a bit of help.
> > 
> > This may be a dumb question, but I don't quite remember the answer readily.
> > 
> > Given a physical address, how do I get the corresponding virtual one under
> > the kernel identity mapping?
> 
> Is that not just 'phys_to_virt(x)'??

Ah that.  Thanks!

Rafael

