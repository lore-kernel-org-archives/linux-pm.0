From: David Brownell <david-b@pacbell.net>
Subject: Re: RE: on-ness
Date: Mon, 24 Apr 2006 16:21:56 -0700
Message-ID: <200604241621.56943.david-b@pacbell.net>
References: <CFF307C98FEABE47A452B27C06B85BB63590D8@hdsmsx411.amr.corp.intel.com>
	<200604241404.41122.david-b@pacbell.net>
	<20060424213245.GP3386@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4175602679936008=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060424213245.GP3386@elf.ucw.cz>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: linux-pm@lists.osdl.org
Cc: Dominik Brodowski <linux@dominikbrodowski.net>
List-Id: linux-pm@vger.kernel.org

--===============4175602679936008==
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


> Ok, "off-with-WOL" was example. Hopefully there's better example. 

Sure.  That's part of why I asked about "off", since it's easy to
have several states that could be described that way ... "reset",
"powerdown", and "unclocked" for starters ("on" plus three); or
for PCI, states other than PCI_D0.  Multiple "on" states could
be identified on some devices.

- Dave


--===============4175602679936008==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============4175602679936008==--
