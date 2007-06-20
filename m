From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFD] How to tell ACPI drivers what the target sleep
	state is (was: Re: [PATCH 1/2] acpi choose sleep state help)
Date: Wed, 20 Jun 2007 16:36:41 +0200
Message-ID: <200706201636.41834.rjw__45128.404783509$1182349889$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0706201006190.3311-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0706201006190.3311-100000@iolanthe.rowland.org>
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
Cc: pm list <linux-pm@lists.linux-foundation.org>, dbrownell@users.sourceforge.net, Pavel Machek <pavel@ucw.cz>, linux acpi <linux-acpi@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wednesday, 20 June 2007 16:08, Alan Stern wrote:
> On Wed, 20 Jun 2007, Rafael J. Wysocki wrote:
> 
> > > Not. Could pm_message_t have a member indicating the suspend state?
> > 
> > Well, I thought about that, but I did't know what people on linux-pm would
> > think about that.
> > 
> > Alternatively, we could introduce a pm_target() global PM operation that will
> > set the target sleep state for the entire system.
> > 
> > I think we should discuss that on linux-pm before any decision is made.
> 
> Pardon me for asking what may be a dumb question.  Why does ACPI (or
> anything else) need to know the target system state in order to decide
> how a device should be suspended or whether wakeup should be enabled?

The question isn't so dumb. ;-)

For each device (handled by it) ACPI defines _SxD and _SxW methods returning
the highest power (lowest number) D-state supported by the device in the
(system-wide) state Sx and the lowest power (highest number) D-state in which
the device can wake up the system being in the Sx sleep state, respectively.
The target power state of the device should be determined on the basis of these
values (along with the device's wake up setting) and they depend on the target
system sleep state.

Greetings,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth
