From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Problems with PM_FREEZE
Date: Thu, 29 Sep 2005 19:31:58 +0200
Message-ID: <20050929173158.GJ1990@elf.ucw.cz>
References: <Pine.LNX.4.44L0.0509291136210.4928-100000@iolanthe.rowland.org>
	<20050929171245.7012DE9E1F@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============72702952470569959=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20050929171245.7012DE9E1F@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
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
Cc: linux-pm@lists.osdl.org, ncunningham@cyclades.com
List-Id: linux-pm@vger.kernel.org

--===============72702952470569959==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> > Pavel is obviously right that the clean solution is to add a pm_message_t 
> > argument to resume().
> 
> I tend to disagree with that.  Changing every resume() method is
> not "clean", and it's more obvious to me that the pm_message
> semantics are (still) problematic.  Any argument to resume() would
> be encouraging fragile "if (came_from(X)) { ... }" style logic.

Alan wants to cut few miliseconds from suspend-to-disk. That's okay
with me, just add pm_message_t to resume(). If it is okay to use it in
specific driver is other question.

> Heck, there's still no way for drivers to know what the target
> system state is ... and THAT is a core issue here.
> 
> During FREEZE, the target system state is "something snapshottable".
> During SUSPEND, it's one of numerous variants of "low power" ... and
> device drivers can only guess which one it'll be.  (Is it an ACPI
> state?  S1, S3, S4?  Some non-ACPI platform state?)

Why does your driver need to know? Anyway, extending pm_message_t with
flags is okay with me.

> Case in point:  in some system low power states, drivers need to turn
> off certain clocks, and may not be able to support wakeup.  In others,
> drivers leave those clocks on, and can support wakeup.  But there is
> no way to figure out the target state given the pm_message ...

Eh? I do not see how knowing S1 vs. S3 vs. S4 help you here. It looks
more like "does user want to resume from that?" question.

								Pavel
-- 
if you have sharp zaurus hardware you don't need... you know my address

--===============72702952470569959==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============72702952470569959==--
