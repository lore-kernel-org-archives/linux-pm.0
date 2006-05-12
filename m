From: David Brownell <david-b@pacbell.net>
Subject: Re: [linux-pm] Re: [PATCH/rfc] schedule /sys/device/.../power for removal
Date: Fri, 12 May 2006 06:52:53 -0700
Message-ID: <200605120652.55658.david-b@pacbell.net>
References: <20060512100544.GA29010@elf.ucw.cz> <20060512031151.76a9d226.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932079AbWELNw6@vger.kernel.org>
In-Reply-To: <20060512031151.76a9d226.akpm@osdl.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@lists.osdl.org
Cc: Andrew Morton <akpm@osdl.org>, Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Friday 12 May 2006 3:11 am, Andrew Morton wrote:
> 
> What will be impacted by this?

Driver suspend/resume testing ... impact is strongly negative.

Without this interface, there is NO way to test individual drivers for
correct handling of suspend/resume calls; the only way to test drivers
is to suspend/resume the whole system, along with all other drivers in
the system.  Which means that ALL the drivers must work sanely before
tests for any one of them can succeed ... a losing model when you're
testing PM on new platforms.

Which IMO makes removing this a Bad Thing.  It needs to have some
kind of replacement in place before the "magic numbers" go away.

(The magic numbers are bad, and should go away -- yes.  Nobody has
really shown that userspace needs this mechanism for any purpose
other than driver testing.  Userspace device-specific power management
tools would need knowledge that's not yet exposed though sysfs.)

I think both Patrick Mochel and Alan Stern have sent patches at
various times to let individual drivers provide a list of named
states they support,  In some cases (like PCI) those lists could
be delegated to bus-specific code.
