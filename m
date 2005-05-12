From: Greg KH <greg@kroah.com>
Subject: Re: [patch 2.6.12-rc4] remove driver model detach_state
Date: Thu, 12 May 2005 13:37:05 -0700
Message-ID: <20050512203704.GA25241@kroah.com>
References: <200505121206.27981.david-b@pacbell.net>
	<Pine.LNX.4.44L0.0505121528570.4678-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============048060424332033058=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.44L0.0505121528570.4678-100000@iolanthe.rowland.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: David Brownell <david-b@pacbell.net>, Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

--===============048060424332033058==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 12, 2005 at 03:31:22PM -0400, Alan Stern wrote:
> On Thu, 12 May 2005, David Brownell wrote:
> 
> > This mechanism has never AFAICT been used, and I asked a while back
> > if anyone knew of uses ... no takers, even though it's been in the
> > kernel for almost two years by now.
> > 
> > Here's a patch to remove the thing.  AFAICT, suitable to merge ASAP;
> > it reduces sysfs size impact, and is a net code shrink.
> 
> Note that for Greg's "driver" tree, some of the changes you made to bus.c 
> will have to apply to dd.c instead.  Maybe Greg will fix this up by 
> himself; I still don't know how he manages to juggle multiple conflicting 
> source trees...

Don't worry, I can handle it :)

> On the whole this looks like a good thing to do.

I agree.  Will apply it later this evening.

greg k-h

--===============048060424332033058==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============048060424332033058==--
