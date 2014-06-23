From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [PATCH 1/1] PM / Runtime: let rpm_resume fail if rpm disabled and device suspended.
Date: Mon, 23 Jun 2014 11:57:37 -0700
Message-ID: <7hk387pi72.fsf@paris.lan>
References: <Pine.LNX.4.44L0.1406210913470.26962-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44L0.1406210913470.26962-100000@netrider.rowland.org>
	(Alan Stern's message of "Sat, 21 Jun 2014 09:34:28 -0400 (EDT)")
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Allen Yu <alleny@nvidia.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Alan Stern <stern@rowland.harvard.edu> writes:

[...]

> What we really need to figure out is how to tell the PM core which
> devices may safely have their runtime callbacks invoked during system
> suspend.  For those devices, the core can avoid calling
> pm_runtime_disable() during the suspend_late phase.  That would address
> your requirements, right?

Yes, and something I've attempted a few times over the years, most
recently during the introduction of the pm_runtime_force* functions[1],
which I thought was again an attempt to work around this issue.

I don't think Rafael has ever been too thrilled with that idea
(including the last time[2]), but I think we're to a point now that we
have to manage this somehow.

My attempt to let the bus/subsystem/pm_domain set a flag might be
too simplistic, but I do agree we do need som way to tell the PM core
that runtime PM callbacks are (still) safe.

Kevin

[1] http://marc.info/?l=linux-pm&m=139343222014989&w=2
[2] http://marc.info/?l=linux-pm&m=139346327619875&w=2
