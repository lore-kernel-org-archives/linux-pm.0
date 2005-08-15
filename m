From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Software suspend support in Fedora.
Date: Mon, 15 Aug 2005 14:34:17 +0200
Message-ID: <20050815123417.GA4003@elf.ucw.cz>
References: <F7DC2337C7631D4386A2DF6E8FB22B3004311E37@hdsmsx401.amr.corp.intel.com>
	<20050731222751.GA28907@redhat.com>
	<20050803092301.GA1352@elf.ucw.cz>
	<20050813051642.GB11456@redhat.com>
	<20050815122000.GB15382@elf.ucw.cz>
	<20050815122927.GA15481@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============25122724721527767=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20050815122927.GA15481@devserv.devel.redhat.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Alan Cox <alan@redhat.com>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

--===============25122724721527767==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> > Suspend should work okay on PATA [what areas do you think it is
> > incomplete in?]. Recently, it was made to work on SATA, too
> 
> ACPI requires that the ACPI taskfiles are sent to the drivers. That isn't
> done. We then don't restore all the drive state correctly so parts of your
> disk can just "vanish".

We have had done normal boot, so drive should be in sane state. With
echo "shutdown"  > /sys/power/disk, ACPI is not even involved (it
thinks it is regular powerdown). With echo "platform" > ..., yes, we
tell ACPI, and that means that we should follow the specs. Maybe you
want to make "shutdown" the default, then...

Do you agree that suspend/resume PATA support is okay on system
without ACPI enabled?
								Pavel

-- 
if you have sharp zaurus hardware you don't need... you know my address

--===============25122724721527767==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============25122724721527767==--
