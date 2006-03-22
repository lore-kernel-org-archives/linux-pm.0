From: Pavel Machek <pavel@suse.cz>
Subject: Re: CE Linux Forum PM Requierments WiKi is available for
	review and comment.
Date: Wed, 22 Mar 2006 10:41:27 +0100
Message-ID: <20060322094127.GH14075@elf.ucw.cz>
References: <5389061B65D50446B1783B97DFDB392D2042B3@orsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============37755284245323217=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <5389061B65D50446B1783B97DFDB392D2042B3@orsmsx411.amr.corp.intel.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: "Gross, Mark" <mark.gross@intel.com>
Cc: linux-pm@osdl.org, PMWG@LIST.CELINUXFORUM.ORG, mli_tech@groups.osdl.org, celinux-dev@tree.celinuxforum.org
List-Id: linux-pm@vger.kernel.org

--===============37755284245323217==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> >Hmm, okay, yes, that would be useful for machines that can't do
> >throttling in hardware.
> 
> Even platforms that can throttle in hardware, it could make sense for to
> throttle the OS.  

Well, certainly. If you want to throttle to 1% and hardware can only
throttle to 30%, you need to do it in software.

> I think a person may want to throttle what work a laptop is doing as a
> function of being tethered or remaining battery life.  If all you want
> to do is finish those last few edits to a file before your battery cuts
> you off for the rest of a long flight, you will be very willing to shut
> down most (all?) processing that's not related to what you are editing.
> Cron jobs, automatic spell checking, sound subsystems, screen savers,
> pretty much anything not related to your editing will pull down your
> battery.  Most of these can be shut down from user mode, some things may
> be easier to implement robustly with some kernel support.  

That will be userland parts, I'd say.

> One idea is to extend the SCHED_BATCH idea to know about power state to
> avoid running some things when un-tethered or under low battery
> conditions.

Idle thread with realtime priority could do parts of what you want.

> >> >Thanks, Sharp!
> >>
> >> Who the heck is Sharp, and why do you always thank him?
> >
> >That's a signature... Sharp is Japaneese firm, maybe you've heard
> >about them :-). Send me handheld computer, and that line becomes
> >"Thanks, Intel" ;-).
> 
> Oh! Ok, that makes sense.  BTW careful what you wish for....

Well, I currently have collie (sharp sl-5500) for hacking, and spitz
(c-3000) for normal use. I would not mind hacking on something not as
obsolete.
								Pavel
-- 
Picture of sleeping (Linux) penguin wanted...

--===============37755284245323217==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============37755284245323217==--
