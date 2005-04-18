From: "Jordan Crouse" <jordan.crouse@amd.com>
Subject: Re: [RFC] Power Management Policies
Date: Mon, 18 Apr 2005 09:39:19 -0600
Message-ID: <20050418093919.37bb40db@cosmic.amd.com>
References: <1113772533.3451.131.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============66381590987409655=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <1113772533.3451.131.camel@localhost.localdomain>
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

--===============66381590987409655==
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 7bit

Adam -

Excellent summary.

> On the other extreme, we could allow userspace to configure every
> timeout value, and other policy attributes. 

With regards to this specifically, in addition to the
other extremes you mentioned, we also have two different types of
systems. On one hand, we have open systems, with many different options,
and plenty of PCI and PCMCIA slots to keep adding new devices. while
on the other hand, we have closed systems such as cell phones and PDAs,
where the number of attached devices stays fairly constant.

>From a software point of view, the latter is usually controlled by a
operating environment (usually GUI based), that is developed by the
manufacturer and generally not hacked by the end user (most don't even
have terminals). And of course, Linux on an open system is usually
installed and hand tuned by the end user working closely with the
command line.  

So when it comes to a closed system, then I don't see any problem with
asking the userspace to configure everything about the policy, because
it gives the operating environment developer the most control over the
final device.  If someone down the line discovers that the wake
latency of a device is way too long, then I would much prefer that they
be able to tweak the settings via userspace, rather then have me patch a
new kernel just for them.

However, I can completely see where somebody responsible for an open
system would run in terror from this.  This would mean an immense amount
of work for the various distributions, as well as the inevitable
mailing list / technical support snafus that will occur when everybody
needs to figure out the various power management related quirks of their
various devices.

> I personally have some concerns over too much userspace interaction. 
> I think these decisions are too device specific, and if we don't take
> responsibility for them, then the layers above the kernel may not be
> able to properly handle it.

I generally favor the "user knows best" policy.  As developers, we will
make the best overall power management decisions for our drivers
(timeouts, system state transitions, etc, etc...), but should allow for
a facility for the user to override these if they so choose (possibly
through the policy manager).  We can even go so far as to make the
framework disabled by default in the kernel, so that one has to go in,
specifically choose it, and thereby take on the additional risk.  

Regards,
Jordan

-- 
Jordan Crouse
Senior Linux Engineer
AMD - Personal Connectivity Solutions Group
<www.amd.com/embeddedprocessors>


--===============66381590987409655==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============66381590987409655==--
