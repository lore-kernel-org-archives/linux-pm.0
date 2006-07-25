From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: RFC -- updated Documentation/power/devices.txt
Date: Tue, 25 Jul 2006 11:42:14 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0607251129160.6498-100000@iolanthe.rowland.org>
References: <200607241419.25976.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200607241419.25976.david-b@pacbell.net>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Dominik Brodowski <linux@dominikbrodowski.net>, David Brownell <david-b@pacbell.net>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

On Mon, 24 Jul 2006, David Brownell wrote:

> I think PCMCIA switched over to /sys/class/pcmcia_socket/.../card_pm_state
> a while back, though I'm not sure about the userspace tools.  They could =
be
> behind the times by a bit.

> > My autosuspend patches remove the dpm_runtime_* stuff from USB, leaving =

> > only PCMCIA.
> =

> Good, I was going to ask about that, except that I figured reading the
> patches would answer the question in a better way ... ;)
> =

> I have a patch that deprecates the dpm_runtime_*() calls; it's only trigg=
ered
> by USB and PCMCIA.  Not worth submitting IMO; fix the code first, then ju=
st
> remove those calls since /sys/.../power/state will be the only remaining =
caller.

Dominik, have you been following this?  Now's a good time to remove all
references to dpm_runtime_*() from the PCMCIA code.


> I thought dpm_sem was to protect the list manipulations that are currently
> substituting for a more dynamic tree traversal mechanism.  (But haven't
> actually looked recently...)

No, you're thinking of dpm_list_sem.

> > And it's not clear that we _do_ want to prevent runtime PM changes from =

> > occurring during a system sleep transition. =

> =

> Real runtime PM changes, of the type the core doesn't see or care about?
> Of course not.  But the fake ones via sysfs?  Yes, I think we do.  We
> don't want those happening in any case.

While userspace is frozen, requests can't arrive through sysfs.  So the =

only time dpm_sem might matter would be when someone on PPC uses the =

soon-to-be-deprecated sysfs mechanism during suspend-to-RAM!

Alan Stern
