From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Async resume patch (was: Re: [GIT PULL] PM updates
	for 2.6.33)
Date: Wed, 9 Dec 2009 18:08:39 +0000
Message-ID: <20091209180839.GK9018__3335.94679036668$1260382193$gmane$org@sirena.org.uk>
References: <20091209164653.GI9018@sirena.org.uk>
	<Pine.LNX.4.44L0.0912091204550.4120-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0912091204550.4120-100000@iolanthe.rowland.org>
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
Cc: LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Dec 09, 2009 at 12:10:03PM -0500, Alan Stern wrote:
> On Wed, 9 Dec 2009, Mark Brown wrote:

> > Worst case is about a second for both resume and suspend which means two
> > seconds total but it's very hardware dependant.  

> A second seems awfully long.  What happens if audio isn't being played
> when the suspend occurs?  Can't you shorten things with no artifacts in
> that case?

For the affected hardware the problem is basically the same with or
without audio being played.  As I said in my reply to Linus this is
delays caused by ramping reference voltages.  These delays are
sufficiently long that the reference voltages have to be maintained all
the time so that they don't delay the start of audio streams which means
that having or not having an audio stream at suspend time doesn't affect
the reference voltage ramps since we don't turn them off when not in
use.  There is a win from other stuff having been shut off already, but
it's already being exploited.

On suspend the problem is the same as for resume - we need to ramp the
voltages quietly, this time down to zero.  We want to make sure they're
actually at zero to ensure that the ramp at resume time starts from a
known hardware state.
