From: Greg KH <greg@kroah.com>
Subject: Re: [stable] [regression] Re: [213/474] x86,
 hotplug: Use mwait to offline a processor, fix the legacy case
Date: Tue, 30 Aug 2011 15:34:50 -0700
Message-ID: <20110830223450.GA17450__4732.89583246714$1314849232$gmane$org@kroah.com>
References: <20110317213822.GA27980@kroah.com>
	<20110317212903.394948496@clark.kroah.org>
	<20110828184004.GA7690@elie.gateway.2wire.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20110828184004.GA7690@elie.gateway.2wire.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Jonathan Nieder <jrnieder@gmail.com>
Cc: Len Brown <len.brown@intel.com>, x86@kernel.org, Robert Scott <bugs@humanleg.org.uk>, Greg KH <gregkh@suse.de>, =?iso-8859-1?Q?Fr=E9d=E9ric?= Boiteux <fboiteux@calistel.com>, stable-review@kernel.org, Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>, linux-pm@lists.linux-foundation.org, "H. Peter Anvin" <hpa@linux.intel.com>, stable@kernel.org
List-Id: linux-pm@vger.kernel.org

On Sun, Aug 28, 2011 at 01:40:04PM -0500, Jonathan Nieder wrote:
> Hi,
> =

> On 2011-03-17, Greg KH wrote:
> =

> > 2.6.33-longterm review patch.  If anyone has any objections, please let=
 us know.
> [...]
> > From: H. Peter Anvin <hpa@linux.intel.com>
> >
> > upstream ea53069231f9317062910d6e772cca4ce93de8c8
> > x86, hotplug: Use mwait to offline a processor, fix the legacy case
> >
> > Here included also some small follow-on patches to the same code:
> [...]
> > https://bugzilla.kernel.org/show_bug.cgi?id=3D5471
> >
> > Signed-off-by: H. Peter Anvin <hpa@linux.intel.com>
> > Signed-off-by: Len Brown <len.brown@intel.com>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
> =

> Sorry for the sloow response.  Unfortunately this is reported to have
> broken hibernation on two machines: an EeePC 1002HA and an Ideapad S10-3.
> Fr=E9d=E9ric writes:
> =

> | I've observed that when resuming from hibernation, sometimes my compute=
r was
> | returning to Grub2's menu (without any error message), and I had to do a
> | "normal" boot on my Debian Squeeze system (with file systems correction=
s),
> | loosing my hibernation's state.
> |   The fail isn't automatic, but seems to happen more frequently after a=
 while
> | my computer was disconnected from AC and battery.
> =

> Noticed on Debian squeeze (which is based on v2.6.32.y), confirmed
> with unpatched v2.6.32.45 and v2.6.33.18.  Backing out the patch
> mentioned above avoids trouble.  A newer kernel (based on v2.6.39.y)
> does _not_ exhibit the same problem, so it looks like the problem was
> introduced in backporting.  http://bugs.debian.org/622259 has
> details.

Thanks for letting me know, I'll go revert that patch for the next .32
and .33 longterm releases and let everyone else work out exactly what
the problem is, if they want to.

greg k-h
