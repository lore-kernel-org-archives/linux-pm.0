From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 0/8] Suspend block api (version 6)
Date: Wed, 5 May 2010 22:57:11 +0100
Message-ID: <20100505215711.GA4838__41142.9398613565$1273096738$gmane$org@opensource.wolfsonmicro.com>
References: <20100505185225.GA4411@srcf.ucam.org>
	<20100505195534.GD18762@thunk.org>
	<20100505202637.GH7139@rakim.wolfsonmicro.main>
	<201005052244.03225.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201005052244.03225.rjw@sisk.pl>
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
Cc: Paul Walmsley <paul@pwsan.com>, tytso@mit.edu, Geoff Smith <geoffx.smith@intel.com>, Brian Swetland <swetland@google.com>, linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>, rebecca@android.com, Tejun Heo <tj@kernel.org>, linux-pm@lists.linux-foundation.org, Arjan van de Ven <arjan@infradead.org>, Matthew Garrett <mjg@redhat.com>
List-Id: linux-pm@vger.kernel.org

On Wed, May 05, 2010 at 10:44:03PM +0200, Rafael J. Wysocki wrote:

> To me, the above may be summarized that in your opinion some components of
> the system will generally need to stay powered when it's suspended
> opportunistically, so we need an interface to specify which components they are.
> Is that correct?

Yes, though I think I'd be inclined to treat the problem orthogonally to
opportunistic suspend to allow more flexibility in use and since
treating it as part of opportunistic suspend would imply that there's
some meaningful difference between the end result of that and a manual
suspend which AIUI there isn't.
