From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Re: swsusp issues
Date: Sat, 04 Jun 2005 09:32:11 +1000
Message-ID: <1117841532.31082.197.camel@gaston>
References: <1117764111.31082.119.camel@gaston>
	<20050603111541.GC3867@elf.ucw.cz> <1117839029.31082.180.camel@gaston>
	<1117841135.4766.89.camel@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============708279258463409=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <1117841135.4766.89.camel@localhost>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: ncunningham@cyclades.com
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

--===============708279258463409==
Content-Type: text/plain
Content-Transfer-Encoding: 7bit


> > We could provide an "example" default implementation that does only
> > swsusp that an arch can "drop in" if you want, but archs have to
> > implement the various "inline" callbacks anyway (save_processor_state &
> > friends).
> 
> How could I work with that in an implementation where the vast majority
> of the code is arch-independent? I guess I'll have to see what you come
> up with.

The arch independent code is called by the arch code, nothing new here.

I don't suggest arch re-implements swsusp_suspend() or
freeze_processes(). It's either that or having all the new callbacks
plus a major blowup of the crap in disk.c to fit in main.c 

Ben.




--===============708279258463409==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============708279258463409==--
