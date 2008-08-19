From: Oliver Neukum <oneukum@suse.de>
Subject: Re: [linux-pm] Power management for SCSI
Date: Tue, 19 Aug 2008 15:33:14 +0200
Message-ID: <200808191533.15244.oneukum@suse.de>
References: <Pine.LNX.4.44L0.0808151110380.23570-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753502AbYHSNd3@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44L0.0808151110380.23570-100000@netrider.rowland.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Pavel Machek <pavel@suse.cz>, linux-pm@lists.linux-foundation.org, James.Bottomley@hansenpartnership.com, Linux-pm mailing list <linux-pm@lists.osdl.org>, kernel list <linux-kernel@vger.kernel.org>, teheo@novell.com
List-Id: linux-pm@vger.kernel.org

Am Freitag 15 August 2008 17:25:13 schrieb Alan Stern:
> On Fri, 15 Aug 2008, Oliver Neukum wrote:
> 
> > Am Freitag 15 August 2008 00:25:28 schrieb Alan Stern:

Hi,

> > Yes, that means under some circumstances you cannot suspend the
> > member closest to the CPU, but under others you can. In a tree this question
> > is very simply answered, on a bus you will actually need to compute whether
> > you need the connection to the bus.

> More to the point is whether you should ever suspend any of these 
> devices if there can be multiple initiators.  But that's a separate 
> question.

But one that needs to be addressed.

> > It is true that you won't need the bus if all other members on the bus have
> > been suspended, but that's not very good because physically spinning
> > down and up a disk is a very expensive operation, while suspending a host
> > adapter can be trivial.
> 
> What is your point?  You seem to be saying that it would be nice to
> suspend a host adapter at times when some of the SCSI targets beneath
> it are not suspended.  I agree, but how would you determine whether
> such a thing was safe?

I suggest by talking to the HLDs.

It seems to me that abstractly talking there are three criteria for suspension

- the cpu needs to talk to the device now
- the device may need to talk to the CPU at unpredictable times
- suspending has side effects

Suspension in USB has always side effects. That's not true for other
subsystems. It seems to me that for the general case we need to divorce
the notion of a child being suspended itself from a child agreeing to its
parent being suspended.

	Regards
		Oliver
