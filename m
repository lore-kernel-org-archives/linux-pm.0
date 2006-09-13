From: David Brownell <david-b@pacbell.net>
Subject: Re: community PM requirements/issues and PowerOP [Was:
	Re: So, what's the status on the recent patches here?]
Date: Tue, 12 Sep 2006 21:22:09 -0700
Message-ID: <20060913042209.10DEC1A0082@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
References: <450516E8.9010403@gmail.com>
	<20060911082025.GD1898@elf.ucw.cz> <450530BD.8090101@gmail.com>
	<20060911193637.GA11901@elf.ucw.cz>
	<c728abebb17f975089390dd3f87069af@nomadgs.com>
	<20060911200636.GC11901@elf.ucw.cz> <20060911200936.GA12433@elf.ucw.cz>
	<6d5d95c88706be8a338f703579cd62b9@nomadgs.com>
	<20060911210634.GI11901@elf.ucw.cz>
	<c63579dda747a35a5ba48ba5495b3d72@nomadgs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <c63579dda747a35a5ba48ba5495b3d72@nomadgs.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: pavel@ucw.cz, matt@nomadgs.com, linux@dominikbrodowski.net, greg@kroah.com, davej@redhat.com
Cc: linux-pm@lists.osdl.org, scott.preece@motorola.com
List-Id: linux-pm@vger.kernel.org

Hi Matt,

> From matt@nomadgs.com  Mon Sep 11 14:56:58 2006
>
> Greg, Pavel, Dominik, Dave J and Dave B,
>
> I would like to get a plan in place for acceptance with the power =

> management guys before we move this to lkml.  I propose that we submit =

> the current set of PowerOP patches plus final few changes (from Greg's =

> comments and a Documentation/ file).  The patches do not affect anyone =

> else.  The sysfs interface is optional.  If necessary Eugeny and I will =

> maintain userspace interface patches outside the mainline for now.  =

> Will any of the power management maintainers ACK this plan and then ACK =

> the patches?  If no one here is willing to ACK, then I don't see what =

> will change by submitting to lkml.

The Linux-PM list booted me off itself for a while, and I just got
back on and haven't gotten through the backlog yet.  Right now the
distinctions and relationships between any of the "recent patches"
and system-wide mechanisms like

    - lowpower idle tasks;

    - multiple run states ... cpufreq doing an inadequte subset,
      even if you're only interested in CPUs;

    - multiple sleep states ... /sys/power/state listing "standby"
      and/or "mem" (kind of weak for embedded systems) and "disk"
      (which is checkpoint/resume, not really sleep);

are not fully evident to me, so acking anything seems premature.
Plus there's an "ACPI way" to do so much of that, which doesn't
much help most non-x86 systems.

I thought I saw patches generalizing both sleep and run states
(separate patch sets!) ... plus a good comment from Greg that
a short (!) "elevator pitch" seemed to be lacking.

- Dave
