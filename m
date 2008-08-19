From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Power management for SCSI
Date: Tue, 19 Aug 2008 10:32:19 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0808191027070.2669-100000@iolanthe.rowland.org>
References: <20080819073839.GA8726@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753655AbYHSOcb@vger.kernel.org>
In-Reply-To: <20080819073839.GA8726@atrey.karlin.mff.cuni.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@suse.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.osdl.org>, James.Bottomley@HansenPartnership.com, teheo@novell.com, oneukum@suse.de
List-Id: linux-pm@vger.kernel.org

On Tue, 19 Aug 2008, Pavel Machek wrote:

> Would it make sense to split the patches into "autosuspend for SCSI
> devices" and "autosuspend for SCSI controllers" for easier
> review/merge? I guess I'll start with the devices, they seem easier...

It really should be split up differently.  The topics of interest are:

	idle detection for SCSI devices,

	autosuspend for SCSI targets and its relation to suspend
	for SCSI devices,

	passing suspend & resume notifications to the transport class,

	adding a USB transport class so that usb-storage can respond
	to those notifications,

	modifying other transport classes as needed so that the LLDs
	can power-down links or host adapters.

I think that covers it.  Oliver may have some additional suggestions.

Alan Stern
