From: Greg KH <greg@kroah.com>
Subject: Re: Re: [RFC][PATCH -mm] swsusp userland interface:
	additional ioctl
Date: Sun, 29 Jan 2006 20:54:48 -0800
Message-ID: <20060130045448.GE13244@kroah.com>
References: <200601292256.23124.rjw@sisk.pl> <20060129215726.GD2318@elf.ucw.cz>
	<200601292346.58928.rjw@sisk.pl> <20060129230647.GE2318@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============11849035788722739=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060129230647.GE2318@elf.ucw.cz>
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
Cc: Linux PM <linux-pm@osdl.org>
List-Id: linux-pm@vger.kernel.org

--===============11849035788722739==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 30, 2006 at 12:06:47AM +0100, Pavel Machek wrote:
> Hi!
> 
> > > > The appended patch provides an additional ioctl() for the swsusp userland
> > > > interface that will allow the suspending and/or resuming utilities to change
> > > > the kernel log level at the time of suspend/resume (or even set it to 0 if
> > > > they are going to use some frame buffer graphics etc.).
> > > 
> > > klogd can already change loglevel... It should be possible to use that
> > > to silence suspend, no?
> > 
> > Well, no.  Currently the kernel changes the log level to 10 unconditionally
> > in pm_prepare_console() (that's the reason for the patch, BTW).
> 
> Can we just kill that log-level setting? It may have been useful in
> the past, but I do not think it has right to live any more.

Yes, change that, don't create another interface to the kernel where
there is already one.

thanks,

greg k-h

--===============11849035788722739==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============11849035788722739==--
