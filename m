From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 3/5] [pm] Respect the actual device power
	states in sysfs interface
Date: Mon, 20 Feb 2006 14:04:04 -0800
Message-ID: <20060220220404.GA25746@kroah.com>
References: <Pine.LNX.4.50.0602171758160.30811-100000@monsoon.he.net>
	<20060218155543.GE5658@openzaurus.ucw.cz>
	<Pine.LNX.4.50.0602191557520.8676-100000@monsoon.he.net>
	<20060220004635.GA22576@kroah.com>
	<Pine.LNX.4.50.0602200955030.12708-100000@monsoon.he.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============49153036369139347=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.50.0602200955030.12708-100000@monsoon.he.net>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Patrick Mochel <mochel@digitalimplant.org>
Cc: akpm@osdl.org, linux-pm@osdl.org, torvalds@osdl.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

--===============49153036369139347==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 20, 2006 at 09:58:27AM -0800, Patrick Mochel wrote:
> 
> On Sun, 19 Feb 2006, Greg KH wrote:
> 
> > On Sun, Feb 19, 2006 at 03:59:25PM -0800, Patrick Mochel wrote:
> > >
> > > On Sat, 18 Feb 2006, Pavel Machek wrote:
> > >
> > > > Hi!
> > > >
> > > > > Fix the per-device state file to respect the actual state that
> > > > > is reported by the device, or written to the file.
> > > >
> > > > Can we let "state" file die? You actually suggested that at one point.
> > > >
> > > > I do not think passing states in u32 is good idea. New interface that passes
> > > > state as string would probably be better.
> > >
> > > Yup, in the future that will be better. For now, let's work with what we
> > > got and fix 2.6.16 to be compatible with previous versions..
> >
> > It's _way_ too late in the 2.6.16 cycle for this series of patches, if
> > that is what you are proposing.
> 
> Would you mind commmenting on why, as well as your opinion on the validity
> of the patches themselves?
> 
> This static, hardcoded policy was introduced into the core ~2 weeks ago,
> and it doesn't seem like it belongs there at all.

That patch was accepted as it fixed a oops.  It also went in for
2.6.16-rc2, which is much earlier than 2.6.16-rc4, and it had been in
the -mm tree for quite a while for people to test it out and verify that
it didn't break anything.  I didn't hear any complaints about it, so
that is why it went in.

In contrast, this patch series creates a new api and doesn't necessarily
fix any reported bugs.  It also has not had the time to be tested in the
-mm tree, and there is quite a lot of disagreement about the patches on
the lists.  All of that combinded makes it not acceptable for so late in
the -rc cycle (remember, -rc4 means only serious bug fixes.)

> This seems like the easiest way to fixing it, but I'm open to
> alternative suggestions..

Care to resend the series based on all of the comments you have
addressed so far?  I'll be glad to review it then.

thanks,

greg k-h

--===============49153036369139347==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============49153036369139347==--
