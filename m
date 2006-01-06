From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [patch] pm: fix runtime powermanagement's
	/sys	interface
Date: Fri, 6 Jan 2006 04:17:54 +0000
Message-ID: <20060106041754.GA2496@ucw.cz>
References: <Pine.LNX.4.50.0601051729400.30092-100000@monsoon.he.net>
	<Pine.LNX.4.44L0.0601061035090.5127-100000@iolanthe.rowland.org>
	<20060107000826.GC20399@elf.ucw.cz>
	<20060107075851.GD3184@neo.rr.com>
	<20060107102013.GB9225@elf.ucw.cz>
	<20060107130652.GB3972@neo.rr.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0074602906000618141=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060107130652.GB3972@neo.rr.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Adam Belay <ambx1@neo.rr.com>, Alan Stern <stern@rowland.harvard.edu>, Andrew Morton <akpm@osdl.org>, Dominik Brodowski <linux@dominikbrodowski.net>, Linux-pm mailing list <linux-pm@lists.osdl.org>, kernel list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

--===============0074602906000618141==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

> > > Also there's nothing "runtime" about the PCMCIA PM API.  It's much more
> > > like calling ->remove() as it disabled the device all together.  
> > 
> > It looks enough runtime to me.
> 
> As was already discussed, we don't want to modify every userspace
> application to check if the device it needs is "on" (resumed) or
> "off" (suspended).  It's just two painful with third party apps etc.
> Therefore, the kernel needs to handle this more seemlessly.  In my

But we do not want to reactivate device on first access. Certainly not
in PCMCIA case. Reactivation is separate problem.

						Pavel

-- 
Thanks, Sharp!

--===============0074602906000618141==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============0074602906000618141==--
