From: Patrick Mochel <mochel@digitalimplant.org>
Subject: Re: [RFC] userland swsusp
Date: Thu, 17 Nov 2005 09:03:05 -0800 (PST)
Message-ID: <Pine.LNX.4.50.0511170901250.6343-100000@monsoon.he.net>
References: <F760B14C9561B941B89469F59BA3A8470BDD12EB@orsmsx401.amr.corp.intel.com>
	<20051116191051.GG2193@spitz.ucw.cz>
	<20051117165437.GA10402@dspnet.fr.eu.org>
	<20051117164451.GA27178@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============18731126337722959=="
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
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>, Olivier Galibert <galibert@pobox.com>, kernel list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

--===============18731126337722959==
Content-Type: TEXT/PLAIN; charset=US-ASCII


On Thu, 17 Nov 2005, Greg KH wrote:

> On Thu, Nov 17, 2005 at 05:54:37PM +0100, Olivier Galibert wrote:
> > On Wed, Nov 16, 2005 at 07:10:52PM +0000, Pavel Machek wrote:
> > > What unstable implementation? swsusp had very little regressions over past
> > > year or so. Drivers were different story, but nothing changes w.r.t. drivers.
> >
> > Do you mean swsusp is actually supposed to work?  Suspend-to-ram,
> > suspend-to-disk or both?
>
> Both.  -to-ram depends on your video chip, but to-disk should work just
> fine.  If not, please report bugs.

swsusp has nothing to do with suspend-to-ram. swsusp is a
platform-independent implementation of suspend-to-disk. STR is
very-platform dependent. Please see the file:

	Documentation/power/states.txt

for more info.


	Pat


--===============18731126337722959==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============18731126337722959==--
