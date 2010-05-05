From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 0/8] Suspend block api (version 6)
Date: Wed, 5 May 2010 17:27:00 +0100
Message-ID: <20100505162700.GE7139__7581.67029493979$1273076985$gmane$org@rakim.wolfsonmicro.main>
References: <20100504235644.GA5231@opensource.wolfsonmicro.com>
	<Pine.LNX.4.44L0.1005051133210.1885-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1005051133210.1885-100000@iolanthe.rowland.org>
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
Cc: Paul Walmsley <paul@pwsan.com>, Geoff Smith <geoffx.smith@intel.com>, Brian Swetland <swetland@google.com>, linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>, Tejun Heo <tj@kernel.org>, linux-pm@lists.linux-foundation.org, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Wed, May 05, 2010 at 11:35:56AM -0400, Alan Stern wrote:
> On Wed, 5 May 2010, Mark Brown wrote:

> > In other words, the issue is that we run into situations where we need
> > an element of suspend control to go along with the opportunistic suspend
> > in order to allow some elements to be kept running - since suspend
> > blocking is taken suspend suppression seems like a reasonable term.

> Android must already include some solution to this problem.  Why not 
> use that solution more generally?

Not so much; at least for audio it's being handled with platform
specific bodges as far as I've seen so far.  If there had been a
standard way of doing this I'd have expected to see it in this patch
series.  The Google systems all use Qualcomm chipsets which aren't
affected by this since the audio CODEC is hidden from Linux and none of
the audio actually uses ALSA at all in the BSPs I looked at.

It's entirely possible I'm missing something here, everything I know has
come from either talking to users or trawling code on the internet.
