From: Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: Re: [PATCH REGRESSION FIX] x86 idle: restore mwait_idle()
Date: Sun, 15 Mar 2015 05:53:11 +0100
Message-ID: <1426395191.2990.16.camel@gmail.com>
References: <1ae2a8af42281d6b9888ac8c76bab7bd2f431d44.1389763084.git.len.brown@intel.com>
	 <345254a551eb5a6a866e048d7ab570fd2193aca4.1389763084.git.len.brown@intel.com>
	 <52D8567A.8090308@mit.edu> <1389932442.5449.4.camel@marge.simpson.net>
	 <1390037633.5676.3.camel@marge.simpson.net>
	 <1390061684.5566.4.camel@marge.simpson.net>
	 <CAL3-7MoEXfW0LTdQi3pakL+OaiKcVHPzPng142KKjCX66mNXDg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-we0-f169.google.com ([74.125.82.169]:33348 "EHLO
	mail-we0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750711AbbCOExP (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 15 Mar 2015 00:53:15 -0400
In-Reply-To: <CAL3-7MoEXfW0LTdQi3pakL+OaiKcVHPzPng142KKjCX66mNXDg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ian Malone <ibmalone@gmail.com>
Cc: Andy Lutomirski <luto@amacapital.net>, Len Brown <lenb@kernel.org>, x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>, Josh Boyer <jwboyer@redhat.com>, stable@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>

On Sat, 2015-03-14 at 23:44 +0000, Ian Malone wrote:
> On 18 January 2014 at 16:14, Mike Galbraith <bitbucket@online.de> wrote:
> > On Sat, 2014-01-18 at 10:33 +0100, Mike Galbraith wrote:
> >> On Fri, 2014-01-17 at 05:20 +0100, Mike Galbraith wrote:
> 
> > Signed-off-by: Mike Galbraith <bitbucket@online.de>
> > Cc: <stable@vger.kernel.org> # 3.10+
> > ---
> >  arch/x86/kernel/process.c |    9 ++++++---
> >  1 file changed, 6 insertions(+), 3 deletions(-)
> >
> > --- a/arch/x86/kernel/process.c
> > +++ b/arch/x86/kernel/process.c
> > @@ -427,18 +427,21 @@ static int prefer_mwait_c1_over_halt(con
> 
> Hi, this series of patches never seem to have made it as far as the
> mainline kernel, anyone know what needs to happen next?

My plan is to keep on carrying it locally for as long as I run new
kernels on crusty ole core2 boxen, then stop caring about them entirely
like the rest of the planet :)

	-Mike

