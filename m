From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFD] Automatic suspend
Date: Mon, 16 Feb 2009 17:40:10 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0902161736210.21117-100000__9245.23885264552$1234824237$gmane$org@netrider.rowland.org>
References: <200902162312.50556.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200902162312.50556.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Nigel Cunningham <nigel@nigel.suspend2.net>, Uli Luckas <u.luckas@road.de>, LKML <linux-kernel@vger.kernel.org>, Brian Swetland <swetland@google.com>, pm list <linux-pm@lists.linux-foundation.org>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Mon, 16 Feb 2009, Rafael J. Wysocki wrote:

> OK, so I think there are two things that user space may be allowed to do as
> far as putting devices into low power states is concerned:
> * disable/enable the automatic power management of the device (provided that
>   the driver supports the automatic PM)

Set the automatic PM parameters (idle timeout, state to go to, etc.).  
And disabling automatic PM altogether (effectively the same as setting
the idle timeout to infinity).

> * check what power states devices are in.

What about situations where we want to distinguish between the power 
state of the device itself and the power state of the link?  For a disk 
drive we may want to power the link on and off quite a lot, as that 
has low latency, but spinning the disk up and down takes a long time 
and so should have a longer idle-time value.

Alan Stern
