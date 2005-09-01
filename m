From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: PowerOP Take 2 1/3: ARM OMAP1 platform support
Date: Thu, 1 Sep 2005 07:41:09 -0500
Message-ID: <EA12F909C0431D458B9D18A176BEE4A501E0AA90@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4018782433133461=="
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-class: urn:content-classes:message
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: David Brownell <david-b@pacbell.net>, tpoynor@mvista.com, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

--===============4018782433133461==
Content-class: urn:content-classes:message
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8bit

> Again, PERDIV changes would need to involve clock.c to cascade
> the changes through the clock tree.  Change PERDIV and you'll
> need to recalculate the peripheral clocks that derive from it...
> better not do it while an I/O operation is actively using it!

As a note, it is not clear how well the current clock.c maps to proper
switching anyway.  For OMAP2 there defiantly have been a couple points
which needed consideration.

Current OMAP2 processors are such that the many of the major system
clocks and their dividers 'need' to be programmed as a set else the
system won't function properly.  This kind of thing fits very well into
the operating point scheme.   Some lower level clocks do need
rebalancing based on the changes, DPM's current notifier scheme works
well there beneath the operating points.

This set nature of dividers comes from the fact that many of the chip
clocks are all completely balanced and running synchronously.  In the
current clock.c idea, you can walk the tree and program a clock
independently of other clocks not in your sub tree.  This is will not
work straight off for the fundamental clocks.  OMAP1 had similar but
different ratio constraints which aren't still all that well handled in
code.  For OMAP1 the basic scheme started out as asynchronous clocks
with fifos at clock boundaries, this injected a bit more flexibility as
compared OMAP2 which depends on fixed rations and uses phase
synchronizers.

Regards,
Richard W.



--===============4018782433133461==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============4018782433133461==--
