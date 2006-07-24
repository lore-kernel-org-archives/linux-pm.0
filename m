From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: RFC -- updated Documentation/power/devices.txt
Date: Mon, 24 Jul 2006 16:44:51 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0607241610240.6386-100000@iolanthe.rowland.org>
References: <200607241011.15325.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200607241011.15325.david-b@pacbell.net>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

On Mon, 24 Jul 2006, David Brownell wrote:

> OK, _now_ we're discussing a semantic change.  ;)
> =

> I've added dev->power.power_state to the "this is deprecated" text, along
> with the sysfs power/state file.  IMO we can't realistically make that ch=
ange
> (removing the "is it nonzero" test) so long as the sysfs mechanism exists.

All right, I can accept that.  A fundamental problem is that

	echo -n 2 >/sys/devices/.../power/state

calls the driver's suspend() method, thereby telling it that the system as =

a whole is going to be suspended.  It's an unfortunate overloading of =

meanings.

Is it too early to start thinking about replacements for .../power/state
in individual subsystems?  Is that attribute file currently used anywhere
outside of PCMCIA (other than for testing)?  The sooner a safe replacement
is provided for such uses, the better.

> Once the sysfs mechanism goes away, there won't be much need for the mech=
anism.
> Only callers to dpm_runtime_*() would trigger any of the troublesome path=
s.
> The two callers are USB and PCMCIA, and I'm not sure they really need the=
 extra
> lock that's grabbed by the dpm_runtime_*() calls if there's no need to pr=
otect
> against that sysfs mechanism.

My autosuspend patches remove the dpm_runtime_* stuff from USB, leaving =

only PCMCIA.

The "extra lock" you refer to is dpm_sem?  I'm not quite sure why it's
there at all...  Apparently all it does is attempt to prevent runtime PM
requests from being made while a system suspend/resume transition is in
progress.  But it's futile to try doing this from within the core, if =

drivers are going to be managing device states internally.  (Not to =

mention that a task waiting on dpm_sem will cause the "freeze processes" =

procedure to fail.)

And it's not clear that we _do_ want to prevent runtime PM changes from =

occurring during a system sleep transition.  If a remote-wakeup request =

arrives while the system is suspending, it ought to be legal for the =

request to succeed and thereby abort the transition.

Alan Stern
