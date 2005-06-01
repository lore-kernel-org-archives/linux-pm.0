From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC] Add some hooks to generic suspend code
Date: Wed, 01 Jun 2005 20:38:39 +1000
Message-ID: <1117622320.19020.36.camel@gaston>
References: <1117524577.5826.35.camel@gaston>
	<20050531101344.GB9614@elf.ucw.cz> <1117550660.5826.42.camel@gaston>
	<20050531212556.GA14968@elf.ucw.cz> <1117582309.5826.60.camel@gaston>
	<20050601081336.GA6693@elf.ucw.cz> <1117614857.19020.32.camel@gaston>
	<20050601090622.GB6693@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============70547120730068125=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20050601090622.GB6693@elf.ucw.cz>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>, Linux Kernel list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

--===============70547120730068125==
Content-Type: text/plain
Content-Transfer-Encoding: 7bit


> Well, but that means that we can get those "please don't use these
> callbacks if you can avoid it" messages, right :-).

Heh, well, I'll look if I can do something more specific to APM emu
there, maybe I'll find time to just switch over to a generic
implementation.

> Seems like lots of stuff is going to happen in pm post-2.6.12: I'd
> like to finally fix pm_message_t, too...

Yup. I have a couple of driver patches fixing things in this area too.

Ben.



--===============70547120730068125==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============70547120730068125==--
