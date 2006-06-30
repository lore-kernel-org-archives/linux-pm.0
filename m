From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 2/2] Fix console handling duringsuspend/resume
Date: Thu, 29 Jun 2006 21:01:44 -0700
Message-ID: <200606292101.45392.david-b@pacbell.net>
References: <5389061B65D50446B1783B97DFDB392D019DE2D5@orsmsx411.amr.corp.intel.com>
	<20060629225946.GC26175@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060629225946.GC26175@kroah.com>
Content-Disposition: inline
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
Cc: linux-pm@lists.osdl.org, Linus Torvalds <torvalds@osdl.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

> > Shouldn't this type of thing go through the MM-tree first for these
> > reasons?
> =

> Good point, that's probably the correct way to do this for such a core
> change.

Yes please.  :)

It doesn't conflict with the PRETHAW fixes.

After sanity testing, then the issue will be that folk should
start seeing how this updated infrastructure should be used, yes?

- Dave
