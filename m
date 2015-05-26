From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH v2 3/8] core: platform: wakeup the parent before trying
 any driver operations
Date: Tue, 26 May 2015 16:28:14 +0300
Message-ID: <20150526132814.GA12719@kuha.fi.intel.com>
References: <1432570172-86963-4-git-send-email-andriy.shevchenko@linux.intel.com>
 <Pine.LNX.4.44L0.1505251335350.21019-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1505251335350.21019-100000@netrider.rowland.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Vinod Koul <vinod.koul@intel.com>, Lee Jones <lee.jones@linaro.org>, Andrew Morton <akpm@linux-foundation.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, Jarkko Nikula <jarkko.nikula@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

On Mon, May 25, 2015 at 01:36:43PM -0400, Alan Stern wrote:
> On Mon, 25 May 2015, Andy Shevchenko wrote:
> 
> > From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > 
> > If the parent is still suspended when a driver probe,
> > remove or shutdown is attempted, the result may be a
> > failure.
> > 
> > For example, if the parent is a PCI MFD device that has been
> > suspended when we try to probe our device, any register
> > reads will return 0xffffffff.
> > 
> > To fix the problem, making sure the parent is always awake
> > before using driver probe, remove or shutdown.
> > 
> > Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
> >  drivers/base/platform.c | 21 ++++++++++++++++++++-
> 
> Why make the changes here rather than in dd.c?  Is there something 
> special about platform devices?

There isn't. That would definitely be better.


Thanks Alan,

-- 
heikki
