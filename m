From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] Don't "lose" devices on suspend on failure
Date: Wed, 1 Jun 2005 14:24:18 -0700
Message-ID: <20050601212418.GA3936@kroah.com>
References: <1117523329.5826.14.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S261240AbVFAVRB@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1117523329.5826.14.camel@gaston>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>, Patrick Mochel <mochel@digitalimplant.org>, Linux Kernel list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, May 31, 2005 at 05:08:49PM +1000, Benjamin Herrenschmidt wrote:
> Hi !
> 
> I think we need this patch or we might "lose" devices to the dpm_irq_off
> list if a failure occurs during the suspend process.
> 
> Patrick, Greg, your opinion ?

Looks fine to me, I've added it to my tree.

thanks,

greg k-h
