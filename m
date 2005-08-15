From: Alan Cox <alan@redhat.com>
Subject: Re: Software suspend support in Fedora.
Date: Mon, 15 Aug 2005 09:07:40 -0400
Message-ID: <20050815130740.GA27039@devserv.devel.redhat.com>
References: <F7DC2337C7631D4386A2DF6E8FB22B3004311E37@hdsmsx401.amr.corp.intel.com>
	<20050731222751.GA28907@redhat.com>
	<20050803092301.GA1352@elf.ucw.cz>
	<20050813051642.GB11456@redhat.com>
	<20050815122000.GB15382@elf.ucw.cz>
	<20050815122927.GA15481@devserv.devel.redhat.com>
	<20050815123417.GA4003@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8287574318183677=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20050815123417.GA4003@elf.ucw.cz>
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
Cc: Alan Cox <alan@redhat.com>, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

--===============8287574318183677==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 15, 2005 at 02:34:17PM +0200, Pavel Machek wrote:
> Do you agree that suspend/resume PATA support is okay on system
> without ACPI enabled?

I believe so for PATA, well as much as anything in the PATA stack is "working".
Once you get into ACPI world it gets murkier and once you get into suspend to
ram its a total failure.

Alan


--===============8287574318183677==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============8287574318183677==--
