From: Pavel Machek <pavel@suse.cz>
Subject: Re: CE Linux Forum PM Requierments WiKi is available for
	review and comment.
Date: Tue, 21 Mar 2006 21:36:21 +0100
Message-ID: <20060321203621.GH3929@elf.ucw.cz>
References: <5389061B65D50446B1783B97DFDB392D13D1B6@orsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============99940092754806154=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <5389061B65D50446B1783B97DFDB392D13D1B6@orsmsx411.amr.corp.intel.com>
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

--===============99940092754806154==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> >4. device power management seems to be missing. What is "OS
> >throttling"?
> >
> 
> I'll add some stuff on device power management.  
> 
> OS throttling is the pacing of work the OS is allowed to do to maintain
> some power or thermal budget constraints.

Hmm, okay, yes, that would be useful for machines that can't do
throttling in hardware.

> >7.1 if your hardware can damage itself or hurt user *FIX YOUR
> >HARDWARE*! Will you argue that overcharging li-ion to explosion is also
> ok?
> 
> Having your hardware catch on fire or exploding is not ok.  I'll
> re-write this a bit to avoid the inference of buggy hardware.   The
> point is that software support is needed to do a good job for some of
> these applications.
> 
> However; Having the OS help avoid deep discharging your cell phone or
> I-Pod battery because of some bug would not be unreasonable.

Do li-ion batteries really care about deep discharging in
cellphone/ipod applications? I thought single-li-ion solutions don't
mind being deeply discharged.

(In fact, that's what I'm now doing with li-ion in sharp sl-5500 --
collie; I'm running without any powermanagement, so it dies when
battery can no longer support CPU. I guess that's counts as deep discharge.)

> Neither is having OS support running on hardware that is built without
> active cooling that avoids the HW doing an emergency power off and
> loosing the users data.

NMI watchdog / SMM comes to mind. But SMM is unlikely to be option on
Arm machines.

> >--
> >Thanks, Sharp!
> 
> Who the heck is Sharp, and why do you always thank him?

That's a signature... Sharp is Japaneese firm, maybe you've heard
about them :-). Send me handheld computer, and that line becomes
"Thanks, Intel" ;-).
							Pavel
-- 
Picture of sleeping (Linux) penguin wanted...

--===============99940092754806154==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============99940092754806154==--
