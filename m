From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 1/2] PM / Runtime: Add sysfs switch for
	disabling device run-time PM (rev. 2)
Date: Fri, 5 Feb 2010 00:08:52 +0100
Message-ID: <201002050008.52699.rjw__36037.0145216168$1265325742$gmane$org@sisk.pl>
References: <201001180129.55219.rjw@sisk.pl> <201001212359.38886.rjw@sisk.pl>
	<20100204224623.GB1436@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100204224623.GB1436@ucw.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Greg KH <greg@kroah.com>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Thursday 04 February 2010, Pavel Machek wrote:
> Hi!
> 
> >  /*
> > + *	control - Report/change current runtime PM setting of the device
> > + *
> > + *	Runtime power management of a device can be blocked with the help of
> > + *	this attribute.  All devices have one of the following two values for
> > + *	the power/control file:
> > + *
> > + *	 + "auto\n" to allow the device to be power managed at run time;
> > + *	 + "on\n" to prevent the device from being power managed at run time;
> 
> I find interface with mandatory \n quite 'interesting'. 

This simply follows the other descriptions in this file.

> Plus english is strange here. All devices have ... "auto" to allow...?
> Strange formulation. List the values first, then add "write ... to allow"?

Ditto.

> > + *	The default for all devices is "auto", which means that devices may be
> > + *	subject to automatic power management, depending on their drivers.
> 
> Is it wise to specify 'auto' default value for devices without runtime
> pm?

Yes, it is.  It means the user space doesn't care whether or not the device is
power managed at run-time.

> > +static ssize_t control_store(struct device * dev, struct device_attribute *attr,
> > +			     const char * buf, size_t n)
> > +{
> > +	char *cp;
> > +	int len = n;
> > +
> > +	cp = memchr(buf, '\n', n);
> > +	if (cp)
> > +		len = cp - buf;
> > +	if (len == sizeof ctrl_auto - 1 && strncmp(buf, ctrl_auto, len) == 0)
> > +		pm_runtime_allow(dev);
> 
> parenthesis after sizeof?

This notation is used throughout this file too.

> Do I read it correctly that all of
> 
> "auto"
> "auto\n"
> "auto\non\nIm confused"
> 
> will switch to auto?

Perhaps it would, but what exactly is the problem with that?

Rafael
