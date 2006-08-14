From: Dave Jones <davej@redhat.com>
Subject: Re: So, what's the status on the recent patches here?
Date: Mon, 14 Aug 2006 19:48:01 -0400
Message-ID: <20060814234801.GK30814@redhat.com>
References: <20060814200735.GC14099@kroah.com>
	<c948ef9077556626e85291ad716b7ddb@nomadgs.com>
	<20060814224623.GH30814@redhat.com>
	<221e3d51950d20642b3655617527dc52@nomadgs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <221e3d51950d20642b3655617527dc52@nomadgs.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Matthew Locke <matt@nomadgs.com>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

On Mon, Aug 14, 2006 at 04:24:33PM -0700, Matthew Locke wrote:

 > > If we're arriving any closer to consensus on whats mergable from the
 > > cpufreq side, and what needs more input, I'll find the time to review
 > > soon, but there still seems to be ongoing discussion which is why I
 > > decided to leave it sort itself out :)
 > =

 > I think we are at the stage of need more input on the last set of =

 > Eugeny's patches. (the ones I point to in my email)  The cpufreq =

 > patches, so far, are more for example.  We need a bit of work before =

 > they are ready for merging.  However, I would prefer to have your =

 > feedback now rather than later.

I gave them a quick lookover, and there are the to-be-expected minor
nits, but there's something more fundamental that I'm still not getting.

This adds a whole bunch of new code, and doesn't seem to make any
existing code any simpler (to me at least).  From a cpufreq point of view,
what does adding this buy us? What problem do we have today that is
being solved by all this?

Every explanation of powerop I've seen so far dives into microdetails,
whilst the 10,000ft view has always passed me by other than "this is
what we've had in the embedded world".

The diagram at http://lists.osdl.org/pipermail/linux-pm/2006-August/003196.=
html
also confuses me.  I was under the impression that powerop was adding addit=
ional
userspace interfaces.  If we're not changing how things from a userspace
point of view, we're churning a lot of kernel code,.. why?

Clue me in here, I'm feeling thick.

		Dave

-- =

http://www.codemonkey.org.uk
