From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: what can we do with frozen processes (or: calling
	sync with processes frozen)
Date: Mon, 19 Mar 2007 11:46:17 +0100
Message-ID: <200703191146.17503.rjw@sisk.pl>
References: <1174173718.13027.0.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1174173718.13027.0.camel@johannes.berg>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-pm <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

Hi,

On Sunday, 18 March 2007 00:21, Johannes Berg wrote:
> Hi,
> =

> When on vacation I was doing a bit more stuff w/o battery and noticed
> that I after my patches to implement proper pm_ops for PMU-based
> machines the machine would hang during suspend. Now on the way back I'm
> sitting in a train and it's working again. Couldn't really be the lower
> atmospheric pressure causing it ;) So I looked again and realised that
> when writing those patches I thought doing sys_sync() in the ->prepare
> callback would be a good idea. It is, as it turns out, not such a great
> idea at all, right now anyway.

Well, it's not a good idea indeed.

> When laptop mode is enabled [1], xfs will, upon getting a sync, try to
> wake up one of it's tasks and then wait for something that task does (as
> far as I can tell.) Even though I carry the patch to make xfs's
> workqueues non-freezable this event doesn't seem to happen when
> processes are frozen and so the system hangs. Not sure why that is but
> it isn't really the point right now, read on.

XFS uses more kernel threads that are frozen (see
http://lxr.free-electrons.com/source/fs/xfs/linux-2.6/xfs_buf.c?a=3Dx86_64#=
1700)

> I have now removed the call to sys_sync() to double-verify and that has
> indeed cured the problem, but the bigger question really is whether it
> should be safe to call it or not [2], especially given that it would
> make sense to call it when processes can no longer submit IO.

We call sys_sync() in freeze_processes() _before_ kernel threads are frozen.
I don't think it's safe to call it any time later before the kernel threads=
 are
thawed.

> The real thing we should be doing is think about a whole range of things
> you can do in the kernel and then think about whether they should be
> allowed to be done in the various stages. A lot of these things are at
> least somewhat documented for early boot stages (and you get into
> trouble when you do it wrong) but it seems that many developers never
> suspend their machines

True, but they should do this.

> so this needs to be documented in a more explicit =

> way rather than just breaking when you try (bootup is part of regular
> testing routine in an obvious way that suspend isn't)
> =

> Yup, this is a lot of hard work, but it could be done gradually as we
> run into these problems.
> =

> Back to the specific sys_sync() issue, what do people feel is
> appropriate? Should XFS get into even more trouble? It seems not to be
> able to guarantee full sync when processes are frozen right now, at
> least not the way sync is currently implemented.

See above.

I think at least some filesystems use freezable kernel threads and will
block if you ask them to sync after these threads have been frozen.

Greetings,
Rafael
