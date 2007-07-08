From: David Brownell <david-b@pacbell.net>
Subject: Re: malicious filesystems (was Re: Re: [PATCH] Remove
	process freezer from suspend to RAM pathway)
Date: Sun, 8 Jul 2007 09:23:54 -0700
Message-ID: <200707080923.54998.david-b__34649.4339559742$1183911902$gmane$org@pacbell.net>
References: <E1I6MWb-0008Tq-00@dorka.pomaz.szeredi.hu>
	<20070708123748.GB3866@ucw.cz>
	<20070708135829.GF21668@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070708135829.GF21668@ftp.linux.org.uk>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org
Cc: mjg59@srcf.ucam.org, Miklos Szeredi <miklos@szeredi.hu>, linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, Al Viro <viro@ftp.linux.org.uk>, johannes@sipsolutions.net
List-Id: linux-pm@vger.kernel.org

On Sunday 08 July 2007, Al Viro wrote:
> On Sun, Jul 08, 2007 at 12:37:48PM +0000, Pavel Machek wrote:
> > I'm talking malicious _filesystems_ here, and yes, fuse is first of
> > this kind. We want to handle unresponding NFS, but I believe handling
> > malicious NFS server nicely is slightly out of scope.
> 
> If your variant doesn't handle compromised NFS server, your variant is
> needs to be fixed...

That would depend on the type of compromise, right?

Remember that the fundamental contract between a client and
a server includes the client extending some trust to that
server.  Whether it's appropriate to extend that trust (at
any given moment) is an out-of-band security issue.  Trust
is not a protocol issue ... more like an operational issue,
and only slightly an implementation issue.

A malicious filesystem could do many things.  It could send
private data off to someone who wasn't intended to receive
that data.  It could return falsified data.  It could do any
variety of things outside the protocol specification...

And *MOST* of those would be impractical to defend against
in code.  Which is why I have such a hard time agreeing
with your comment about "fixing" a client that doesn't try
to defend itself.  (Unless by "client" you also include the
whole operational side of the client, including regular
re-validation of the trust extended to that server... which
would at best minimize damage caused by compromises.)
