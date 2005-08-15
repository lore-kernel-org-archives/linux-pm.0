From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Software suspend support in Fedora.
Date: Mon, 15 Aug 2005 14:20:00 +0200
Message-ID: <20050815122000.GB15382@elf.ucw.cz>
References: <F7DC2337C7631D4386A2DF6E8FB22B3004311E37@hdsmsx401.amr.corp.intel.com>
	<20050731222751.GA28907@redhat.com>
	<20050803092301.GA1352@elf.ucw.cz>
	<20050813051642.GB11456@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============21842831032050181=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20050813051642.GB11456@redhat.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Dave Jones <davej@redhat.com>
Cc: alan@redhat.com, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

--===============21842831032050181==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

Actually, more responses to the fedora discussion:

No, swsusp can not yet resume from swap file. It would need to mount
the filesystem, first, and as you know that is not good idea. (Even
read-only mount replays journal on ext3, beware).

SMP support is way more experimental than UP support. It uses cpu
hotplug infrastructure, etc...

We have some ppc support, but it was not officially blessed by BenH,
and it it did not get much testing. No chance for ppc/SMP support for
example.

[Cc-ing alan cox]

Suspend should work okay on PATA [what areas do you think it is
incomplete in?]. Recently, it was made to work on SATA, too
[experimental, I'd say]. It did not eat data recently due to SATA/PATA
problems. It is broken on most SCSI drivers (well, probably all of
them), but it is likely that you'll "just" get a crash in such case.

								Pavel
-- 
if you have sharp zaurus hardware you don't need... you know my address

--===============21842831032050181==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============21842831032050181==--
