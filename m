From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: Power management for SCSI
Date: Wed, 13 Aug 2008 17:44:00 +0200
Message-ID: <48A30140.9040704@s5r6.in-berlin.de>
References: <Pine.LNX.4.44L0.0808131051330.2455-100000@iolanthe.rowland.org> <200808131724.52461.oneukum@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755634AbYHMPpa@vger.kernel.org>
In-Reply-To: <200808131724.52461.oneukum@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Oliver Neukum <oneukum@suse.de>
Cc: Alan Stern <stern@rowland.harvard.edu>, Pavel Machek <pavel@suse.cz>, kernel list <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.osdl.org>, James.Bottomley@hansenpartnership.com, teheo@novell.com
List-Id: linux-pm@vger.kernel.org

Oliver Neukum wrote:
> Am Mittwoch 13 August 2008 16:59:23 schrieb Alan Stern:
[Quoting Oliver:  true SCSI busses can be shared. So are we using the
correct approach?]
>> This is a good question.  Most USB mass-storage devices do not act as a
>> true SCSI bus, but I believe there are a few non-standard ones that do
>> -- the USB device really contains a SCSI host and arbitrary SCSI
> 
> OK, but does it make sense to have SCSI autosuspend? Or should autosuspend
> operate on the bus the _host_ is connected to (usb, pci, ...)?

In Alan's patch, SCSI calls scsi_host_template methods (if the LLD
provides ones) to suspend and resume a Scsi_Host.  The LLD can use them
to work with the underlying infrastructure to determine what can be done
at that time.  I.e. are there other protocols or other initiator-like
nodes sharing the link?  If yes or if "maybe yes", the infrastructure
keeps the link up.  If not, it can move it into a low-power state.
-- 
Stefan Richter
-=====-==--- =--- -==-=
http://arcgraph.de/sr/
