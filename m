From: "Leo L. Schwab" <ewhac@best.com>
Subject: Re: What woke system up?
Date: Wed, 4 Jan 2006 10:21:16 -0800
Message-ID: <20060104182116.GA17218@best.com>
References: <20051221002958.GA15851@slurryseal.ddns.mvista.com>
	<Pine.LNX.4.50.0512201809520.21656-100000@monsoon.he.net>
	<20051222034630.GA4320@slurryseal.ddns.mvista.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============56438228921800349=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20051222034630.GA4320@slurryseal.ddns.mvista.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: linux-pm@osdl.org
List-Id: linux-pm@vger.kernel.org

--===============56438228921800349==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 21, 2005 at 07:46:30PM -0800, Todd Poynor wrote:
> On Tue, Dec 20, 2005 at 06:11:40PM -0800, Patrick Mochel wrote:
> > What about stashing a pointer to the device that did the wakeup, then
> > using a symlink to point to the sysfs directory of that device?  [ ... ]
> 
> Sounds good, here's a new version that does just that.  [ ... ]

	I'm entering this discussion late, but if I were putting this
together:
	- There would be a single file named /sys/power/wake,
	- Upon resume, the file would contain lines of plaintext of the
	  format:

		device: reason

	- 'device' names the device that performed the wakeup.  'device'
	  could be either a sysfs path or a /dev/blah/blah path (sysfs is
	  probably better, if more verbose, as it remains consistent
	  regardless of how /dev is configured),
	- 'reason' is free-form text, supplied by the device performing the
	  wakeup, and is entirely device-dependent.

	This approach allows multiple wakeup sources (rare, but possible),
and also allows a single multifunction device to report multiple reasons for
a wakeup.  It's also darned simple to parse.

	IMHO, of course.

					Schwab

--===============56438228921800349==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============56438228921800349==--
