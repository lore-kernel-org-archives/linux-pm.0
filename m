From: Frederik Deweerdt <deweerdt@free.fr>
Subject: Re: [linux-pm] swsusp regression [Was: 2.6.17-mm1]
Date: Thu, 22 Jun 2006 18:04:03 +0200
Message-ID: <20060622160403.GB2539@slug>
References: <20060621034857.35cfe36f.akpm@osdl.org> <4499BE99.6010508@gmail.com> <20060621221445.GB3798@inferi.kami.home> <20060622061905.GD15834@kroah.com> <20060622004648.f1912e34.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1161074AbWFVQEJ@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20060622004648.f1912e34.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org, pavel@suse.cz, linux-pm@osdl.org, stern@rowland.harvard.edu
List-Id: linux-pm@vger.kernel.org

Thu, Jun 22, 2006 at 12:46:48AM -0700, Andrew Morton wrote:
> I can bisect it if we're stuck, but that'll require beer or something.

FWIW, my laptop (Dell D610) gave the following results:
2.6.17-mm1: suspend_device(): usb_generic_suspend+0x0/0x135 [usbcore]() returns -16
2.6.17+origin.patch: suspend_device(): usb_generic_suspend+0x0/0x135 [usbcore]() returns -16
2.6.17: oops
2.6.17.1: oops

2.6.17-rc6-mm2: suspends correctly


Regards,
Frederik
