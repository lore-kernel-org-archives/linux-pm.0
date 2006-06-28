From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: x86_64 restore_image declaration needs
	asmlinkage?
Date: Wed, 28 Jun 2006 14:10:44 +0200
Message-ID: <200606281410.45008.rjw@sisk.pl>
References: <200606282048.38746.ncunningham@linuxmail.org>
	<200606281353.15252.rjw@sisk.pl>
	<200606282200.36268.ncunningham@linuxmail.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <suspend2-devel-bounces@lists.suspend2.net>
In-Reply-To: <200606282200.36268.ncunningham@linuxmail.org>
Content-Disposition: inline
List-Unsubscribe: <http://lists.suspend2.net/mailman/listinfo/suspend2-devel>,
	<mailto:suspend2-devel-request@lists.suspend2.net?subject=unsubscribe>
List-Archive: <http://lists.suspend2.net/lurker/list/suspend2-devel.html>
List-Post: <mailto:suspend2-devel@lists.suspend2.net>
List-Help: <mailto:suspend2-devel-request@lists.suspend2.net?subject=help>
List-Subscribe: <http://lists.suspend2.net/mailman/listinfo/suspend2-devel>,
	<mailto:suspend2-devel-request@lists.suspend2.net?subject=subscribe>
Sender: suspend2-devel-bounces@lists.suspend2.net
Errors-To: suspend2-devel-bounces@lists.suspend2.net
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, suspend2-devel@lists.suspend2.net
List-Id: linux-pm@vger.kernel.org

On Wednesday 28 June 2006 14:00, Nigel Cunningham wrote:
> Hi.
> 
> On Wednesday 28 June 2006 21:53, Rafael J. Wysocki wrote:
> > Hi,
> >
> > On Wednesday 28 June 2006 12:48, Nigel Cunningham wrote:
> > > I received a report of problems with CONFIG_REGPARM and suspending, that
> > > led me to recheck asm calls and declarations. Not being a guru on these
> > > things, I want to ask advice from those who know more.
> > >
> > > Along the way I noticed that current git has:
> > >
> > > extern asmlinkage int swsusp_arch_suspend(void);
> > > extern asmlinkage int swsusp_arch_resume(void);
> > >
> > > This is right for x86, but for x86_64, we actually call a C routine in
> > > arch/x86_64/kernel/suspend.c, which calls restore_image in
> > > arch/x86_64/kernel/suspend_asm.S. Restore image is declared in suspend.c
> > > as
> > >
> > > extern int restore_image(void);
> > >
> > > should it be:
> > >
> > > extern asmlinkage int restore_image(void);
> > >
> > > Having swsusp_arch_resume declared as asmlinkage doesn't matter, does it?
> >
> > No, it doesn't.  It would have mattered on i386 if the function had taken
> > any arguments.  AFAICT, on x86_64 it desn't matter at all.
> 
> Right. But what about restore_image lacking the asmlinkage? I'm also wondering 
> if that does matter.

I think asmlinkage would not matter here too (the function is x86_64-specific).

Greetings,
Rafael
