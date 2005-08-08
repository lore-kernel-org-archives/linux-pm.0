From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: Re: Runtime PM and device locking
Date: Mon, 8 Aug 2005 16:15:57 -0500
Message-ID: <EA12F909C0431D458B9D18A176BEE4A5017B6CC0@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0044996515044861685=="
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
To: Alan Stern <stern@rowland.harvard.edu>, Adam Belay <ambx1@neo.rr.com>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

--===============0044996515044861685==
Content-class: urn:content-classes:message
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8bit

> (Not to mention the
> fact that in any particular case we never need both pre- and post-
> notifications.)

For voltage and frequency scaling in embedded devices we defiantly have
used both pre and post notifications.

Tell drivers to 'prepare' for change.  This in some cases means
suspending master peripheral DMA operations to DDR.  Next the power
manager does the DVFS switch.  Finally a "post" notification is sent
which allows master drivers to resume their DMA accesses.

Some devices are part of smarter busses which have some notion of these.
Others don't.  In general you provide the list entries in the generic
structure.  Whether a specific device registers a local call back is
something else all together.

Regards,
Richard W. 



--===============0044996515044861685==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============0044996515044861685==--
