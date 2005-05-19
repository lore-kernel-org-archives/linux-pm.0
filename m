From: David Brownell <david-b@pacbell.net>
Subject: Re: [patch 2.6.12-rc4] driver model wakeup support
Date: Thu, 19 May 2005 15:45:50 -0700
Message-ID: <200505191545.50437.david-b@pacbell.net>
References: <200505081724.09468.david-b@pacbell.net>
	<20050519103819.1f7400d1@cosmic.amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============77877073188105972=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20050519103819.1f7400d1@cosmic.amd.com>
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

--===============77877073188105972==
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Thursday 19 May 2005 9:38 am, Jordan Crouse wrote:
> > This is a refresh of a patch I sent before.  I suspect it'd be
> > appropriate to merge this, given the agreement I thought I
> > heard last time I posted it.
> 
> Maybe I haven't been paying attention (likely), but I don't see that
> there has been any official activity on this patch.   Is it headed to
> the -mm branch or headed to the bit bucket?

Nobody really commented on it this time.  But then, not many folk
are actually looking at wakeup support lately ... there's so much
attention on the "power down my laptop with swsusp" case that the
other PM scenarios -- "real PM" vs "off" -- often get ignored.

I'll see about only putting that "wakeup" attribute on devices
that actually need it, and then submit that.  With infrastructure
in place, folk can start using it.

- Dave


--===============77877073188105972==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============77877073188105972==--
