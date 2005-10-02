From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC 0/3] Runtime PM support for named power states
Date: Sun, 2 Oct 2005 22:43:10 +0200
Message-ID: <20051002204310.GC2239@elf.ucw.cz>
References: <Pine.LNX.4.44L0.0509301536560.4470-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============17743420012312239=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.44L0.0509301536560.4470-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

--===============17743420012312239==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> This series of patches presents the beginnings of serious runtime PM
> support.  It's not meant to be applied as is; the code is more like a
> proof-of-principle.  It would be surprising if people didn't have a number
> of suggestions for improvements.  And in any case, one portion of it is
> far from complete.

Looks good to me. It converts useless .../power/state files into
something usable.
								Pavel
-- 
if you have sharp zaurus hardware you don't need... you know my address

--===============17743420012312239==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============17743420012312239==--
