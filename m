From: David Brownell <david-b@pacbell.net>
Subject: Re: RFC -- updated Documentation/power/devices.txt
Date: Mon, 24 Jul 2006 14:19:25 -0700
Message-ID: <200607241419.25976.david-b@pacbell.net>
References: <Pine.LNX.4.44L0.0607241610240.6386-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.44L0.0607241610240.6386-100000@iolanthe.rowland.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

On Monday 24 July 2006 1:44 pm, Alan Stern wrote:

> Is it too early to start thinking about replacements for .../power/state
> in individual subsystems? =


I don't think so.  You had one for USB, but Greg didn't want to merge it ye=
t.

So far as I know, there is no current valid use of the .../power/state file=
s.
If I'm missing something, that patch to make it into a (deprecated) config
option will help us learn some interesting things.


> Is that attribute file currently used anywhere =

> outside of PCMCIA (other than for testing)?  The sooner a safe replacement
> is provided for such uses, the better.

I think PCMCIA switched over to /sys/class/pcmcia_socket/.../card_pm_state
a while back, though I'm not sure about the userspace tools.  They could be
behind the times by a bit.


> > Once the sysfs mechanism goes away, there won't be much need for the me=
chanism.
> > Only callers to dpm_runtime_*() would trigger any of the troublesome pa=
ths.
> > The two callers are USB and PCMCIA, and I'm not sure they really need t=
he extra
> > lock that's grabbed by the dpm_runtime_*() calls if there's no need to =
protect
> > against that sysfs mechanism.
> =

> My autosuspend patches remove the dpm_runtime_* stuff from USB, leaving =

> only PCMCIA.

Good, I was going to ask about that, except that I figured reading the
patches would answer the question in a better way ... ;)

I have a patch that deprecates the dpm_runtime_*() calls; it's only trigger=
ed
by USB and PCMCIA.  Not worth submitting IMO; fix the code first, then just
remove those calls since /sys/.../power/state will be the only remaining ca=
ller.

 =

> The "extra lock" you refer to is dpm_sem?  I'm not quite sure why it's
> there at all...  Apparently all it does is attempt to prevent runtime PM
> requests from being made while a system suspend/resume transition is in
> progress.  But it's futile to try doing this from within the core, if =

> drivers are going to be managing device states internally.  (Not to =

> mention that a task waiting on dpm_sem will cause the "freeze processes" =

> procedure to fail.)

I thought dpm_sem was to protect the list manipulations that are currently
substituting for a more dynamic tree traversal mechanism.  (But haven't
actually looked recently...)


> And it's not clear that we _do_ want to prevent runtime PM changes from =

> occurring during a system sleep transition. =


Real runtime PM changes, of the type the core doesn't see or care about?
Of course not.  But the fake ones via sysfs?  Yes, I think we do.  We
don't want those happening in any case.


> If a remote-wakeup request  =

> arrives while the system is suspending, it ought to be legal for the =

> request to succeed and thereby abort the transition.

Agreed.  Not that we'd always want to do it quite that way (surely some
hardware will cause pain!), but it should certainly be a works-well option.

- Dave
