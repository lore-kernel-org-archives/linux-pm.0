From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 1/2] PM / Runtime: Add sysfs switch for
	disabling	device run-time PM (rev. 2)
Date: Thu, 4 Feb 2010 23:46:23 +0100
Message-ID: <20100204224623.GB1436__33582.6055649251$1265325729$gmane$org@ucw.cz>
References: <201001180129.55219.rjw@sisk.pl> <201001212357.46483.rjw@sisk.pl>
	<201001212359.38886.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201001212359.38886.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Greg KH <greg@kroah.com>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Hi!

>  /*
> + *	control - Report/change current runtime PM setting of the device
> + *
> + *	Runtime power management of a device can be blocked with the help of
> + *	this attribute.  All devices have one of the following two values for
> + *	the power/control file:
> + *
> + *	 + "auto\n" to allow the device to be power managed at run time;
> + *	 + "on\n" to prevent the device from being power managed at run time;

I find interface with mandatory \n quite 'interesting'. 

Plus english is strange here. All devices have ... "auto" to allow...?
Strange formulation. List the values first, then add "write ... to allow"?

> + *	The default for all devices is "auto", which means that devices may be
> + *	subject to automatic power management, depending on their drivers.

Is it wise to specify 'auto' default value for devices without runtime
pm?


> +static ssize_t control_store(struct device * dev, struct device_attribute *attr,
> +			     const char * buf, size_t n)
> +{
> +	char *cp;
> +	int len = n;
> +
> +	cp = memchr(buf, '\n', n);
> +	if (cp)
> +		len = cp - buf;
> +	if (len == sizeof ctrl_auto - 1 && strncmp(buf, ctrl_auto, len) == 0)
> +		pm_runtime_allow(dev);

parenthesis after sizeof?

Do I read it correctly that all of

"auto"
"auto\n"
"auto\non\nIm confused"

will switch to auto?

(and sorry for late reply...)
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
