From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v3] driver core / PM: Add PM domain callbacks for device
 setup/cleanup
Date: Sun, 22 Mar 2015 12:46:31 +0100
Message-ID: <20150322114631.GA23465@kroah.com>
References: <3533423.QQDErEmeTO@vostro.rjw.lan>
 <1654636.FxBHsexDm1@vostro.rjw.lan>
 <3289026.ADmXXipokh@vostro.rjw.lan>
 <1945120.Dj0Xbsak18@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:55337 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751454AbbCVLqf (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 22 Mar 2015 07:46:35 -0400
Content-Disposition: inline
In-Reply-To: <1945120.Dj0Xbsak18@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Alan Stern <stern@rowland.harvard.edu>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Kevin Hilman <khilman@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Russell King <linux@arm.linux.org.uk>, Mark Brown <broonie@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Sat, Mar 21, 2015 at 02:00:24AM +0100, Rafael J. Wysocki wrote:
> On Friday, March 20, 2015 01:59:27 PM Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > 
> > If PM domains are in use, it may be necessary to prepare the code
> > handling a PM domain for driver probing.  For example, in some
> > cases device drivers rely on the ability to power on the devices
> > with the help of the IO runtime PM framework and the PM domain
> > code needs to be ready for that.  Also, if that code has not been
> > fully initialized yet, the driver probing should be deferred.
> > 
> > Moreover, after the probing is complete, it may be necessary to
> > put the PM domain in question into the state reflecting the current
> > needs of the devices in it, for example, so that power is not drawn
> > in vain.  The same should be done after removing a driver from
> > a device, as the PM domain state may need to be changed to reflect
> > the new situation.
> > 
> > For these reasons, introduce new PM domain callbacks, ->activate,
> > ->sync and ->dismiss called, respectively, before probing for a
> > device driver, after the probing has completed successfully and
> > if the probing has failed or the driver has been removed.
> > 
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> > 
> > One more update taking Dmitry's comments into account and fixing an
> > overoptimization bug spotted by Ulf.
> > 
> > And this actually contains the patch this time (clicked on "Send" too
> > early last time, sorry about that).
> 
> Hi Greg,
> 
> Since everybody seems to like this one, do you have any objectctions against it?
> 
> If not, would it be a problem if I queued it up for 4.1?

No problem, nice cleanup:

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
