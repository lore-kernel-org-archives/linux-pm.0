From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH] swsusp: support creating bigger images
Date: Tue, 25 Apr 2006 12:31:56 +0200
Message-ID: <200604251231.57577.rjw@sisk.pl>
References: <200604242355.08111.rjw@sisk.pl> <200604251026.53613.rjw@sisk.pl>
	<20060425100408.GF4789@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060425100408.GF4789@elf.ucw.cz>
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

On Tuesday 25 April 2006 12:04, Pavel Machek wrote:
> > > Okay, so it can be done, and patch does not look too bad. It still
> > > scares me. Is 800MB image more responsive than 500MB after resume?
> > 
> > Yes, it is, slightly, but I think 800 meg images are impractical for
> > performance reasons (like IMO everything above 500 meg with the current
> > hardware).  However this means we can save 80% of RAM with the patch
> > and that should be 400 meg instead of 250 on a 500 meg machine, or
> > 200 meg instead of 125 on a 250 meg machine.
> 
> Could we get few people trying it on such small machines to see if it
> is really that noticeable?

OK, I'll try to run some tests on a machine with smaller RAM (and slower CPU).

> > > Is benefit worth it?
> > 
> > Well, that depends.  I think for boxes with 1 GB of RAM or more it's just
> > unnecessary (as of today, but this may change if faster disks are available).
> > On boxes with 512 MB of RAM or less it may change a lot as far as the
> > responsiveness after resume is concerned.
> > 
> > Anyway do you think it may go into -mm (unless Andrew shoots it down,
> > that is ;-))?
> 
> I'd really like to hear that it helps someone before going to
> -mm. It looks clean enough but still it is 300 lines... 

Oh, it's not that bad.  Adds ~240 lines and removes 75. :-)

Greetings,
Rafael


> 
> 									Pavel

-- 
Beer is proof that God loves us and wants us to be happy - Benjamin Franklin
