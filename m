From: Pavel Machek <pavel@suse.cz>
Subject: Re: [PATCH 3/5] [pm] Respect the actual device power
	states in sysfs interface
Date: Mon, 20 Feb 2006 01:41:42 +0100
Message-ID: <20060220004142.GI15608@elf.ucw.cz>
References: <Pine.LNX.4.50.0602171758160.30811-100000@monsoon.he.net>
	<20060218155543.GE5658@openzaurus.ucw.cz>
	<Pine.LNX.4.50.0602191557520.8676-100000@monsoon.he.net>
	<20060220000907.GE15608@elf.ucw.cz>
	<Pine.LNX.4.50.0602191611130.8676-100000@monsoon.he.net>
	<20060220002053.GF15608@elf.ucw.cz>
	<Pine.LNX.4.50.0602191628270.8676-100000@monsoon.he.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============73346125992722699=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.50.0602191628270.8676-100000@monsoon.he.net>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Patrick Mochel <mochel@digitalimplant.org>
Cc: akpm@osdl.org, torvalds@osdl.org, linux-kernel@vger.kernel.org, linux-pm@osdl.org
List-Id: linux-pm@vger.kernel.org

--===============73346125992722699==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Ne 19-02-06 16:36:34, Patrick Mochel wrote:
> 
> On Mon, 20 Feb 2006, Pavel Machek wrote:
> 
> > On Ne 19-02-06 16:17:01, Patrick Mochel wrote:
> 
> > > I really fail to see what your fundamental objection is. This restores
> > > compatability, makes the core simpler, and adds the ability to use the
> > > additional states, should drivers choose to implement them; all for
> > > relatively little code. It seems a like a good thing to me..
> >
> > Compatibility is already restored.
> 
> No, the interface is currently broken. The driver core does not
> dictate

There were two different interfaces, one accepted 0 and 2, everything
else was invalid, and second accepted 0, 1, 2, 3.

If you enter D2 on echo 2, you are breaking compatibility with 2.6.15
or something like that.

Please let this interface die and create new one. (And notice that
this is exactly same advice you gave me month ago).
								Pavel

-- 
Web maintainer for suspend.sf.net (www.sf.net/projects/suspend) wanted...

--===============73346125992722699==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============73346125992722699==--
