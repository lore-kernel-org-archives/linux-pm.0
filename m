From: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: [linux-pm] amd74xx crashes when resuming from STR
Date: Tue, 18 Jul 2006 15:39:20 +0200
Message-ID: <20060718133920.GA4106@suse.cz>
References: <20060715210518.GA3263@opus.vpn-dev.reflex> <19700101003716.GA3558@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <19700101003716.GA3558@ucw.cz>
Sender: linux-ide-owner@vger.kernel.org
To: Pavel Machek <pavel@suse.cz>
Cc: Jason Lunz <lunz@falooley.org>, linux-ide@vger.kernel.org, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

On Thu, Jan 01, 1970 at 12:37:16AM +0000, Pavel Machek wrote:
> Hi!
> 
> > On my laptop, suspend-to-ram works for all drivers with the exception of
> > the amd74xx ide driver. And even then, it only has problems when
> > accessing a UDMA hard drive. I know this because the system can use STR
> > reliably when booted from a livecd, so long as nothing accesses the hard
> > disk.
> 
> I guess you need to ask on linux-ide mainling lists?
> 
> Ahha, you are cross-posting there, already.
> 
> What happens if you rmmod amd74xx and insmod it after resume?
 
amd74xx relies on the BIOS to have set up a significant part of the
controller correctly. This likely isn't true after S3 resume. It might
be necessary to save & restore the whole PCI config space of the device.

-- 
Vojtech Pavlik
Director SuSE Labs
