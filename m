From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFD] Automatic suspend
Date: Tue, 17 Feb 2009 00:02:36 +0100
Message-ID: <200902170002.37973.rjw__28857.5051738464$1234825587$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0902161736210.21117-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0902161736210.21117-100000@netrider.rowland.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Nigel Cunningham <nigel@nigel.suspend2.net>, Uli Luckas <u.luckas@road.de>, LKML <linux-kernel@vger.kernel.org>, Arve@smtp1.linux-foundation.org, Brian Swetland <swetland@google.com>, pm list <linux-pm@lists.linux-foundation.org>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Monday 16 February 2009, Alan Stern wrote:
> On Mon, 16 Feb 2009, Rafael J. Wysocki wrote:
> 
> > OK, so I think there are two things that user space may be allowed to do as
> > far as putting devices into low power states is concerned:
> > * disable/enable the automatic power management of the device (provided that
> >   the driver supports the automatic PM)
> 
> Set the automatic PM parameters (idle timeout, state to go to, etc.).  

Yes.  I'm not sure about the state part, though.

> And disabling automatic PM altogether (effectively the same as setting
> the idle timeout to infinity).

Yes.

> > * check what power states devices are in.
> 
> What about situations where we want to distinguish between the power 
> state of the device itself and the power state of the link?  For a disk 
> drive we may want to power the link on and off quite a lot, as that 
> has low latency, but spinning the disk up and down takes a long time 
> and so should have a longer idle-time value.

Well, I'm not sure at the moment.

Do you have any suggestions?

Rafael
