From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] PM / OPP: fix debugfs files for 64-bit
Date: Wed, 7 Oct 2015 18:39:34 +0100
Message-ID: <20151007173934.GB10665@kroah.com>
References: <5706174.BUsqiXljxZ@wuerfel>
 <20151007105911.GC9892@linux>
 <20151007110302.GD9892@linux>
 <20151007110755.GA6601@kroah.com>
 <20151007112149.GB22530@linux>
 <20151007125735.GA8170@kroah.com>
 <20151007130324.GA4557@linux>
 <20151007171949.GB9702@kroah.com>
 <20151007172701.GF4557@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20151007172701.GF4557@linux>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Arnd Bergmann <arnd@arndb.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Nishanth Menon <nm@ti.com>, Dmitry Torokhov <dtor@chromium.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Wed, Oct 07, 2015 at 10:57:01PM +0530, Viresh Kumar wrote:
> On 07-10-15, 18:19, Greg Kroah-Hartman wrote:
> > Ok, then stop exporting it in debugfs and everyone will be happy :)
> 
> Hehe, not really. See I am not happy :(

Why not?  Why does this have to be exported in debugfs?  Just delete it,
who cares about it?  It's just "debugging".

> So, what do you suggest? Should we create debugfs_create_ulong()?

Ick, do we _really_ need and want that?

> And how to implement that? With existing u32/u64 APIs or from scratch?

It's probably easy to just do in a few lines "from scratch", if you
really need/want it, right?

thanks,

greg k-h
