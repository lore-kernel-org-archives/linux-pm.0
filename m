From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH -mm] kexec jump -v9
Date: Wed, 12 Mar 2008 00:24:15 +0100
Message-ID: <20080311232415.GA26320__42164.4570924856$1205277997$gmane$org@elf.ucw.cz>
References: <1204773188.4707.109.camel@caritas-dev.intel.com>
	<20080311211004.GA30164@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20080311211004.GA30164@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Vivek Goyal <vgoyal@redhat.com>
Cc: nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hi!

> > This is a minimal patch with only the essential features. All
> > additional features are split out and can be discussed later. I think
> > it may be easier to get consensus on this minimal patch.
> > 
> 
> Hi Huang,
> 
> This patchset is slowly getting better. True that first we need to come
> up with minimal infrastructure patch and then think of building more
> functionality on top of it.
> 
...
> > The features of this patch can be used for as follow:
> > 
> > - A simple hibernation implementation without ACPI support. You can
> >   kexec a hibernating kernel, save the memory image of original system
> >   and shutdown the system. When resuming, you restore the memory image
> >   of original system via ordinary kexec load then jump back.
> > 
> 
> The main usage of this functionality is for hibernation. I am not sure
> what has been the conclusion of previous discussions.
> 
> Rafael/Pavel, does the approach of doing hibernation using a separate
> kernel holds promise?

Its certainly "more traditional" method of doing hibernation than
tricks swsusp currently plays. Yes, I'd like these patches to go in,
being able to switch kernels seems like useful tool.

Now, I guess they are some difficulties, like ACPI integration, and
some basic drawbacks, like few seconds needed to boot second kernel
during suspend.

...OTOH this is probably only chance to eliminate freezer from
swsusp...

Yes, I'd like to see this to go ahead.

No, this does not make swsusp obsolete just yet.
								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
