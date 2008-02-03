From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: wakeup code translated to .c
Date: Sun, 3 Feb 2008 19:49:31 +0100
Message-ID: <20080203184931.GA2648@uranus.ravnborg.org>
References: <20080130120111.GB22820@elf.ucw.cz> <200802031857.02422.rjw@sisk.pl> <20080203181648.GA1629@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752963AbYBCStg@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20080203181648.GA1629@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, kernel list <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.osdl.org>, "H. Peter Anvin" <hpa@zytor.com>
List-Id: linux-pm@vger.kernel.org

On Sun, Feb 03, 2008 at 07:16:48PM +0100, Pavel Machek wrote:
> Hi!
> 
> > > This version works on 32-bit, and builds on 64-bit (but I'm pretty
> > > sure it does not work. 32-bit code probably needs to go into rm/....)
> > > 
> > 
> > Do you have an updated version or is this the latest one?
> 
> I'm glad you ask ;-). Here's reasonably-recent version (I have
> slightly cleaner one, but it got obscured by 2.6.24-git merge), I
> eventually got it to work on 64-bit, by reusing trampoline.S code.
> 
> 								Pavel
> Signed-off-by: Pavel Machek <pavel@suse.cz>

Hi PAvel.

Before you submit this for real we need me to take a deper
look into your Makefiles.
We do not want this duplication between boot and acpi.
And the way you deal with code sharing from boot/ is not
OK either.

But I do have a few other things pending before I have time
so please ping me in a week or two.

	Sam
