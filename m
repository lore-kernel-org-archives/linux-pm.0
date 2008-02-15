From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [patch] move wakeup code to .c
Date: Fri, 15 Feb 2008 15:56:04 +0100
Message-ID: <200802151556.05521.rjw@sisk.pl>
References: <20080210222723.GA1865@elf.ucw.cz> <200802150135.07127.lenb@kernel.org> <20080215095544.GA4667@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S934545AbYBOO6u@vger.kernel.org>
In-Reply-To: <20080215095544.GA4667@ucw.cz>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Len Brown <lenb@kernel.org>, kernel list <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.osdl.org>, hpa@zytor.com, sam@ravnborg.org
List-Id: linux-pm@vger.kernel.org

On Friday, 15 of February 2008, Pavel Machek wrote:
> Hi!
> 
> > scripts/checkpatch.pl
> > ERROR: do not initialise externals to 0 or NULL
> > #113: FILE: arch/x86/boot/video-mode.c:29:
> > +int do_restore = 0;    /* Screen contents changed during mode flip */
> 
> We were doing file move with minimal changes.
> 
> > ERROR: need a space before the open parenthesis '('
> > #710: FILE: arch/x86/kernel/acpi/realmode/wakemain.c:70:
> > +               while(1);
> 
> Bogus warning.
> 
> I'll fix al but this one, but could we do it as a followup patch? I'm
> currently at holidays, moving .S code into .c is rather
> good/important, and it should get testing ASAP.

I'll move the definitions into a header file.

Thanks,
Rafael
