From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] PM / OPP: -ENOSYS is applicable only to syscalls
Date: Wed, 27 Apr 2016 08:17:04 +0530
Message-ID: <20160427024704.GB22326@vireshk-i7>
References: <cover.1461228504.git.viresh.kumar@linaro.org>
 <a825b531b34b15615791f40610c151e3f1ce2fb4.1461294917.git.viresh.kumar@linaro.org>
 <60895590.AIt8jZZHh3@vostro.rjw.lan>
 <20160422155941.23e1d05b@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160422155941.23e1d05b@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, arnd.bergmann@linaro.org, andrew@lunn.ch, gregory.clement@free-electrons.com, jason@lakedaemon.net, sebastian.hesselbarth@gmail.com, thomas.petazzoni@free-electrons.com, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 22-04-16, 15:59, One Thousand Gnomes wrote:
> On Fri, 22 Apr 2016 14:42:31 +0200
> "Rafael J. Wysocki" <rjw@rjwysocki.net> wrote:
> 
> > On Friday, April 22, 2016 08:46:51 AM Viresh Kumar wrote:
> > > Some of the routines have use -ENOSYS, which is supposed to be used only
> > > for syscalls. Replace that with -EINVAL.  
> > 
> > -EINVAL specifically means "invalid argument".
> > 
> > What about using -ENXIO instead?
> 
> That specifically means "device not present", but might be reasonable.
> Quite a bit of the kernel uses EOPNOTSUPP (operation not supported).

That looks reasonable to me.. Will switch to that.

> Before you change it though please check how existing userspace does
> error handling. It's nice to use more "correct" error codes, but that's
> not sufficient reason if it turns out that existing user space checks for
> ENOSYS for example.

Userspace doesn't interact directly with this stuff, its pretty much within the
kernel. So it should be fine.

Thanks Alan.

-- 
viresh
