From: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH] thermal/powerclamp: add back module device table
Date: Thu, 17 Nov 2016 11:42:16 -0800
Message-ID: <20161117114216.3fa995b4@jacob-builder>
References: <1479150525-13225-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <20161115070332.GA26176@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20161115070332.GA26176@kroah.com>
Sender: stable-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, stable@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Rafael Wysocki <rafael.j.wysocki@intel.com>, jacob.jun.pan@linux.intel.com
List-Id: linux-pm@vger.kernel.org

On Tue, 15 Nov 2016 08:03:32 +0100
Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> On Mon, Nov 14, 2016 at 11:08:45AM -0800, Jacob Pan wrote:
> > Commit 3105f234e0aba43e44e277c20f9b32ee8add43d4 replaced module
> > cpu id table with a cpu feature check, which is logically correct.
> > But we need the module device table to allow module auto loading.
> > 
> > Fixes:3105f234 thermal/powerclamp: correct cpu support check
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > ---
> >  drivers/thermal/intel_powerclamp.c | 9 ++++++++-
> >  1 file changed, 8 insertions(+), 1 deletion(-)  
> 
> <formletter>
> 
> This is not the correct way to submit patches for inclusion in the
> stable kernel tree.  Please read Documentation/stable_kernel_rules.txt
> for how to do this properly.
> 
> </formletter>

Good to know, thanks. Rui will take care of it this time. Per Rui
"I will apply patch 1 and queue up for next -rc and 4.8 stable."

Thanks,

Jacob
