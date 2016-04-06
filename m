From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2] PM / runtime: Document steps for device removal
Date: Thu, 07 Apr 2016 01:34:44 +0200
Message-ID: <1951186.4KzpkCHJdR@vostro.rjw.lan>
References: <Pine.LNX.4.44L0.1604031426580.17131-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:58723 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752740AbcDFXcO (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 6 Apr 2016 19:32:14 -0400
In-Reply-To: <Pine.LNX.4.44L0.1604031426580.17131-100000@netrider.rowland.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>, Krzysztof Kozlowski <krzk@kernel.org>
Cc: Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On Sunday, April 03, 2016 02:27:27 PM Alan Stern wrote:
> On Sun, 3 Apr 2016, Krzysztof Kozlowski wrote:
> 
> > Put a reminder that during device removal drivers should revert all PM
> > runtime changes from the probe.
> > 
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> > 
> > ---
> > 
> > Changes since v1:
> > 1. Address Alan's comments.
> > ---
> >  Documentation/power/runtime_pm.txt | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/Documentation/power/runtime_pm.txt b/Documentation/power/runtime_pm.txt
> > index 7328cf85236c..1fd1fbe9ce95 100644
> > --- a/Documentation/power/runtime_pm.txt
> > +++ b/Documentation/power/runtime_pm.txt
> > @@ -586,6 +586,10 @@ drivers to make their ->remove() callbacks avoid races with runtime PM directly,
> >  but also it allows of more flexibility in the handling of devices during the
> >  removal of their drivers.
> >  
> > +Drivers in ->remove() callback should undo the runtime PM changes done
> > +in ->probe(). Usually this means calling pm_runtime_disable(),
> > +pm_runtime_dont_use_autosuspend() etc.
> > +
> >  The user space can effectively disallow the driver of the device to power manage
> >  it at run time by changing the value of its /sys/devices/.../power/control
> >  attribute to "on", which causes pm_runtime_forbid() to be called.  In principle,
> 
> Acked-by: Alan Stern <stern@rowland.harvard.edu>

Applied, thanks!

