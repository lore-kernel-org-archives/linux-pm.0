From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [patch/rft 2.6.17-rc2] swsusp resume must not
	device_suspend()
Date: Tue, 25 Apr 2006 10:32:56 +0200
Message-ID: <200604251032.57204.rjw@sisk.pl>
References: <200604241429.52022.david-b@pacbell.net>
	<200604250832.04065.nigel@suspend2.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7579291473897376=="
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
To: linux-pm@lists.osdl.org
Cc: Nigel Cunningham <nigel@suspend2.net>, David Brownell <david-b@pacbell.net>, linux-usb-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>
List-Id: linux-pm@vger.kernel.org

--===============7579291473897376==
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

On Tuesday 25 April 2006 00:31, Nigel Cunningham wrote:
> On Tuesday 25 April 2006 07:29, David Brownell wrote:
> > I've noticed a bunch of problem reports that go like this:
> >
> >  - boot system with some USB devices attached
> >  - echo disk > /sys/power/state
> >  - ... later resume ...
> >  - now those USB devices don't work right
> >  - unplug them/replug them, all is OK
> >
> > I recently observed this myself and tracked down one problem.  The solution
> > involves what kexec() does in much the same situation:  before starting a
> > new kernel, most hardware needs to be reset.  Today, swsusp will suspend it
> > instead, which is the root cause of the problem.
> 
> I'm not sure that it is. If we switched to not freezing devices, we'd then 
> cause issues with hardware such as hard drives. They need to know that we 
> just want things quiesced, mainly because we don't want to spin down drives.

That's right.  And kernel_restart_prepare(NULL) will make them spin down?
If so, they have to be treated in a special way.

OTOH I think at least some device driver writers assume that .resume() will
always be called after .suspend() which only is true for non-modular drivers
(or for modular drivers loaded from an initrd before resume).  The David's
change makes this assumptions explicitly invalid and that's why I said
I agreed with it.  However you're absolutely right about hard disks.

Greetings,
Rafael

--===============7579291473897376==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============7579291473897376==--
