From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [linux-pm] Re: [rft] s2ram wakeup moves to .c, could fix few machines
Date: Fri, 8 Feb 2008 22:56:08 +0100
Message-ID: <200802082256.09081.rjw@sisk.pl>
References: <20080208210004.GA12923@elf.ucw.cz> <47ACC942.1020308@zytor.com> <20080208213101.GE12923@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758891AbYBHV6i@vger.kernel.org>
In-Reply-To: <20080208213101.GE12923@elf.ucw.cz>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Alan Stern <stern@rowland.harvard.edu>, Linux-pm mailing list <linux-pm@lists.osdl.org>, kernel list <linux-kernel@vger.kernel.org>, Sam Ravnborg <sam@ravnborg.org>
List-Id: linux-pm@vger.kernel.org

On Friday, 8 of February 2008, Pavel Machek wrote:
> On Fri 2008-02-08 13:27:30, H. Peter Anvin wrote:
> > Pavel Machek wrote:
> >>
> >> See arch/x86/kernel/acpi/realmode/wakeup.S (the version that was sent
> >> to the list). No problem there, but table stored at nonzero
> >> offset. Short jump at the beggining of table would fix it (ugly).
> >>
> >
> > Ugly, but it's the standard way to deal.  We have it in the bzImage format, 
> > too.
> 
> I'd prefer to keep it as it is, there are no problems.
> 
> This way, we can put debugging instructions at the first byte of
> wakeup code, which is somehow important.
> 
> Plus, with right #defines, it should be clean enough.

Well, I don't know how to evaluate #defines in *.ld files ...

Rafael
