From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 0/8] Suspend block api (version 6)
Date: Fri, 14 May 2010 22:47:01 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1005142238150.11498-100000__28840.2609098286$1273891759$gmane$org@netrider.rowland.org>
References: <AANLkTilL2mvqpwirTfJRWZFdrFJvSihnaY8-xao4pLpH@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTilL2mvqpwirTfJRWZFdrFJvSihnaY8-xao4pLpH@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-omap@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>, Geoff Smith <geoffx.smith@intel.com>, Brian Swetland <swetland@google.com>, Kernel development list <linux-kernel@vger.kernel.org>, Oleg Nesterov <oleg@redhat.com>, Linus Walleij <linus.walleij@ericsson.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Tejun Heo <tj@kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Matthew Garrett <mjg@redhat.com>, Liam Girdwood <lrg@slimlogic.co.uk>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Fri, 14 May 2010, Magnus Damm wrote:

> I agree with you Tony. I thought shutting down CPUs for power
> managment purposes could be done without freezing user space. At least
> that's what we do today with SH-Mobile.

If you can shut down and restart CPUs in the time periods between 
transitions into and out of the idle loop, then yes -- userspace 
doesn't need to be suspended.  After all, if the idle loop is running 
then no user threads are runnable.  (Not necessarily true on SMP 
systems, but you know what I mean.)

> Still not sure how the system wide suspend is different from Runtime
> PM and CPUidle from the hardware perspective...

For embedded systems, apparently the difference is minimal.  For other
systems, like ACPI-based PCs, there is a big difference: Powering down
devices and CPUs still leaves large parts of the system running.

In addition, these larger systems generally don't have aggressive 
runtime PM support, so a significant fraction (maybe more than 50%) of 
devices won't be powered down when they are idle -- whereas system 
suspend powers virtually everything down.

Alan Stern
