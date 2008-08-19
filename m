From: Oliver Neukum <oneukum@suse.de>
Subject: Re: [linux-pm] Power management for SCSI
Date: Tue, 19 Aug 2008 09:50:38 +0200
Message-ID: <200808190950.40790.oneukum@suse.de>
References: <20080813095055.GA475@elf.ucw.cz> <Pine.LNX.4.44L0.0808131026320.2455-100000@iolanthe.rowland.org> <20080819073839.GA8726@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754779AbYHSHtu@vger.kernel.org>
In-Reply-To: <20080819073839.GA8726@atrey.karlin.mff.cuni.cz>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@lists.linux-foundation.org
Cc: Pavel Machek <pavel@suse.cz>, Alan Stern <stern@rowland.harvard.edu>, James.Bottomley@hansenpartnership.com, Linux-pm mailing list <linux-pm@lists.osdl.org>, kernel list <linux-kernel@vger.kernel.org>, teheo@novell.com
List-Id: linux-pm@vger.kernel.org

Am Dienstag 19 August 2008 09:38:39 schrieb Pavel Machek:
 
> Would it make sense to split the patches into "autosuspend for SCSI
> devices" and "autosuspend for SCSI controllers" for easier
> review/merge? I guess I'll start with the devices, they seem easier...

Runtime PM will have to leave devices alone while error handling is active.
Unfortunately error handling is done at controller level. So I am afraid
this would be very difficult.

	Regards
		Oliver
