From: Patrick Mochel <mochel@digitalimplant.org>
Subject: Re: What woke system up?
Date: Thu, 5 Jan 2006 13:28:29 -0800 (PST)
Message-ID: <Pine.LNX.4.50.0601051321550.17046-100000@monsoon.he.net>
References: <20051221002958.GA15851@slurryseal.ddns.mvista.com>
	<Pine.LNX.4.50.0512201809520.21656-100000@monsoon.he.net>
	<20051222034630.GA4320@slurryseal.ddns.mvista.com>
	<20060104182116.GA17218@best.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============71779645404706294=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060104182116.GA17218@best.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: "Leo L. Schwab" <ewhac@best.com>
Cc: linux-pm@osdl.org
List-Id: linux-pm@vger.kernel.org

--===============71779645404706294==
Content-Type: TEXT/PLAIN; charset=US-ASCII


On Wed, 4 Jan 2006, Leo L. Schwab wrote:

> On Wed, Dec 21, 2005 at 07:46:30PM -0800, Todd Poynor wrote:
> > On Tue, Dec 20, 2005 at 06:11:40PM -0800, Patrick Mochel wrote:
> > > What about stashing a pointer to the device that did the wakeup, then
> > > using a symlink to point to the sysfs directory of that device?  [ ... ]
> >
> > Sounds good, here's a new version that does just that.  [ ... ]
>
> 	I'm entering this discussion late, but if I were putting this
> together:
> 	- There would be a single file named /sys/power/wake,
> 	- Upon resume, the file would contain lines of plaintext of the
> 	  format:
>
> 		device: reason
>

Unless it's a single binary blob, we want to keep sysfs files to contain a
single discrete value.

> 	- 'device' names the device that performed the wakeup.  'device'
> 	  could be either a sysfs path or a /dev/blah/blah path (sysfs is
> 	  probably better, if more verbose, as it remains consistent
> 	  regardless of how /dev is configured),

We don't know the /dev path at all from the kernel (and one can't easily
ascertain the sysfs path from a device node entry). So, it would have to
be a sysfs path.

> 	- 'reason' is free-form text, supplied by the device performing the
> 	  wakeup, and is entirely device-dependent.

What is an example of a reason? Is it more explicit than e.g. "button
pressed"?

> 	This approach allows multiple wakeup sources (rare, but possible),
> and also allows a single multifunction device to report multiple reasons for
> a wakeup.  It's also darned simple to parse.

A single multi-function device should have multiple devices in the sysfs
tree. So, if we allowed multiple symlinks to exist pointing to all of the
wakeup devices, and provided a "wakeup-reason" file in each of the
device's directories, then we could provide for multiple wakeup sources.

The reason I push the symlink idea is because it's the easiest way to
convey a device path via sysfs, and it allows us to stay with one value
per file, while achieving the functionality you describe.

Out of curiosity, are there really cases where there is > 1 wakeup
device?

Thanks,


	Patrick


--===============71779645404706294==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============71779645404706294==--
