From: Logan Gunthorpe <logang@deltatee.com>
Subject: Re: PROBLEM: Resume form hibernate broken by setting NX on gap
Date: Fri, 10 Jun 2016 16:28:01 -0600
Message-ID: <575B3EF1.3060507@deltatee.com>
References: <573DF82D.50006@deltatee.com>
 <CAGXu5jK15P5CAQd09NzG31YMPEKJGXbhXiYDQ2sRC=WBhAFTrA@mail.gmail.com>
 <34107887.ATgOLutrT1@vostro.rjw.lan> <6452365.7hjtWaBW7Y@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from ale.deltatee.com ([207.54.116.67]:55799 "EHLO ale.deltatee.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751724AbcFJW2R (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 10 Jun 2016 18:28:17 -0400
In-Reply-To: <6452365.7hjtWaBW7Y@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kees Cook <keescook@chromium.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Stephen Smalley <sds@tycho.nsa.gov>, Ingo Molnar <mingo@kernel.org>, Ingo Molnar <mingo@redhat.com>, the arch/x86 maintainers <x86@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>, Denys Vlasenko <dvlasenk@redhat.com>, Brian Gerst <brgerst@gmail.com>



On 10/06/16 04:29 PM, Rafael J. Wysocki wrote:
> OK, I have a theory, but I need a bit of help.
> 
> This may be a dumb question, but I don't quite remember the answer readily.
> 
> Given a physical address, how do I get the corresponding virtual one under
> the kernel identity mapping?

Is that not just 'phys_to_virt(x)'??

Logan
