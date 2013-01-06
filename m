From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH/RFC 0/1] Delete legacy power trace API
Date: Sun, 06 Jan 2013 17:13:56 -0500
Message-ID: <1357510436.10284.69.camel@gandalf.local.home>
References: <1357350544-32704-1-git-send-email-paul.gortmaker@windriver.com>
	 <5190666.Mu6UtpjCCL@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:20260 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753139Ab3AFWN7 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 6 Jan 2013 17:13:59 -0500
In-Reply-To: <5190666.Mu6UtpjCCL@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>, linux-pm@vger.kernel.org, Arjan van de Ven <arjan@linux.intel.com>, Frederic Weisbecker <fweisbec@gmail.com>, linux-kernel@vger.kernel.org

On Sat, 2013-01-05 at 23:10 +0100, Rafael J. Wysocki wrote:
> On Friday, January 04, 2013 08:49:03 PM Paul Gortmaker wrote:
> > The actual deletion is mind-numbingly simple; and if you go by the
> > comments in the code, it is well overdue.  However, in discussions
> > with Frederic, he suggested to me that those comments might have
> > been overly optimistic, and that there may still be people out
> > there who are still unknowingly using this dead API.
> > 
> > So, that is the crux of the RFC component -- to check whether the
> > comments saying "delete by v3.1" can be taken at face value, or
> > whether they were overly optimistic, and hence this stuff is still
> > actively used even though it is overdue for deletion.
> 
> Do you want me or the tracing maintainers to handle this?
> 

You can take it. If you want you can add:

Acked-by: Steven Rostedt <rostedt@goodmis.org>

-- Steve


