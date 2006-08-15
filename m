From: Dave Jones <davej@redhat.com>
Subject: Re: So, what's the status on the recent patches here?
Date: Mon, 14 Aug 2006 23:03:16 -0400
Message-ID: <20060815030316.GN30814@redhat.com>
References: <20060814200735.GC14099@kroah.com>
	<c948ef9077556626e85291ad716b7ddb@nomadgs.com>
	<20060814224623.GH30814@redhat.com>
	<221e3d51950d20642b3655617527dc52@nomadgs.com>
	<20060814234801.GK30814@redhat.com>
	<20060815010020.GA14251@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <20060815010020.GA14251@kroah.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Greg KH <greg@kroah.com>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

On Mon, Aug 14, 2006 at 06:00:20PM -0700, Greg Kroah-Hartman wrote:
 =

 > > This adds a whole bunch of new code, and doesn't seem to make any
 > > existing code any simpler (to me at least).  From a cpufreq point of v=
iew,
 > > what does adding this buy us? What problem do we have today that is
 > > being solved by all this?
 > > =

 > > Every explanation of powerop I've seen so far dives into microdetails,
 > > whilst the 10,000ft view has always passed me by other than "this is
 > > what we've had in the embedded world".
 > > =

 > > The diagram at http://lists.osdl.org/pipermail/linux-pm/2006-August/00=
3196.html
 > > also confuses me.  I was under the impression that powerop was adding =
additional
 > > userspace interfaces.  If we're not changing how things from a userspa=
ce
 > > point of view, we're churning a lot of kernel code,.. why?
 > > =

 > > Clue me in here, I'm feeling thick.
 > =

 > You're not alone, I really don't get it either.
 > =

 > But I guess we'll just wait for the next round of unified patches and
 > then go from there.

I have concerns over this because the cpufreq code has gotten pretty damned
complicated in parts, and it's really impacting our ability to fix bugs in
the thing.  Every time something new falls out we have to play archaeologist
looking up a lot of ancient changes to figure why we did x in y way, and why
z didn't work, and it's getting quite unfun.  In a lot of cases even the
original authors of the problematic parts can't remember their reasoning.

I've got a fairly good handle on most parts, but things like the recent
cpufreq vs hotplug-cpu fiasco (which went in via some other route rather th=
an the
cpufreq tree) really threw me a curve-ball, and no-one other than Linus, An=
drew
and myself stepped up to the plate to fix that mess, despite there being
the better part of a half dozen people who had hacked on it during its inte=
gration.

		Dave

-- =

http://www.codemonkey.org.uk
