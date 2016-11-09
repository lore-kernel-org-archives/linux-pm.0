From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] thermal/powerclamp: add back module device table
Date: Wed, 9 Nov 2016 16:08:35 +0100
Message-ID: <20161109150835.GA6382@kroah.com>
References: <1478703661-10875-1-git-send-email-jacob.jun.pan@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1478703661-10875-1-git-send-email-jacob.jun.pan@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>, eric.ernst@linux.intel.com, Linux PM <linux-pm@vger.kernel.org>, Rafael Wysocki <rafael.j.wysocki@intel.com>
List-Id: linux-pm@vger.kernel.org

On Wed, Nov 09, 2016 at 07:01:01AM -0800, Jacob Pan wrote:
> Commit 3105f234e0aba43e44e277c20f9b32ee8add43d4 replaced module
> cpu id table with a cpu feature check, which is logically correct.
> But we need the module device table to allow module auto loading.
> ---
>  drivers/thermal/intel_powerclamp.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)

No signed-off-by :(

No Fixes: line, and no stable: line :(
