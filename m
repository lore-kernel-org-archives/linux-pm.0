From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 0/8] Suspend block api (version 6)
Date: Wed, 5 May 2010 20:52:50 +0100
Message-ID: <20100505195249.GC11441__28457.8009312556$1273091066$gmane$org@sirena.org.uk>
References: <20100505185225.GA4411@srcf.ucam.org>
	<Pine.LNX.4.44L0.1005051511040.1885-100000@iolanthe.rowland.org>
	<20100505192208.GB5085@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20100505192208.GB5085@srcf.ucam.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Matthew Garrett <mjg@redhat.com>
Cc: Paul Walmsley <paul@pwsan.com>, Geoff Smith <geoffx.smith@intel.com>, Brian Swetland <swetland@google.com>, linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>, rebecca@android.com, Tejun Heo <tj@kernel.org>, linux-pm@lists.linux-foundation.org, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Wed, May 05, 2010 at 08:22:08PM +0100, Matthew Garrett wrote:
> On Wed, May 05, 2010 at 03:13:52PM -0400, Alan Stern wrote:

> > Does it know when a call is in progress?

> Perhaps you could infer that from the audio routing setup? I don't know 
> enough about embedded codecs.

Yes, you can providing we extract a bit more information from the
machine drivers and/or userspace - we already do our power management
based on paths.  The implementation I'd do here is to provide a facility
for marking some of the path endpoints as suspend insensitive then on
suspend leave those endpoints in their current state, force the other
endpoints off temporarily and re-run the standard power checks.

One thing I'll need to have a bit of a think about is if we need to
provide the ability to offer control to userspace for the suspend state
of path endpoints separately to their runtime state; I suspect the
answer is yes.
