From: David Brownell <david-b@pacbell.net>
Subject: Re: [patch/rft 2.6.17-rc2] swsusp resume must not
	device_suspend()
Date: Tue, 25 Apr 2006 08:56:05 -0700
Message-ID: <200604250856.06038.david-b@pacbell.net>
References: <200604241429.52022.david-b@pacbell.net>
	<200604250832.04065.nigel@suspend2.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============021762301847251697=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200604250832.04065.nigel@suspend2.net>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Nigel Cunningham <nigel@suspend2.net>
Cc: Andrew Morton <akpm@osdl.org>, linux-pm@lists.osdl.org, linux-usb-devel@lists.sourceforge.net
List-Id: linux-pm@vger.kernel.org

--===============021762301847251697==
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Monday 24 April 2006 3:31 pm, Nigel Cunningham wrote:
> >
> > I recently observed this myself and tracked down one problem.  The solution
> > involves what kexec() does in much the same situation:  before starting a
> > new kernel, most hardware needs to be reset.  Today, swsusp will suspend it
> > instead, which is the root cause of the problem.
> 
> I'm not sure that it is. If we switched to not freezing devices, we'd then 
> cause issues with hardware such as hard drives. They need to know that we 
> just want things quiesced, mainly because we don't want to spin down drives.

Ignore potential performance issue for a minute -- it didn't spin anything
down in my testing so far, anyway! -- and focus on correctness instead.

How could it be possible to hand a device to driver with resume() and not
have it in one of the two defined states for that?  Either (a) powerup reset,
just like during resume from STR with especially aggressive hardware; or
else (b) the state suspend() left it in, ready for no-data-lossage resume()?


> It seems to me that the right solution might be for these usb devices to 
> treat a resume from a freeze as an indication that hardware should be reset.

I don't much like that model.  It creates more special cases in drivers (not
just USB), and redefines the "freeze" thing to be more than just "quiescede".
Every special case that gets added is a breeding ground for more bugs.

Also, what about the resume-from-freeze that _every_ device does during swsusp
suspend?  The kernel is still resuming every device, not just the ones needed
to write the suspend partition.

- Dave



--===============021762301847251697==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============021762301847251697==--
