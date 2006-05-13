From: Pavel Machek <pavel@suse.cz>
Subject: Re: [PATCH/rfc] schedule /sys/device/.../power for
	removal
Date: Sat, 13 May 2006 22:43:22 +0200
Message-ID: <20060513204322.GB585@elf.ucw.cz>
References: <20060512100544.GA29010@elf.ucw.cz>
	<20060512031151.76a9d226.akpm@osdl.org>
	<20060512101916.GC28232@elf.ucw.cz>
	<20060512032702.3591289f.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============73162592609258881=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060512032702.3591289f.akpm@osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Andrew Morton <akpm@osdl.org>
Cc: linux-pm@lists.osdl.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

--===============73162592609258881==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> > > > index 421bcff..dfcfc47 100644
> > > > --- a/Documentation/feature-removal-schedule.txt
> > > > +++ b/Documentation/feature-removal-schedule.txt
> > > > @@ -6,6 +6,16 @@ be removed from this file.
> > > >  
> > > >  ---------------------------
> > > >  
> > > > +What:	/sys/device/.../power
> > > > +When:	July 2007
> > > > +Files:	
> > > > +Why:	Because it takes integers, and different userland applications
> > > > +	expect different numbers to mean different things.
> > > > +	(Pcmcia expect 2 for off, some other code expects 3 for off).
> > > > +Who:	Pavel Machek <pavel@suse.cz>
> > > > +
> > > > +---------------------------
> > > 
> > > What will be impacted by this?
> > 
> > Some obscure place PCMCIA utils, IIRC. There was one more user, but I
> > do not remember who it was. Plus there may be few people doing echo
> > manually.
> 
> What will it be replaced with, and how will we communicate the need to
> migrate to the various application developers?  We can't just rip it out
> next year and point at some obscure entry in a kernel file and say "but we
> told you".

Ok, we do not have replacement ready, yet. Would it be feasible to
include warning now so that people are warned as early as possible,
while we are working on replacement? Ok, maybe not...
								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

--===============73162592609258881==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============73162592609258881==--
