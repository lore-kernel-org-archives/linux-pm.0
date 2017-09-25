From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] PM / core: Drop legacy class suspend/resume operations
Date: Mon, 25 Sep 2017 15:24:43 +0200
Message-ID: <20170925132443.GA5325@kroah.com>
References: <6823681.sfkuFdUyaG@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <6823681.sfkuFdUyaG@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Sep 25, 2017 at 02:56:44PM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> There are no classes using the legacy suspend/resume operations in
> the tree any more, so drop these operations and update the code
> referring to them accordingly.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/base/power/main.c |   32 +++++++++-----------------------
>  include/linux/device.h    |    5 -----
>  2 files changed, 9 insertions(+), 28 deletions(-)

Yeah!!!

Do you want me to take this now, for -rc2, in my tree (as I'll gladly do
so, I have some other api removals queued up already), or do you want to
do it through yours?

Either is fine with me, if you want to take it:
	Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

thanks,

greg k-h
