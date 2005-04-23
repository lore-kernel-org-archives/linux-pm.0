From: Adam Belay <ambx1@neo.rr.com>
Subject: Re: [RFC] Power Management Policies
Date: Sat, 23 Apr 2005 03:18:34 -0400
Message-ID: <20050423071833.GC27771@neo.rr.com>
References: <1113772533.3451.131.camel@localhost.localdomain>
	<20050418093919.37bb40db@cosmic.amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============32860025175908025=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20050418093919.37bb40db@cosmic.amd.com>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Jordan Crouse <jordan.crouse@amd.com>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

--===============32860025175908025==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 18, 2005 at 09:39:19AM -0600, Jordan Crouse wrote:

--> snip

> 
> > I personally have some concerns over too much userspace interaction. 
> > I think these decisions are too device specific, and if we don't take
> > responsibility for them, then the layers above the kernel may not be
> > able to properly handle it.
> 
> I generally favor the "user knows best" policy.  As developers, we will
> make the best overall power management decisions for our drivers
> (timeouts, system state transitions, etc, etc...), but should allow for
> a facility for the user to override these if they so choose (possibly
> through the policy manager).  We can even go so far as to make the
> framework disabled by default in the kernel, so that one has to go in,
> specifically choose it, and thereby take on the additional risk.  

I agree.

As a thought, what if we included some suggested power attribute
configurations as module data (much like we do with pci device IDs now)?
This  would allow the driver developer to pass this information up to
userspace, without imposing any policy.  The default settings could be
performance orriented and then when userspace starts up it could tell the
policy manager to slow things down.

In general, it seems to make sense for userspace to tell the kernel about
policy preferences, but then have the kernel execute those decisions.  If
we were to ship suggested policy options inside of driver modules, then 
driver developers could ensure the user is at least aware of typical policy
configuration values.

Also, it might be useful to distribute a set of userspace power management
tools. We could call it something like "hardware-utils" and have it handle PM
policy and other userspace driver core issues.

Thanks,
Adam

--===============32860025175908025==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============32860025175908025==--
