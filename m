From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC] Add some hooks to generic suspend code
Date: Wed, 1 Jun 2005 10:13:36 +0200
Message-ID: <20050601081336.GA6693@elf.ucw.cz>
References: <1117524577.5826.35.camel@gaston>
	<20050531101344.GB9614@elf.ucw.cz>
	<1117550660.5826.42.camel@gaston>
	<20050531212556.GA14968@elf.ucw.cz>
	<1117582309.5826.60.camel@gaston>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============67092198558300575=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <1117582309.5826.60.camel@gaston>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>, Linux Kernel list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

--===============67092198558300575==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> > Why do you need it? Do you initiate suspend without userland asking
> > you to?
> 
> Because there is an existing API, via /dev/apm_bios, and that's all X
> understands ! And because I've always done that ;)

Try stopping doing that ;-).

[On i386, we do not emulate apm, and it still works. Reason is that we
switch to other console before suspend, so X has to give up
framebuffer control, anyway.]

								Pavel

--===============67092198558300575==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============67092198558300575==--
