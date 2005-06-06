From: Pavel Machek <pavel@suse.cz>
Subject: Re: Re: swsusp: Not enough free pages
Date: Mon, 6 Jun 2005 23:58:15 +0200
Message-ID: <20050606215815.GO2230@elf.ucw.cz>
References: <3ACA40606221794F80A5670F0AF15F84041AC1A8@pdsmsx403>
	<200506061902.34304.rjw@sisk.pl> <20050606171417.GB2230@elf.ucw.cz>
	<200506062346.09503.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============46108770243008212=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200506062346.09503.rjw@sisk.pl>
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

--===============46108770243008212==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> > No, I see it on i386, too. Try patch below; if it frees some after
> > first pass, you have that problem, too.
> 
> I've run it once and the result is this:
> 
> Freeing memory... done (75876 pages freed)
> Freeing memory... done (1536 pages freed)
> Freeing memory... done (0 pages freed)
> Freeing memory... done (1792 pages freed)
> Freeing memory... done (0 pages freed)
> 
> It does free some pages after the first pass, but this is only a small fraction
> of all pages freed.  I wouldn't call it a bad result ...

Well, it still did not free all memory it should have freed, and you
were lucky. Apparently for some people it does not that well (and that
includes me, I see 0 in first pass quite often).
								Pavel

--===============46108770243008212==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============46108770243008212==--
