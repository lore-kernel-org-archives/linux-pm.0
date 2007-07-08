From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] Remove process freezer from suspend to RAM
	pathway
Date: Mon, 09 Jul 2007 07:54:48 +1000
Message-ID: <1183931688.3388.316.camel__14348.4723441818$1183931859$gmane$org@localhost.localdomain>
References: <Pine.LNX.4.44L0.0707072224270.10912-100000@netrider.rowland.org>
	<200707082115.27363.rjw@sisk.pl>
	<1183928612.3388.289.camel@localhost.localdomain>
	<200707082345.27859.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200707082345.27859.rjw@sisk.pl>
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
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-kernel@vger.kernel.org, Kyle Moffett <mrmacman_g4@mac.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Sun, 2007-07-08 at 23:45 +0200, Rafael J. Wysocki wrote:
> 
> Workqueues are kernel threads and the creator decides if they are going to
> freeze.  There are only two freezable worqueues in the entire tree right now.

That and keventd workqueues... my point is you may well end up with
something in a workqueue doing things that should have been blocked
after the freeze.

> Actaully, I'm perfectly fine with that, as long as each task blocked by the
> driver due to suspend has PF_FROZEN (or something similar) set.  Then, at
> least theoretically, we'll be able to drop the freezer from the suspend code
> path and move it after device_suspend() (or the hibernation-specific
> equivalent) for hibernation (in that case there shouldn't be a problem with
> any task waiting on I/O while the freezer is running ;-)).

I don't see the need for a freezer for snapshot but that's a different
issue. (stop_machine looks good enough to me).

Ben
