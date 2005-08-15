From: Nigel Cunningham <ncunningham@cyclades.com>
Subject: Re: Software suspend support in Fedora.
Date: Tue, 16 Aug 2005 09:23:39 +1000
Message-ID: <1124148218.5183.282.camel@localhost>
References: <F7DC2337C7631D4386A2DF6E8FB22B3004311E37@hdsmsx401.amr.corp.intel.com>
	<20050731222751.GA28907@redhat.com> <20050803092301.GA1352@elf.ucw.cz>
	<20050813051642.GB11456@redhat.com> <20050815122000.GB15382@elf.ucw.cz>
Reply-To: ncunningham@cyclades.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============063675898223133798=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20050815122000.GB15382@elf.ucw.cz>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Pavel Machek <pavel@ucw.cz>
Cc: alan@redhat.com, Dave Jones <DaveJ@redhat.com>, Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

--===============063675898223133798==
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi.

On Mon, 2005-08-15 at 22:20, Pavel Machek wrote:
> Hi!
> 
> Actually, more responses to the fedora discussion:
> 
> No, swsusp can not yet resume from swap file. It would need to mount
> the filesystem, first, and as you know that is not good idea. (Even
> read-only mount replays journal on ext3, beware).

Pavel, could you please stop saying that? What it really needs is to
record the devices and blocks to read from in the image header. Suspend2
has done this for ages and it does work, as you know.

> SMP support is way more experimental than UP support. It uses cpu
> hotplug infrastructure, etc...

It works fine. Hotplug cpu was a little flakey for a while, but it's up
to standard now. I've recently switched from the old method after giving
it good testing, and the only problems I've seen have been in
combination with dynticks, and there the fault was dynticks, not
hotplug.

> We have some ppc support, but it was not officially blessed by BenH,
> and it it did not get much testing. No chance for ppc/SMP support for
> example.
> 
> [Cc-ing alan cox]
> 
> Suspend should work okay on PATA [what areas do you think it is
> incomplete in?]. Recently, it was made to work on SATA, too
> [experimental, I'd say]. It did not eat data recently due to SATA/PATA
> problems. It is broken on most SCSI drivers (well, probably all of
> them), but it is likely that you'll "just" get a crash in such case.

I'm always bemused when I see reports of problems with SATA. I've been
using it for 18 months with suspending and it's always just worked.
Maybe I just have a good chipset.

Regards,

Nigel

-- 
Evolution.
Enumerate the requirements.
Consider the interdependencies.
Calculate the probabilities.


--===============063675898223133798==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============063675898223133798==--
