From: Pavel Machek <pavel@suse.cz>
Subject: Re: [RFC][PATCH -mm] swsusp userland interface:
	additional ioctl
Date: Mon, 30 Jan 2006 00:06:47 +0100
Message-ID: <20060129230647.GE2318@elf.ucw.cz>
References: <200601292256.23124.rjw@sisk.pl> <20060129215726.GD2318@elf.ucw.cz>
	<200601292346.58928.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============75720866513735974=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200601292346.58928.rjw@sisk.pl>
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
Cc: Linux PM <linux-pm@osdl.org>
List-Id: linux-pm@vger.kernel.org

--===============75720866513735974==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> > > The appended patch provides an additional ioctl() for the swsusp userland
> > > interface that will allow the suspending and/or resuming utilities to change
> > > the kernel log level at the time of suspend/resume (or even set it to 0 if
> > > they are going to use some frame buffer graphics etc.).
> > 
> > klogd can already change loglevel... It should be possible to use that
> > to silence suspend, no?
> 
> Well, no.  Currently the kernel changes the log level to 10 unconditionally
> in pm_prepare_console() (that's the reason for the patch, BTW).

Can we just kill that log-level setting? It may have been useful in
the past, but I do not think it has right to live any more.
								Pavel
-- 
Thanks, Sharp!

--===============75720866513735974==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============75720866513735974==--
