From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH] swsusp: support creating bigger images
Date: Thu, 27 Apr 2006 17:27:38 +0200
Message-ID: <200604271727.39194.rjw@sisk.pl>
References: <200604242355.08111.rjw@sisk.pl> <20060425100408.GF4789@elf.ucw.cz>
	<200604251231.57577.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200604251231.57577.rjw@sisk.pl>
Content-Disposition: inline
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Pavel Machek <pavel@suse.cz>
Cc: Nigel Cunningham <nigel@suspend2.net>, Linux PM <linux-pm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi,

On Tuesday 25 April 2006 12:31, Rafael J. Wysocki wrote:
> On Tuesday 25 April 2006 12:04, Pavel Machek wrote:
> > > > Okay, so it can be done, and patch does not look too bad. It still
> > > > scares me. Is 800MB image more responsive than 500MB after resume?
> > > 
> > > Yes, it is, slightly, but I think 800 meg images are impractical for
> > > performance reasons (like IMO everything above 500 meg with the current
> > > hardware).  However this means we can save 80% of RAM with the patch
> > > and that should be 400 meg instead of 250 on a 500 meg machine, or
> > > 200 meg instead of 125 on a 250 meg machine.
> > 
> > Could we get few people trying it on such small machines to see if it
> > is really that noticeable?
> 
> OK, I'll try to run some tests on a machine with smaller RAM (and slower CPU).

Done, although it was not so easy to find the box.  This was a PII 350MHz w/
256 MB of RAM.

I invented the following test:
- ran KDE with 4 desktops,
- ran Firefox, OpenOffice.org 1.1 (with a simple spreadsheet), and GIMP (with
2 pictures) each on its own desktop,
- ran the memory meter from the KDE's Info Center and two konsoles
on the remaining desktop - one konsole with a kernel compilation and the
other with a root session used for suspending the box (the built-in swsusp
was used),
so the box's RAM was almost fully occupied with ~30% taken by the page cache.

Then I suspended the box and measured the time from the start of resume
(ie. leaving GRUB) to the point at which I had all of the application windows
fully rendered on their respective desktops (I always switched the desktops
in the same order, starting from the memory meter's one, through the OOo's
and Firefox's, finishing on the GIMP's one and I always switched the
desktop as soon as the window(s) on it were fully rendered).

I ran it a couple of times on the 2.6.17-rc1-mm2 kernel with and without
the patch and the results (on the average) are the following:

(a) 25-28s with the patch
(b) 30-33s without it

Moreover, with the patch the image size was about 49000 of pages (only
~7000 - 12000 pages had to be copied during suspend) and without the patch
it was about 30000 of pages, so with the patch much smaller number of
pages was in the swap after resume.

Greetings,
Rafael
