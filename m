From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 0/8] Suspend block api (version 6)
Date: Thu, 6 May 2010 00:05:01 +0200
Message-ID: <201005060005.01215.rjw__26711.503629531$1273098238$gmane$org@sisk.pl>
References: <20100505185225.GA4411@srcf.ucam.org>
	<201005052244.03225.rjw@sisk.pl>
	<20100505215711.GA4838@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100505215711.GA4838@opensource.wolfsonmicro.com>
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
Cc: Paul Walmsley <paul@pwsan.com>, tytso@mit.edu, Geoff Smith <geoffx.smith@intel.com>, Brian Swetland <swetland@google.com>, linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>, rebecca@android.com, Tejun Heo <tj@kernel.org>, linux-pm@lists.linux-foundation.org, Arjan van de Ven <arjan@infradead.org>, Matthew Garrett <mjg@redhat.com>
List-Id: linux-pm@vger.kernel.org

On Wednesday 05 May 2010, Mark Brown wrote:
> On Wed, May 05, 2010 at 10:44:03PM +0200, Rafael J. Wysocki wrote:
> 
> > To me, the above may be summarized that in your opinion some components of
> > the system will generally need to stay powered when it's suspended
> > opportunistically, so we need an interface to specify which components they are.
> > Is that correct?
> 
> Yes, though I think I'd be inclined to treat the problem orthogonally to
> opportunistic suspend to allow more flexibility in use and since
> treating it as part of opportunistic suspend would imply that there's
> some meaningful difference between the end result of that and a manual
> suspend which AIUI there isn't.

No, there's no such difference.

So, gnerenally, we may need a mechanism to specify which components of the
system need to stay powered while the whole system is suspended (in addition to
wakeup devices, that is).

That certainly I can agree with.

I'm not sure, however, in what way this is relevant to the $subject patchset.

Rafael
