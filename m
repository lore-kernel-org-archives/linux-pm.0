From: Matthew Garrett <mjg@redhat.com>
Subject: Re: [PATCH 0/8] Suspend block api (version 6)
Date: Wed, 5 May 2010 21:02:43 +0100
Message-ID: <20100505200243.GA6266__4192.71481591767$1273091075$gmane$org@srcf.ucam.org>
References: <20100505185225.GA4411@srcf.ucam.org>
	<Pine.LNX.4.44L0.1005051511040.1885-100000@iolanthe.rowland.org>
	<20100505192208.GB5085@srcf.ucam.org>
	<20100505195249.GC11441@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20100505195249.GC11441@sirena.org.uk>
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
Cc: Paul Walmsley <paul@pwsan.com>, Geoff Smith <geoffx.smith@intel.com>, Brian Swetland <swetland@google.com>, linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>, rebecca@android.com, Tejun Heo <tj@kernel.org>, linux-pm@lists.linux-foundation.org, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Wed, May 05, 2010 at 08:52:50PM +0100, Mark Brown wrote:
> On Wed, May 05, 2010 at 08:22:08PM +0100, Matthew Garrett wrote:
> > Perhaps you could infer that from the audio routing setup? I don't know 
> > enough about embedded codecs.
> 
> Yes, you can providing we extract a bit more information from the
> machine drivers and/or userspace - we already do our power management
> based on paths.  The implementation I'd do here is to provide a facility
> for marking some of the path endpoints as suspend insensitive then on
> suspend leave those endpoints in their current state, force the other
> endpoints off temporarily and re-run the standard power checks.

One thing that's been mentioned before is that some vendors can swap the 
kernel much more easily than they can swap userspace, with the added 
constraint that they have little control over the bootloader. So if 
there's a userspace interface, it may well also be helpful to provide a 
kernel hook to allow the platform setup code to configure things. But 
otherwise, I think that'd work for audio - the only question is whether 
we need it to be more generic.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
