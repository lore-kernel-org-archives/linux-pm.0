From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 11/22] cpufreq: Replace strnicmp with strncasecmp
Date: Fri, 26 Sep 2014 01:53:12 +0200
Message-ID: <2042736.or0GtPEZK6@vostro.rjw.lan>
References: <1410900696-6481-1-git-send-email-linux@rasmusvillemoes.dk> <1410900696-6481-12-git-send-email-linux@rasmusvillemoes.dk> <CAKohpon9GjRb_Eimecss1aVXRCGJ+d=78ZFOOOfg8qCFyqumzw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:56014 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752991AbaIYXdW (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 25 Sep 2014 19:33:22 -0400
In-Reply-To: <CAKohpon9GjRb_Eimecss1aVXRCGJ+d=78ZFOOOfg8qCFyqumzw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>, Andrew Morton <akpm@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On Tuesday, September 16, 2014 02:22:49 PM Viresh Kumar wrote:
> On 16 September 2014 13:51, Rasmus Villemoes <linux@rasmusvillemoes.dk> wrote:
> > The kernel used to contain two functions for length-delimited,
> > case-insensitive string comparison, strnicmp with correct semantics
> > and a slightly buggy strncasecmp. The latter is the POSIX name, so
> > strnicmp was renamed to strncasecmp, and strnicmp made into a wrapper
> > for the new strncasecmp to avoid breaking existing users.
> >
> > To allow the compat wrapper strnicmp to be removed at some point in
> > the future, and to avoid the extra indirection cost, do
> > s/strnicmp/strncasecmp/g.
> >
> > Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> > Cc: Viresh Kumar <viresh.kumar@linaro.org>
> > Cc: linux-pm@vger.kernel.org
> > Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> > ---
> >  drivers/cpufreq/cpufreq.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> Not really sure about the implementation of these routines but the
> changes look fine.
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Queued up for 3.18, thanks!

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
