From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 0/8] Suspend block api (version 6)
Date: Wed, 5 May 2010 20:07:58 +0100
Message-ID: <20100505190758.GG7139__27903.1097692952$1273090209$gmane$org@rakim.wolfsonmicro.main>
References: <20100505173337.GA1671@srcf.ucam.org>
	<Pine.LNX.4.44L0.1005051432120.1885-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1005051432120.1885-100000@iolanthe.rowland.org>
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
Cc: Paul Walmsley <paul@pwsan.com>, Geoff Smith <geoffx.smith@intel.com>, Brian Swetland <swetland@google.com>, linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>, Tejun Heo <tj@kernel.org>, linux-pm@lists.linux-foundation.org, Arjan van de Ven <arjan@infradead.org>, Matthew Garrett <mjg@redhat.com>
List-Id: linux-pm@vger.kernel.org

On Wed, May 05, 2010 at 02:36:10PM -0400, Alan Stern wrote:

> Clearly if there's a call in progress you don't want to shut the codec
> down.  Are there any other circumstances?  Would they vary according to
> whether the suspend was forced or opportunistic?

Aside from things where the CODEC is acting as a wake source (for stuff
like jack detect) which are obviously already handled it's basically
just when you've got an external audio source flowing through the device
which is going to continue to function during suspend.  Things like FM
radios, for example.  I'm not aware of non-audio examples that are use
case specific and don't just involve utterly ignoring AP suspends.

> In short, I'm trying to get at how much information drivers _really_ 
> need to have about the reason for a system suspend.

It's not exactly the *reason* that makes the difference, it's more that
this aggressive use of suspend makes much more apparent a problem which
might exist anyway for this sort of hardware.

When we get runtime PM delviering similar power levels we'll sidestep
the problem since we won't need to do a system wide suspend.
