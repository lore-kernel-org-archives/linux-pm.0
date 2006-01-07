From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [patch] pm: fix runtime powermanagement's /sys
	interface
Date: Sat, 7 Jan 2006 10:24:49 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0601071016160.8527-100000@netrider.rowland.org>
References: <20060107074146.GC3184@neo.rr.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============55723159891724938=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060107074146.GC3184@neo.rr.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Adam Belay <ambx1@neo.rr.com>
Cc: Andrew Morton <akpm@osdl.org>, Pavel Machek <pavel@ucw.cz>, Linux-pm mailing list <linux-pm@lists.osdl.org>, kernel list <linux-kernel@vger.kernel.org>, Dominik Brodowski <linux@dominikbrodowski.net>
List-Id: linux-pm@vger.kernel.org

--===============55723159891724938==
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Sat, 7 Jan 2006, Adam Belay wrote:

> In short I'm suggesting the following:
> 
> 1.) Every bus and device has its own unique PM mechanisms and specifications.
> Representing this in a single unified model of any sort is nearly impossible.
> Therefore, it may be best to allow each bus to define its own PM
> infustructure and sysfs files (perhaps in a way similar to Pat's recent
> patch).

Bus and/or driver.  However even though the mechanisms and specifications 
are all different, that doesn't mean the user interfaces have to be 
different.  Using simple character string names (like Pat did and like I 
did several months ago) should be general enough to work everywhere.

Similarly, the sysfs files themselves should be uniform (even if their
contents aren't).  The core should provide the user interface mechanism
and infrastructure, while leaving it up to the bus and the device drivers
to interpret the meanings of the strings.

> 2.) Device drivers on the other hand exist at a more abstract level and,
> as a result, we have greater flexability and more options.  Therefore, I
> think this is an excellent place to define power states and driver core PM
> infustructure.

It's a good place to define and implement power states.  But the driver 
core PM infrastructure obviously should be defined and implemented in the 
core, not in the drivers.

> 3.) System suspend and runtime power management are not even close to
> similar.  Trying to use the same ->suspend and ->resume API is
> ridiculious because it prevents intermediate power states and doesn't
> properly perpare devices and device classes for a runtime environment.
> Therefore, I'm in favor of a seperate interface tailored specifically for
> runtime power management.

Personally I don't care much one way or another.  The APIs can be kept 
separate or overlapped somehow; it doesn't really matter.  Just so long as 
it's done the same way in all drivers and in the core.

> 4.) If we're going to make any meaningful progress, we need to also
> focus on device classes and class orriented power policy.  For example,
> the "net" device class should provide infustructure and helper functions
> for runtime power management of that flavor.  This might include some
> generic "net" PM sysfs files.

Can you think of device classes other than "net" requiring this special
approach?  Network interfaces already get special treatment in some ways
(for example, they don't have entries in /dev).  This could just be
another form of special treatment for them.

Alan Stern


--===============55723159891724938==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============55723159891724938==--
