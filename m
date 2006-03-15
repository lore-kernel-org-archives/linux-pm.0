From: Pavel Machek <pavel@suse.cz>
Subject: Re: [Suspend-devel] suspend-to-both (less ugly version)
Date: Wed, 15 Mar 2006 22:46:49 +0100
Message-ID: <20060315214649.GM2474@elf.ucw.cz>
References: <20060315090627.GA2201@elf.ucw.cz> <200603152222.56685.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============12542032785996748=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200603152222.56685.rjw@sisk.pl>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: suspend-devel@lists.sourceforge.net, Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

--===============12542032785996748==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> > Index: suspend.c
> > ===================================================================
> > RCS file: /cvsroot/suspend/suspend/suspend.c,v
> > retrieving revision 1.22
> > diff -u -u -r1.22 suspend.c
> > --- suspend.c	12 Mar 2006 16:17:19 -0000	1.22
> > +++ suspend.c	15 Mar 2006 09:04:41 -0000
> > @@ -53,6 +53,7 @@
> >  #define encrypt 0
> >  #define key_name NULL
> >  #endif
> > +static int s2ram = 1;
> 
> I assume this will be an option in the final version? ;-)

Yes :-).
								Pavel

-- 
219: * but WITHOUT ANY WARRANTY; without even the implied warranty of

--===============12542032785996748==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============12542032785996748==--
