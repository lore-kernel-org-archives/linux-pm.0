From: Pavel Machek <pavel@suse.cz>
Subject: Re: [linux-pm] amd74xx crashes when resuming from STR
Date: Tue, 18 Jul 2006 04:34:45 +0000 (UTC)
Message-ID: <19700101003716.GA3558__9011.55568794838$1153197285$gmane$org@ucw.cz>
References: <20060715210518.GA3263@opus.vpn-dev.reflex>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Date: Thu, 1 Jan 1970 00:37:16 +0000
Content-Disposition: inline
In-Reply-To: <20060715210518.GA3263@opus.vpn-dev.reflex>
Sender: linux-ide-owner@vger.kernel.org
To: Jason Lunz <lunz@falooley.org>
Cc: vojtech@suse.cz, linux-ide@vger.kernel.org, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

Hi!

> On my laptop, suspend-to-ram works for all drivers with the exception of
> the amd74xx ide driver. And even then, it only has problems when
> accessing a UDMA hard drive. I know this because the system can use STR
> reliably when booted from a livecd, so long as nothing accesses the hard
> disk.

I guess you need to ask on linux-ide mainling lists?

Ahha, you are cross-posting there, already.

What happens if you rmmod amd74xx and insmod it after resume?
							Pavel

-- 
Thanks for all the (sleeping) penguins.
