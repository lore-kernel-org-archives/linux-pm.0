From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] power: qos: no need to check return value of
 debugfs_create functions
Date: Tue, 22 Jan 2019 16:53:14 +0100
Message-ID: <20190122155314.GB20142@kroah.com>
References: <20190122152151.16139-48-gregkh@linuxfoundation.org>
 <CAJZ5v0jLeZfsmX12g6r0zXCt9dTjD0TnJ03+Sntt6i2f-PxsGw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jLeZfsmX12g6r0zXCt9dTjD0TnJ03+Sntt6i2f-PxsGw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Linux PM <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Jan 22, 2019 at 04:30:38PM +0100, Rafael J. Wysocki wrote:
> On Tue, Jan 22, 2019 at 4:25 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > When calling debugfs functions, there is no need to ever check the
> > return value.  The function can work or not, but the code logic should
> > never do something different based on this.
> >
> > Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> > Cc: Len Brown <len.brown@intel.com>
> > Cc: Pavel Machek <pavel@ucw.cz>
> > Cc: linux-pm@vger.kernel.org
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> All of these changes are fine by me and I can take the patches
> touching the code maintained by me, so please let me know.

Please take them!

thanks,

greg k-h
