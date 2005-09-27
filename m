From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Problems with PM_FREEZE
Date: Tue, 27 Sep 2005 22:32:07 +0200
Message-ID: <20050927203207.GE2040@elf.ucw.cz>
References: <20050927195833.GA2040@elf.ucw.cz>
	<Pine.LNX.4.44L0.0509271621270.1014-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============14176979256819955=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.44L0.0509271621270.1014-100000@iolanthe.rowland.org>
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
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

--===============14176979256819955==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> > We can add a hint to pm_message_t. But for "full resume", we really
> > don't know if devices are only FROZEN or if they need full reinit.
> > 
> > So you may get info "only frozen" and "maybe frozen, maybe it was
> > powered down"; if you think that helps the drivers, just add a field
> > to pm_message_t (flags), and add this as a first flag.
> 
> Okay.  Can you tell me where is the code that resumes all the devices once
> the memory image is loaded?

kernel/power/swsusp.c swsusp_suspend() does device_power_up(). and
disk.c: pm_suspend_disk(). Use in_suspend() variable.

Ouch, but device_power_up and device_resume() do not take pm_message_t
parameter. They probably should. But the patch will be quite big.

								Pavel
-- 
if you have sharp zaurus hardware you don't need... you know my address

--===============14176979256819955==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============14176979256819955==--
