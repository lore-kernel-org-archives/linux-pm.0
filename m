From: Alan Stern <stern@rowland.harvard.edu>
Subject: RE: [linux-pm] Power management for SCSI
Date: Wed, 13 Aug 2008 16:38:39 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0808131636400.2144-100000@iolanthe.rowland.org>
References: <556445368AFA1C438794ABDA8901891C094876DA@USA0300MS03.na.xerox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755798AbYHMUiu@vger.kernel.org>
In-Reply-To: <556445368AFA1C438794ABDA8901891C094876DA@USA0300MS03.na.xerox.net>
Sender: linux-kernel-owner@vger.kernel.org
To: "Leisner, Martin" <Martin.Leisner@xerox.com>
Cc: Oliver Neukum <oneukum@suse.de>, Linux-pm mailing list <linux-pm@lists.osdl.org>, kernel list <linux-kernel@vger.kernel.org>, teheo@novell.com, James.Bottomley@hansenpartnership.com, Pavel Machek <pavel@suse.cz>, Stefan Richter <stefanr@s5r6.in-berlin.de>
List-Id: linux-pm@vger.kernel.org

On Wed, 13 Aug 2008, Leisner, Martin wrote:

> Regarding these scsi suspend patches, there's a general
> problem to drop power on disk devices on a running system.
> I discussed it in:
> 
> http://www.gossamer-threads.com/lists/linux/kernel/811598

There's a much worse problem which that thread completely ignored:

When you turn off power to a disk device, to the system it looks like a 
hot-unplug event.  Any mounted filesystems or memory mappings on that 
disk will be lost.

Alan Stern
