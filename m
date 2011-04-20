From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 7/9] PM / Runtime: Add generic
	clock	manipulation rountines for runtime PM
Date: Wed, 20 Apr 2011 12:57:39 +0100
Message-ID: <20110420115738.GA25571__43174.3901492611$1303300792$gmane$org@sirena.org.uk>
References: <201104130205.26988.rjw@sisk.pl> <201104170142.10723.rjw@sisk.pl>
	<20110419105836.GG9462@sirena.org.uk>
	<201104192335.34560.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201104192335.34560.rjw@sisk.pl>
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
Cc: Grant Likely <grant.likely@secretlab.ca>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, linux-sh@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tue, Apr 19, 2011 at 11:35:34PM +0200, Rafael J. Wysocki wrote:
> On Tuesday, April 19, 2011, Mark Brown wrote:

> > I've had similar thoughts with respect to the regulator API - I'd been
> > thinking of dealing with this by adding a notifier which subsystems
> > could build upon, in much the same way as already exists for the system
> > ssuspend and resume events.

> Well, I generally avoid using notifiers, because they lead to big functions
> that carry out many different tasks.

> That said, I think consolidation and reduction of duplicate code is all good,
> this way or another. :-)

Well, if you're comfortable with adding explicit regulator API hooks in
the code directly then I can just do that - I'd been thinking notifiers
since they mean you don't have to worry about what's going on with it
but if you're happy with making it explicit that's fine by me also.
