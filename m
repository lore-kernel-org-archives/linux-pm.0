From: Matthew Wilcox <matthew@wil.cx>
Subject: Re: RFC: PNP: do not stop/start devices in
	suspend/resume path
Date: Wed, 5 Dec 2007 11:50:13 -0700
Message-ID: <20071205185012.GA27526__12050.4561848522$1196880786$gmane$org@parisc-linux.org>
References: <4745F77C.7040402@gmail.com> <47511751.2010707@gmail.com>
	<47514CE2.3000600@gmail.com>
	<200712051124.18852.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200712051124.18852.bjorn.helgaas@hp.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Jiri Slaby <jirislaby@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, drzeus@drzeus.cx, Matthieu Castet <castet.matthieu@free.fr>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Wed, Dec 05, 2007 at 11:24:18AM -0700, Bjorn Helgaas wrote:
> This means we will not disable the device and release its
> resources.  The driver suspend method typically does not release
> its resources in the suspend path.  For example, if we have:
> 
>   03f8-03ff : 00:06
>     03f8-03ff : serial
> 
> pnp_stop_dev() would release the 00:06 region, which still
> has a child.  This causes a warning from __release_resource
> and corrupts /proc/ioports.

So, I put the warning in there because I genuinely didn't know if we
were doing this, and if so what the semantics should be.

I'm quite happy to see resources with children being released -- I just
want to know what we should do with those children.  As the first person
to come across this problem, I think you get to decide the semantics.

It seems to me from this description that all we want to do is reparent
the children -- which is easy enough to do; just a matter of twizzling
all the ->parent pointers of the children; the ->sibling of the resource
before the one being released and the ->sibling of the last child of the
one being released.

If you think it's a genuine bug that happens to have been caught by this
check, I'm happy to see the check being useful, and we don't need to
allow the removal of resources.

The only thing is, if you're going to be re-acquiring these resources
upon resume, you'll need to use insert_resource() instead of
request_region() because the child will now be in that spot.

-- 
Intel are signing my paycheques ... these opinions are still mine
"Bill, look, we understand that you're interested in selling us this
operating system, but compare it to ours.  We can't possibly take such
a retrograde step."
