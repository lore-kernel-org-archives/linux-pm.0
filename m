From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: suspend to ram problem
Date: Thu, 7 Feb 2008 19:39:18 +0100
Message-ID: <200802071939.19240.rjw__42072.9692363695$1202409804$gmane$org@sisk.pl>
References: <47A5C399.7010405@free.fr> <47A8EB02.90502@free.fr>
	<20080207092321.GC1816@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080207092321.GC1816@elf.ucw.cz>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-acpi@vger.kernel.org, pm list <linux-pm@lists.linux-foundation.org>, matthieu castet <castet.matthieu@free.fr>
List-Id: linux-pm@vger.kernel.org

On Thursday, 7 of February 2008, Pavel Machek wrote:
> Hi!

Hi,

> >>>> Hmm, maybe I know where problem could be. Try
> >>>>
> >>>>         movl     $(wakeup_stack - wakeup_code), %esp              # 
> >>>> Private stack is needed for ASUS bo\
> >>>>
> >>>> instead of existing stack setup. That helped on one of my test-boxes
> >>> Thanks, I will try that.
> >>> Because clearing the flags imply pop/push in the stack it could be the 
> >>> problem
> >> That doesn't help : it still crash in pushl $0.
> >>
> > All stack stuff in wakeup_code crash for me.
> > I tried to change the stack position, make sure upper bit of %esp are 
> > clear, ... nothing work.
> > What's are strange is that according to my x86 manual, in real mode the 
> > failure can only happen if the stack wrap which is not the case here.
> > Any x86 guru advice ?
> 
> Could you try the .c wakeup? I changed it a bit, perhaps that's enough.
> 
> > If I remove stack access (remove clearing flag stuff, not call to video 
> > stuff) the resume works.
> 
> Actually, I see a possible problem:
> 
> _start:
>         cli
>         cld
> 
>         /* Set up segments */
>         movw    %cs,%ax
>         movw    %ax,%ds
>         movw    %ax,%es
>         movw    %ax,%ss
> 
>         movl    $wakeup_stack_end, %esp
> 
>         /* Clear the EFLAGS */
>         pushl   $0
>         popfl
> 
> ...if someone calls start as 0x1234:0, we are okay. But if some broken
> bios calls us as 0x1:0x234, we've got a problem.

Well, in that case the signature/end_signature tests below would trigger, no?

Rafael
