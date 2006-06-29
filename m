From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 2/2] Fix console handling duringsuspend/resume
Date: Thu, 29 Jun 2006 15:59:46 -0700
Message-ID: <20060629225946.GC26175@kroah.com>
References: <5389061B65D50446B1783B97DFDB392D019DE2D5@orsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <5389061B65D50446B1783B97DFDB392D019DE2D5@orsmsx411.amr.corp.intel.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: "Gross, Mark" <mark.gross@intel.com>
Cc: David Brownell <david-b@pacbell.net>, Linus Torvalds <torvalds@osdl.org>, linux-pm@lists.osdl.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On Thu, Jun 29, 2006 at 01:13:03PM -0700, Gross, Mark wrote:
> >AS FAR AS I CAN TELL the patch won't actually change any behaviour (I
> have
> >actually been running for the last few days with the separate patch
> that
> >_does_ do that - moves the PCI config suspend/resume to the late/early
> >rsume phase), but hey, mistakes happen.
> >
> =

> Shouldn't this type of thing go through the MM-tree first for these
> reasons?

Good point, that's probably the correct way to do this for such a core
change.

thanks,

greg k-h
