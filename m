From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFD] Automatic suspend
Date: Mon, 16 Feb 2009 21:43:52 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0902162141190.24097-100000@netrider.rowland.org>
References: <20090216145655.727cd39c@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090216145655.727cd39c@infradead.org>
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
Cc: Nigel Cunningham <nigel@nigel.suspend2.net>, Uli Luckas <u.luckas@road.de>, LKML <linux-kernel@vger.kernel.org>, Brian Swetland <swetland@google.com>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Mon, 16 Feb 2009, Arjan van de Ven wrote:

> > Set the automatic PM parameters (idle timeout, state to go to,
> > etc.). And disabling automatic PM altogether (effectively the same as
> > setting the idle timeout to infinity).
> > 
> 
> shouldn't idle timeout etc be internal to the driver?
> Yes policy preferences / constraints makes sense to communicate,
> actual settings do not. For one they keep changing fast all the time
> anyway.

Sorry, I don't agree.  A single driver may control many different kinds
of device -- it may not even be aware of the distinction!  Consider the
SCSI disk driver: It has to handle both traditional rotating media and
solid-state disks.  Clearly they should have different runtime PM
parameters.  But the driver isn't in a good position to know what those
parameters should be.

Alan Stern
