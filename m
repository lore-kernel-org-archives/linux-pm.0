From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2 2/3] PM / OPP: Parse 'opp-supported-hw' binding
Date: Tue, 8 Dec 2015 20:31:05 +0530
Message-ID: <20151208150105.GH3692@ubuntu>
References: <cover.1447904566.git.viresh.kumar@linaro.org>
 <4341a83dc6591364cd9deb3dfa8343961b8605d6.1447904566.git.viresh.kumar@linaro.org>
 <20151125205147.GE11298@codeaurora.org>
 <20151127044517.GU3869@ubuntu>
 <20151201065252.GD4459@ubuntu>
 <20151204082339.GH3430@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20151204082339.GH3430@ubuntu>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, nm@ti.com, Stephen Boyd <sboyd@codeaurora.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Dmitry Torokhov <dtor@chromium.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, open list <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, Shawn Guo <shawnguo@kernel.org>
List-Id: linux-pm@vger.kernel.org

On 04-12-15, 13:53, Viresh Kumar wrote:
> On 01-12-15, 12:22, Viresh Kumar wrote:
> > Since these functions are *only* going to be called before any OPPs
> > are added for the device, and hence ruling out any concurrent readers,
> > maybe we can guarantee that with this:
> 
> @Rafael: Stephen has gone for vacations until end of year :(, can you
> please help with some reviews ?

Ping !!

-- 
viresh
