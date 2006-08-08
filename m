From: Nigel Cunningham <nigel@suspend2.net>
Subject: Re: swsusp and suspend2 like to overheat my laptop
Date: Wed, 9 Aug 2006 07:50:39 +1000
Message-ID: <200608090750.40111.nigel@suspend2.net>
References: <Pine.LNX.4.58.0608081612380.17442@gandalf.stny.rr.com>
Reply-To: nigel@suspend2.net
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1714971.rZ96oxlNLt";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S965023AbWHHVyn@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0608081612380.17442@gandalf.stny.rr.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Suspend2-devel@lists.suspend2.net, linux-pm@osdl.org, pavel@suse.cz
List-Id: linux-pm@vger.kernel.org

--nextPart1714971.rZ96oxlNLt
Content-Type: text/plain;
  charset="cp 850"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Steven.

On Wednesday 09 August 2006 07:40, Steven Rostedt wrote:
> A few months ago, I installed suspend2 on my laptop.  It worked great for
> a few days, when suddenly my laptop started to get very hot and the fan
> costantly went off, and then I started getting these:
>
> ---
> Message from syslogd@localhost at Tue Aug  8 16:08:53 2006 ...
> localhost kernel: CPU0: Temperature above threshold
>
> Message from syslogd@localhost at Tue Aug  8 16:08:53 2006 ...
> localhost kernel: CPU1: Temperature above threshold
>
>
> Message from syslogd@localhost at Tue Aug  8 16:08:53 2006 ...
> localhost kernel: CPU0: Running in modulated clock mode
>
> Message from syslogd@localhost at Tue Aug  8 16:08:53 2006 ...
> localhost kernel: CPU1: Running in modulated clock mode
> ---
>
> I even posted once since I thought I found the problem, but I was wrong.
> So I decided to remove Suspend2 and go back to the normal kernel.
>
> Recently, I've decided to try out swsusp.  Well, it has been working fine
> for almost a week now.  But unfortunately, I just started to have my fan
> go off constantly, and I'm getting the above messages again (hence why
> the date on the messages is today). Checking out the temp, it's going into
> the high 70C. That's not too bad, but it only happens when suspending
> every night instead of shutting down.
>
> This is a Thinkpad G41, with a P4HT and this is a unmodified 2.6.18-rc2
> kernel.  I guess I'll have to start shutting down again, and only suspend
> every so often.  But just thought I'd let the people of knowledge know.

The problem will be ACPI related, not particular to swsusp or Suspend2, whi=
ch =20
is why you're seeing it with both implementations. I would suggest that you=
=20
contact the ACPI guys, and also look to see whether there is a bios update=
=20
available and/or a DSDT override for your machine. The later will help if t=
he=20
problem is with your particular machine's ACPI support, the former if it's =
a=20
more general ACPI issue.

Regards,

Nigel
=2D-=20
See http://www.suspend2.net for Howtos, FAQs, mailing
lists, wiki and bugzilla info.

--nextPart1714971.rZ96oxlNLt
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBE2QcwN0y+n1M3mo0RAnE+AKDu0dL1oYismfHoGCTKWGI+qGlEQQCeL3Qf
mkIewjvFnxUzmJa6P9ytskc=
=hx6z
-----END PGP SIGNATURE-----

--nextPart1714971.rZ96oxlNLt--
