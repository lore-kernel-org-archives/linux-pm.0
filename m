From: Jacek Kawa <jfk@zeus.polsl.gliwice.pl>
Subject: Re: [RFC] userland swsusp
Date: Thu, 17 Nov 2005 21:15:09 +0100
Message-ID: <20051117201509.GA25250@finwe.eu.org>
References: <F760B14C9561B941B89469F59BA3A8470BDD12EB@orsmsx401.amr.corp.intel.com>
	<20051116191051.GG2193@spitz.ucw.cz>
	<20051117165437.GA10402@dspnet.fr.eu.org>
	<20051117164451.GA27178@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6246456953180195=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20051117164451.GA27178@kroah.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Greg KH <greg@kroah.com>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>, kernel list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

--===============6246456953180195==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Greg KH wrote:

> > > What unstable implementation? swsusp had very little regressions over past
> > > year or so. Drivers were different story, but nothing changes w.r.t. drivers.
> > Do you mean swsusp is actually supposed to work?  Suspend-to-ram,
> > suspend-to-disk or both?
> Both.  -to-ram depends on your video chip, but to-disk should work just
> fine.  If not, please report bugs.

Thanks, I've just realized, that I probably forgot to CC anyone last time... 
:)

So, may I kindly ask to look on:
http://www.ussg.iu.edu/hypermail/linux/kernel/0511.1/1863.html ?

Thanks!

-- 
Jacek Kawa

--===============6246456953180195==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============6246456953180195==--
