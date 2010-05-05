From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 0/8] Suspend block api (version 6)
Date: Wed, 5 May 2010 21:09:41 +0100
Message-ID: <20100505200940.GD11441__2160.87608500875$1273094791$gmane$org@sirena.org.uk>
References: <20100505185225.GA4411@srcf.ucam.org>
	<Pine.LNX.4.44L0.1005051511040.1885-100000@iolanthe.rowland.org>
	<20100505192208.GB5085@srcf.ucam.org>
	<20100505195249.GC11441@sirena.org.uk>
	<20100505200243.GA6266@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20100505200243.GA6266@srcf.ucam.org>
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

On Wed, May 05, 2010 at 09:02:43PM +0100, Matthew Garrett wrote:

> One thing that's been mentioned before is that some vendors can swap the 
> kernel much more easily than they can swap userspace, with the added 
> constraint that they have little control over the bootloader. So if 
> there's a userspace interface, it may well also be helpful to provide a 
> kernel hook to allow the platform setup code to configure things. But 

Oh, there's definitely going to be a platform-specific hook to configure
things.  The platform needs to specify how the devices that make up the
audio subsystem are interconnected on the board, and that's done in
kernel since it depends on the hardware and can potentially lead to
physical damage if done incorrectly.

> otherwise, I think that'd work for audio - the only question is whether 
> we need it to be more generic.

Agreed.
