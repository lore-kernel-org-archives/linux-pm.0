From: Adam Belay <ambx1@neo.rr.com>
Subject: Re: [patch 2.6.12-rc4] remove driver model detach_state
Date: Thu, 12 May 2005 18:06:33 -0400
Message-ID: <20050512220632.GA4293@neo.rr.com>
References: <200505121206.27981.david-b@pacbell.net>
	<Pine.LNX.4.44L0.0505121528570.4678-100000@iolanthe.rowland.org>
	<20050512203704.GA25241@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============019252793824082737=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20050512203704.GA25241@kroah.com>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Greg KH <greg@kroah.com>
Cc: David Brownell <david-b@pacbell.net>, Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

--===============019252793824082737==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 12, 2005 at 01:37:05PM -0700, Greg KH wrote:
> On Thu, May 12, 2005 at 03:31:22PM -0400, Alan Stern wrote:
> > On Thu, 12 May 2005, David Brownell wrote:
> > 
> > > This mechanism has never AFAICT been used, and I asked a while back
> > > if anyone knew of uses ... no takers, even though it's been in the
> > > kernel for almost two years by now.
> > > 
> > > Here's a patch to remove the thing.  AFAICT, suitable to merge ASAP;
> > > it reduces sysfs size impact, and is a net code shrink.
> > 
> > Note that for Greg's "driver" tree, some of the changes you made to bus.c 
> > will have to apply to dd.c instead.  Maybe Greg will fix this up by 
> > himself; I still don't know how he manages to juggle multiple conflicting 
> > source trees...
> 
> Don't worry, I can handle it :)
> 
> > On the whole this looks like a good thing to do.
> 
> I agree.  Will apply it later this evening.
> 
> greg k-h

Although I agree with this patch, I think it's important that we don't
forget about the code's original intentions.  When manual driver binding
and unbinding is supported, it would be nice if we could specify a detach
state.  My guess is that this should only include "on" or "off", but not
any intermediate states.

->remove isn't good enough, as the driver developer makes the decision
"let's turn off the device before detaching" or "let's leave it on".
This will vary between implementations. I think it may be better to
allow the user to specify this.

Finally, if the device is disabled, the configuration (e.g. PCI config
space) may need to be restored for the device to work on a future
driver.  This seems like a tricky problem if the driver is removed.

Selective suspend may be a better alternative, in which case, we need to
decide if it will unregister class devices etc. (as I suggested earlier)
or just do a somewhat regular device_suspend().

Driver binding/unbinding and requests to disable a device play an
interesting role in power management.  It would be nice if we could
define some goals for this.

Thanks,
Adam


--===============019252793824082737==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============019252793824082737==--
