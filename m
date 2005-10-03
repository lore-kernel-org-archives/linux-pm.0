From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC 0/3] Runtime PM support for named power states
Date: Mon, 3 Oct 2005 11:21:21 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0510031119380.4824-100000@iolanthe.rowland.org>
References: <20051002204310.GC2239@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============084284872552449208=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20051002204310.GC2239@elf.ucw.cz>
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
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

--===============084284872552449208==
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Sun, 2 Oct 2005, Pavel Machek wrote:

> Hi!
> 
> > This series of patches presents the beginnings of serious runtime PM
> > support.  It's not meant to be applied as is; the code is more like a
> > proof-of-principle.  It would be surprising if people didn't have a number
> > of suggestions for improvements.  And in any case, one portion of it is
> > far from complete.
> 
> Looks good to me. It converts useless .../power/state files into
> something usable.

Thank you.  It's a start, anyway.  My real question is: Is this the right 
way to go?

Alan Stern


--===============084284872552449208==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============084284872552449208==--
