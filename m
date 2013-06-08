From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 1/2] PM: use dpm_run_callback in device_prepare
Date: Fri, 7 Jun 2013 18:15:18 -0700
Message-ID: <20130608011518.GA2819@kroah.com>
References: <1370593232-3602-1-git-send-email-shuox.liu@intel.com>
 <1370593232-3602-2-git-send-email-shuox.liu@intel.com>
 <20130607173706.GA29615@kroah.com>
 <1370652235.4432.70.camel@ymzhang.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1370652235.4432.70.camel@ymzhang.sh.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yanmin Zhang <yanmin_zhang@linux.intel.com>
Cc: shuox.liu@intel.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, pavel@ucw.cz, rjw@sisk.pl, len.brown@intel.com, Zhang Yanmin <yanmin.zhang@intel.com>
List-Id: linux-pm@vger.kernel.org

On Sat, Jun 08, 2013 at 08:43:55AM +0800, Yanmin Zhang wrote:
> On Fri, 2013-06-07 at 10:37 -0700, Greg KH wrote:
> > On Fri, Jun 07, 2013 at 04:20:31PM +0800, shuox.liu@intel.com wrote:
> > > From: ShuoX Liu <shuox.liu@intel.com>
> > > 
> > > dpm_run_callback could show more debug info around prepare stage.
> > 
> > Why?  Who needs this?  What problem does it solve?
> > 
> > Without answers to this, why would you expect us to accept such a
> > change?
> It's to provide more debug info and developers can quickly find what
> prepare/complete callback consumes too much time.

What exact debug info is this providing, and why wouldn't you say all of
this in the original changelog information?

{hint}
