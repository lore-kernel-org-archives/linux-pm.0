From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFD] Automatic suspend
Date: Tue, 17 Feb 2009 00:28:55 +0100
Message-ID: <200902170028.57501.rjw__2517.90555562383$1234827088$gmane$org@sisk.pl>
References: <200902162312.50556.rjw@sisk.pl>
	<Pine.LNX.4.44L0.0902161736210.21117-100000@netrider.rowland.org>
	<20090216145655.727cd39c@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090216145655.727cd39c@infradead.org>
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
To: Arjan van de Ven <arjan@infradead.org>
Cc: Nigel Cunningham <nigel@nigel.suspend2.net>, Uli Luckas <u.luckas@road.de>, LKML <linux-kernel@vger.kernel.org>, Arve@smtp1.linux-foundation.org, Brian Swetland <swetland@google.com>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Monday 16 February 2009, Arjan van de Ven wrote:
> On Mon, 16 Feb 2009 17:40:10 -0500 (EST)
> Alan Stern <stern@rowland.harvard.edu> wrote:
> 
> > On Mon, 16 Feb 2009, Rafael J. Wysocki wrote:
> > 
> > > OK, so I think there are two things that user space may be allowed
> > > to do as far as putting devices into low power states is concerned:
> > > * disable/enable the automatic power management of the device
> > > (provided that the driver supports the automatic PM)
> > 
> > Set the automatic PM parameters (idle timeout, state to go to,
> > etc.). And disabling automatic PM altogether (effectively the same as
> > setting the idle timeout to infinity).
> > 
> 
> shouldn't idle timeout etc be internal to the driver?
> Yes policy preferences / constraints makes sense to communicate,
> actual settings do not. For one they keep changing fast all the time
> anyway.

Usually different devices are handled by the same driver.  I don't really
think the same value will be suitable for all of them, so the users should
at least be able to override the driver default, IMO.

Thanks,
Rafael
