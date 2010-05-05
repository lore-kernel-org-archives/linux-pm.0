From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 0/8] Suspend block api (version 6)
Date: Wed, 5 May 2010 15:20:40 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1005051515060.1885-100000__23095.3459664763$1273090424$gmane$org@iolanthe.rowland.org>
References: <20100505190758.GG7139@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100505190758.GG7139@rakim.wolfsonmicro.main>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Paul Walmsley <paul@pwsan.com>, Geoff Smith <geoffx.smith@intel.com>, Brian Swetland <swetland@google.com>, linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>, Tejun Heo <tj@kernel.org>, linux-pm@lists.linux-foundation.org, Arjan van de Ven <arjan@infradead.org>, Matthew Garrett <mjg@redhat.com>
List-Id: linux-pm@vger.kernel.org

On Wed, 5 May 2010, Mark Brown wrote:

> > In short, I'm trying to get at how much information drivers _really_ 
> > need to have about the reason for a system suspend.
> 
> It's not exactly the *reason* that makes the difference, it's more that
> this aggressive use of suspend makes much more apparent a problem which
> might exist anyway for this sort of hardware.

Then the underlying problem should be solved -- hopefully in a nice, 
system-independent way.  But I'm still trying to understand exactly 
what that underlying problem _is_.

That means understanding when the codec needs to be shut down and when
it doesn't, and knowing how much of this information is available to
the driver.

> When we get runtime PM delviering similar power levels we'll sidestep
> the problem since we won't need to do a system wide suspend.

One the face of it, a runtime-PM solution would dictate that the
codec's driver ought to turn off the codec whenever the driver thinks
it isn't being used.  Ergo, if the driver didn't know when a call was
in progress, it would use runtime PM to turn off the codec during a
call.

For this reason I don't see how using runtime PM instead of suspend
blockers would solve anything.

Alan Stern
