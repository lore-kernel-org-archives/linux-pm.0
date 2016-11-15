From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] thermal/powerclamp: add back module device table
Date: Tue, 15 Nov 2016 08:03:32 +0100
Message-ID: <20161115070332.GA26176@kroah.com>
References: <1479150525-13225-1-git-send-email-jacob.jun.pan@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1479150525-13225-1-git-send-email-jacob.jun.pan@linux.intel.com>
Sender: stable-owner@vger.kernel.org
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, stable@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Rafael Wysocki <rafael.j.wysocki@intel.com>
List-Id: linux-pm@vger.kernel.org

On Mon, Nov 14, 2016 at 11:08:45AM -0800, Jacob Pan wrote:
> Commit 3105f234e0aba43e44e277c20f9b32ee8add43d4 replaced module
> cpu id table with a cpu feature check, which is logically correct.
> But we need the module device table to allow module auto loading.
> 
> Fixes:3105f234 thermal/powerclamp: correct cpu support check
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
>  drivers/thermal/intel_powerclamp.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read Documentation/stable_kernel_rules.txt
for how to do this properly.

</formletter>
