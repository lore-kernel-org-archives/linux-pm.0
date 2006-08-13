From: Pavel Machek <pavel@suse.cz>
Subject: Re: [RFC][PATCH -mm 0/5] swsusp: Fix handling of highmem
Date: Mon, 14 Aug 2006 00:34:49 +0200
Message-ID: <20060813223449.GG6231@elf.ucw.cz>
References: <200608091152.49094.rjw@sisk.pl> <200608092047.13493.ncunningham@linuxmail.org> <20060809113822.GQ3308@elf.ucw.cz> <200608092152.11122.ncunningham@linuxmail.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751693AbWHMWfJ@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200608092152.11122.ncunningham@linuxmail.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@osdl.org>
List-Id: linux-pm@vger.kernel.org

On Wed 2006-08-09 21:52:10, Nigel Cunningham wrote:
> On Wednesday 09 August 2006 21:38, Pavel Machek wrote:
> > Hi!
> >
> > > > Comments welcome.
> > >
> > > Thanks for the reminder. I'd forgotten half the reason why I didn't want
> > > to make Suspend2 into incremental patches! You're a brave man!
> >
> > Why does this serve as a reminder? No, it is not easy to merge big
> > patches to mainline. But it is actually a feature.
> 
> It serves as a reminder because it shows (just the description, I mean), how 
> inter-related all the changes that are needed are.
> 
> I don't get the "it is actually a feature" bit.

Well, it is good that submitting patches is hard ... because kernel
ends cleaner that way. 
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
