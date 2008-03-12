From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH -mm] kexec jump -v9
Date: Wed, 12 Mar 2008 09:57:14 +0100
Message-ID: <20080312085714.GB3993__25200.1205728904$1205312408$gmane$org@ucw.cz>
References: <1204773188.4707.109.camel@caritas-dev.intel.com>
	<20080311211004.GA30164@redhat.com>
	<20080311232415.GA26320@elf.ucw.cz>
	<200803120049.06491.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200803120049.06491.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Vivek Goyal <vgoyal@redhat.com>
List-Id: linux-pm@vger.kernel.org

Hi!

> > > > The features of this patch can be used for as follow:
> > > > 
> > > > - A simple hibernation implementation without ACPI support. You can
> > > >   kexec a hibernating kernel, save the memory image of original system
> > > >   and shutdown the system. When resuming, you restore the memory image
> > > >   of original system via ordinary kexec load then jump back.
> > > > 
> > > 
> > > The main usage of this functionality is for hibernation. I am not sure
> > > what has been the conclusion of previous discussions.
> > > 
> > > Rafael/Pavel, does the approach of doing hibernation using a separate
> > > kernel holds promise?
> > 
> > Its certainly "more traditional" method of doing hibernation than
> > tricks swsusp currently plays.
> 
> What exactly are you referring to?

Well, traditionaly it is 'A saves B to disk' (like bootloader saves
kernel&userspace). In swsusp we have 'kernel saves itself'... which
works, too, but is pretty different design.

> > Now, I guess they are some difficulties, like ACPI integration, and
> > some basic drawbacks, like few seconds needed to boot second kernel
> > during suspend.
> > 
> > ...OTOH this is probably only chance to eliminate freezer from
> > swsusp...
> 
> Some facts:
> 
> * There's no reason to think that we can't use this same mechanism for
>   hibernation (the only difficulty seems to be the handling of devices used for
>   saving the image).

Ok, at least kexec makes handling of suspend device easier.

> Moreover, if this had been the _only_ argument for the $subject functionality,
> I'd have been against it.

Fortunately its not the only one :-).

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
