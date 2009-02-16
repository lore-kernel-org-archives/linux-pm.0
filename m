From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [RFD] Automatic suspend
Date: Mon, 16 Feb 2009 14:56:55 -0800
Message-ID: <20090216145655.727cd39c__25175.2184624367$1234825154$gmane$org@infradead.org>
References: <200902162312.50556.rjw@sisk.pl>
	<Pine.LNX.4.44L0.0902161736210.21117-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0902161736210.21117-100000@netrider.rowland.org>
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
Cc: Benjamin@smtp1.linux-foundation.org, Nigel Cunningham <nigel@nigel.suspend2.net>, Uli Luckas <u.luckas@road.de>, LKML <linux-kernel@vger.kernel.org>, Brian Swetland <swetland@google.com>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Mon, 16 Feb 2009 17:40:10 -0500 (EST)
Alan Stern <stern@rowland.harvard.edu> wrote:

> On Mon, 16 Feb 2009, Rafael J. Wysocki wrote:
> 
> > OK, so I think there are two things that user space may be allowed
> > to do as far as putting devices into low power states is concerned:
> > * disable/enable the automatic power management of the device
> > (provided that the driver supports the automatic PM)
> 
> Set the automatic PM parameters (idle timeout, state to go to,
> etc.). And disabling automatic PM altogether (effectively the same as
> setting the idle timeout to infinity).
> 

shouldn't idle timeout etc be internal to the driver?
Yes policy preferences / constraints makes sense to communicate,
actual settings do not. For one they keep changing fast all the time
anyway.
 


-- 
Arjan van de Ven 	Intel Open Source Technology Centre
For development, discussion and tips for power savings, 
visit http://www.lesswatts.org
