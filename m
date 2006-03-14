From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Re: standby to disk transition
Date: Tue, 14 Mar 2006 10:50:39 +0100
Message-ID: <20060314095039.GB10870@elf.ucw.cz>
References: <E1FIctI-0000jE-00@porton.narod.ru>
	<20060313183318.GB26234@redhat.com>
	<20060313212420.GG10348@elf.ucw.cz>
	<200603141021.23773.nigel@suspend2.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============035275214920699849=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200603141021.23773.nigel@suspend2.net>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Nigel Cunningham <nigel@suspend2.net>
Cc: linux-pm@lists.osdl.org, "Victor Porton, , , " <porton@ex-code.com>, linux-pm@osdl.org
List-Id: linux-pm@vger.kernel.org

--===============035275214920699849==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

> > > if suspend-to-disk is fast enough, you could just *always* write
> > > to disk, even if we're doing S3.  If power runs out, you then have a
> > > valid resume image on-disk.  iirc, this is what Windows does.
> >
> > Yep, I call that suspend-to-both. It is planned, but not really
> > trivial, and I'm a little busy. If someone wants to help....
> 
> Actually it is really easy to do Pavel, so long as your code already has the 
> error handling that allows it to back out nicely. Just enter S3 at the point 
> where you'd otherwise power down, then on resume act like an error occured at 
> the last moment and back out.

Entering S3 is not trivial operation, that's the problem. vbetool save
is needed on some machines (needs filesystem), for example. Yep, it
should not be hard.

Minor surgery will be needed to allow suspend-to-ram on already frozen
system...

								Pavel
-- 
57:        MD5CryptoServiceProvider MD5 = new MD5CryptoServiceProvider();

--===============035275214920699849==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============035275214920699849==--
