From: Paul Mackerras <paulus@samba.org>
Subject: Re: Re: [PATCH] Remove process freezer from suspend to
	RAM pathway
Date: Wed, 4 Jul 2007 14:02:55 +1000
Message-ID: <18059.7151.841436.329553__49587.5947097831$1183525749$gmane$org@cargo.ozlabs.ibm.com>
References: <18058.12724.163599.707035@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.44L0.0707031146300.3936-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0707031146300.3936-100000@iolanthe.rowland.org>
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
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Alan Stern writes:

> > Most drivers suspended their hardware in the second call.  If they are
> > in the middle of a conversation with their device that *has* to be
> > completed, they can do that by polling.
> 
> Ugh.  That will cause problems when you try to integrate runtime 
> suspend.  In fact this whole approach is unsuitable for runtime PM and 
> it obscures the similarities between runtime PM and STR.

Yes there are similarities, but it would be a big mistake to say that
a requirement for STR is that all drivers do runtime PM.

If a driver does runtime PM, that's great, and it is useful for
implementing STR.  However, there are a class of devices for which
runtime PM is not possible or not useful, but which can suspend/resume
just fine as part of suspending/resuming the complete system, and for
which all that is needed is some small amount of simple hardware
poking just before the system as a whole is put into suspend.  For
those a late-suspend call with interrupts off is the simplest and best
way to go.

Think of a serial port on a motherboard for instance, where the only
power control is the overall power control for the system.  All that
is needed is to poll for the transmitter being empty (with timeout, of
course) in the late-suspend call (and possibly also turn off output
drivers, perhaps), and to reinitialize some registers in an
early-resume call.

The main attraction of the late-suspend call is that it really does,
reliably, guarantee that the driver's I/O request methods won't get
called between the late-suspend call and the early-resume call.

Paul.
