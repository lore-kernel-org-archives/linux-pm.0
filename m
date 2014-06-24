From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 1/1] PM / Runtime: let rpm_resume fail if rpm disabled and device suspended.
Date: Wed, 25 Jun 2014 01:38:43 +0200
Message-ID: <3098868.U0NfB8kYvJ@vostro.rjw.lan>
References: <Pine.LNX.4.44L0.1406221239060.17183-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44L0.1406221239060.17183-100000@netrider.rowland.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Allen Yu <alleny@nvidia.com>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Sunday, June 22, 2014 12:45:42 PM Alan Stern wrote:
> On Sun, 22 Jun 2014, Rafael J. Wysocki wrote:
> 
> > > How would you treat them specially?  Add a "runtime_pm_not_supported" 
> > > flag?
> > 
> > I thought about a "runtime PM has been enabled at least once" flag rather
> > that would be set by pm_runtime_enable() every time it is called and never
> > cleared.  That would allow the core to distinguish between "runtime PM
> > disabled temporarily" and "runtime PM not used" which turn out to be
> > sufficiently different cases.
> 
> Interesting idea, but it can't tell the difference between "runtime PM
> not supported" and "runtime PM not enabled yet".  I think a simple "not
> supported" flag will be more straightforward.

The question is who will set the "unsupported" flag (think devices without
drivers etc.).  Or perhaps the idea is that it will be set to start with?

> > Yes.  The core definitely needs to be able to distinguish between the
> > "runtime PM disabled temporarily" and "runtime PM not supported/not used"
> > situations.
> 
> Let me work out a patch, and we'll see what you think.  For the time
> being we can stick with our "runtime PM must be disabled (or in error)  
> when the status is changed" approach.

OK

Rafael
