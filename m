From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Re: swsusp: Not enough free pages
Date: Thu, 9 Jun 2005 00:03:07 +0200
Message-ID: <20050608220307.GA2614@elf.ucw.cz>
References: <3ACA40606221794F80A5670F0AF15F84041AC1A8@pdsmsx403>
	<200506081702.53349.rjw@sisk.pl>
	<20050608162728.GA3969@openzaurus.ucw.cz>
	<200506082342.14420.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============28240409279341749=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200506082342.14420.rjw@sisk.pl>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: ACPI devel <acpi-devel@lists.sourceforge.net>, linux-pm@lists.osdl.org, Linux Kernel List <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@zip.com.au>
List-Id: linux-pm@vger.kernel.org

--===============28240409279341749==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> > > This is the worst result from the second box:
> > > 
> > > Freeing memory...  done (54641 pages freed)
> > > Freeing memory...  done (0 pages freed)
> > > Freeing memory...  done (5120 pages freed)
> > > Freeing memory...  done (1952 pages freed)
> > > Freeing memory...  done (2304 pages freed)
> > > 
> > > Still, there are 5x more pages freed in the first pass (80% of RAM was
> > > empty anyway before suspend), and usually it is 10-20x more or so.
> > 
> > I have seen 0 freed on i386 machine with preempt -rc6-mm1, today...
> > Something is definitely wrong there.
> 
> Well, I have compiled the kernel with preempt and retested (on -rc6) but it
> doesn't want to get worse. :-)
> 
> The problem seems to be arch-dependent or at least configuration-dependent ... 
> 
> Hm, how much RAM is there in your box?

This was on 2GB box...
							Pavel

--===============28240409279341749==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============28240409279341749==--
