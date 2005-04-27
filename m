From: David Brownell <david-b@pacbell.net>
Subject: Re: [RFC] Power Management Policies
Date: Wed, 27 Apr 2005 07:01:54 -0700
Message-ID: <200504270701.55152.david-b@pacbell.net>
References: <1113772533.3451.131.camel@localhost.localdomain>
	<20050418093919.37bb40db@cosmic.amd.com>
	<20050423071833.GC27771@neo.rr.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============44775947523402948=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20050423071833.GC27771@neo.rr.com>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

--===============44775947523402948==
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Saturday 23 April 2005 12:18 am, Adam Belay wrote:
> > > 
> > > I personally have some concerns over too much userspace interaction. 
> > > I think these decisions are too device specific, and if we don't take
> > > responsibility for them, then the layers above the kernel may not be
> > > able to properly handle it.

Me too ...

> In general, it seems to make sense for userspace to tell the kernel about
> policy preferences, but then have the kernel execute those decisions.  If
> we were to ship suggested policy options inside of driver modules, then 
> driver developers could ensure the user is at least aware of typical policy
> configuration values.

The way I view things:  drivers offer choice-of-policy to userspace,
then userspace chooses the policy.

What I want to avoid is treating active userspace intervention as the
normal case ... polling every Nth-of-a-second as one example.  It's
quite reasonable for userspace to deal with higher level notions that
are already application-visible, like LCD (back)lighting or various
activity timeouts.  It's quite another thing to create interfaces
specifically to export low level monitoring to userspace.

- Dave

--===============44775947523402948==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============44775947523402948==--
