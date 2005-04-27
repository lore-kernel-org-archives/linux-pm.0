From: David Brownell <david-b@pacbell.net>
Subject: Re: [RFC] Power Management Policies
Date: Wed, 27 Apr 2005 07:22:31 -0700
Message-ID: <200504270722.31321.david-b@pacbell.net>
References: <1113772533.3451.131.camel@localhost.localdomain>
	<20050418093919.37bb40db@cosmic.amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============17716787827628355=="
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
To: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

--===============17716787827628355==
Content-Type: text/plain;
  charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Monday 18 April 2005 8:39 am, Jordan Crouse wrote:
>  [ open vs closed device/appliance models]
> 
> From a software point of view, the latter is usually controlled by a
> operating environment (usually GUI based), that is developed by the
> manufacturer and generally not hacked by the end user (most don't even
> have terminals). And of course, Linux on an open system is usually
> installed and hand tuned by the end user working closely with the
> command line.  
> 
> So when it comes to a closed system, then I don't see any problem with
> asking the userspace to configure everything about the policy, because
> it gives the operating environment developer the most control over the
> final device. 

There's product positioning ("marketing") involved here too.  Consumer
electronics models have traditionally been pretty "closed".  Putting
aside (temporarily) the issue that such models don't necessarily serve
the customers as well as they serve the manufacturers, it's also clear
that "open" systems are better for non-appliance/throwaway models.
They support add-on products and multi-vendor "eco"systems, where you
can get new features by add-ons rather than (expensive) replacements.

>From the customer point of view, the attraction of "closed" is limited.
It can be a huge win in terms of ease-of-use to not _need_ to configure
things, and know "this is how you do it".  Turn off brain, use product;
throw it away rather than repairing/upgrading.

I don't see major vendors wanting to move away from "closed" models
at the lower end, or in fact whereever they have the power to dictate
customer "preferences".  (The latter case is also known as a "market
failure", except by radical corporatists...)  But for higher end products,
or when customers truly have (or need!!) choices, then "open" is more
usually the answer.

- Dave


--===============17716787827628355==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============17716787827628355==--
