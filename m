From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFD] How to tell ACPI drivers what the target sleep
	state is (was: Re: [PATCH 1/2] acpi choose sleep state help)
Date: Wed, 20 Jun 2007 10:08:18 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0706201006190.3311-100000__1578.29923923618$1182348555$gmane$org@iolanthe.rowland.org>
References: <200706201332.25486.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200706201332.25486.rjw@sisk.pl>
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
Cc: pm list <linux-pm@lists.linux-foundation.org>, dbrownell@users.sourceforge.net, Pavel Machek <pavel@ucw.cz>, linux acpi <linux-acpi@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed, 20 Jun 2007, Rafael J. Wysocki wrote:

> > Not. Could pm_message_t have a member indicating the suspend state?
> 
> Well, I thought about that, but I did't know what people on linux-pm would
> think about that.
> 
> Alternatively, we could introduce a pm_target() global PM operation that will
> set the target sleep state for the entire system.
> 
> I think we should discuss that on linux-pm before any decision is made.

Pardon me for asking what may be a dumb question.  Why does ACPI (or
anything else) need to know the target system state in order to decide
how a device should be suspended or whether wakeup should be enabled?

Alan Stern
