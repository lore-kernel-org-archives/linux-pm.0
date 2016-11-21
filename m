From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] thermal/powerclamp: add back module device table
Date: Mon, 21 Nov 2016 08:13:22 +0100
Message-ID: <20161121071322.GA5006@kroah.com>
References: <1479150525-13225-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <20161115070332.GA26176@kroah.com>
 <20161117114216.3fa995b4@jacob-builder>
 <1479699790.2360.10.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1479699790.2360.10.camel@intel.com>
Sender: stable-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>, LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, stable@vger.kernel.org, Rafael Wysocki <rafael.j.wysocki@intel.com>
List-Id: linux-pm@vger.kernel.org

On Mon, Nov 21, 2016 at 11:43:10AM +0800, Zhang Rui wrote:
> On Thu, 2016-11-17 at 11:42 -0800, Jacob Pan wrote:
> > On Tue, 15 Nov 2016 08:03:32 +0100
> > Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> > 
> > > 
> > > On Mon, Nov 14, 2016 at 11:08:45AM -0800, Jacob Pan wrote:
> > > > 
> > > > Commit 3105f234e0aba43e44e277c20f9b32ee8add43d4 replaced module
> > > > cpu id table with a cpu feature check, which is logically
> > > > correct.
> > > > But we need the module device table to allow module auto loading.
> > > > 
> > > > Fixes:3105f234 thermal/powerclamp: correct cpu support check
> > > > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > > > ---
> > > >  drivers/thermal/intel_powerclamp.c | 9 ++++++++-
> > > >  1 file changed, 8 insertions(+), 1 deletion(-)  
> > > <formletter>
> > > 
> > > This is not the correct way to submit patches for inclusion in the
> > > stable kernel tree.  Please read
> > > Documentation/stable_kernel_rules.txt
> > > for how to do this properly.
> > > 
> > > </formletter>
> > Good to know, thanks. Rui will take care of it this time. Per Rui
> > "I will apply patch 1 and queue up for next -rc and 4.8 stable."
> > 
> 
> Just find another problem.
> We're still missing this upstream
> commit 3105f234e0aba43e44e277c20f9b32ee8add43d4 (thermal/powerclamp:
> correct cpu support check) for 4.7 stable, and in this case, we can not
> queue this patch for both 4.7 and 4.8 stable at the moment because it
> does not apply to 4.7 stable.

I don't understand, 4.7 is end-of-life, no one cares about it anymore,
why are you worrying about that kernel version?

confused,

greg k-h
