From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: suspend to ram problem
Date: Thu, 7 Feb 2008 00:03:04 +0100
Message-ID: <200802070003.05543.rjw__13625.0619696968$1202339314$gmane$org@sisk.pl>
References: <47A5C399.7010405@free.fr> <47AA3763.7000106@free.fr>
	<20080206224308.GA1630@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080206224308.GA1630@elf.ucw.cz>
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

On Wednesday, 6 of February 2008, Pavel Machek wrote:
> Hi!
> 
> >>>>>> instead of existing stack setup. That helped on one of my test-boxes
> >>>>> Thanks, I will try that.
> >>>>> Because clearing the flags imply pop/push in the stack it could be the 
> >>>>> problem
> >>>> That doesn't help : it still crash in pushl $0.
> >>>>
> >>> All stack stuff in wakeup_code crash for me.
> >>> I tried to change the stack position, make sure upper bit of %esp are 
> >>> clear, ... nothing work.
> >>> What's are strange is that according to my x86 manual, in real mode the 
> >>> failure can only happen if the stack wrap which is not the case here.
> >>> Any x86 guru advice ?
> >>>
> >>> If I remove stack access (remove clearing flag stuff, not call to video 
> >>> stuff) the resume works.
> >>
> >> Hm, can you place a "pushl %eax; popl %eax;" in place of the removed code and
> >> see if that breaks?
> > Yes that also break.

Interesting.

> Not sure what is going on...

Looks like ss goes bonkers or the 32-bit opcodes are invalid in real mode.

Matthieu, can you try "pushw %ax; popw %ax;", please?

Rafael
