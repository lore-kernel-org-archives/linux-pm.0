From: Dave Jones <davej@redhat.com>
Subject: Re: [RFC] userland swsusp
Date: Sun, 20 Nov 2005 16:48:32 -0500
Message-ID: <20051120214832.GC28918@redhat.com>
References: <20051115212942.GA9828@elf.ucw.cz>
	<20051115222549.GF17023@redhat.com>
	<1132342590.25914.86.camel@localhost.localdomain>
	<20051118211847.GA3881@redhat.com>
	<20051119234331.GA1952@spitz.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============41572504856036341=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20051119234331.GA1952@spitz.ucw.cz>
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
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>, kernel list <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-pm@vger.kernel.org

--===============41572504856036341==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Nov 19, 2005 at 11:43:32PM +0000, Pavel Machek wrote:
 > Hi!
 > 
 > >  > > Just for info: If this goes in, Red Hat/Fedora kernels will fork
 > >  > > swsusp development, as this method just will not work there.
 > >  > > (We have a restricted /dev/mem that prevents writes to arbitary
 > >  > >  memory regions, as part of a patchset to prevent rootkits)
 > >  > 
 > >  > Perhaps it is trying to tell you that you should be using SELinux rules
 > >  > not kernel hacks for this purpose ?
 > > 
 > > I don't think selinux can give you the granularity to say
 > > "process can access this bit of the file only", at least not yet.
 > > 
 > > Even if that was capable however, it still doesn't solve the problem.
 > > Pavel's implementation wants to write to arbitary address spaces, which is
 > > what we're trying to prevent. The two are at odds with each other.
 > 
 > I do not think thats a security problem. By definition, suspending code
 > can change arbitrary things in memory -- it could just write image with
 > changes it desires, then resume from it. Whether this code is in kernel
 > or not, it has to be trusted.

Stop thinking about the suspend usage case for a minute.

With your proposed changes, an attacker can scribble over random
bits of /dev/mem without suspending in order to do whatever he wants.

With what we have in-kernel, and a restricted /dev/mem, achieving the
attack you mention is a lot less feasible, as the attacker has no access
to the memory being written out to the suspend partition, even as root.
Even if they did, people tend to notice boxes shutting down pretty quickly
making this a not-very-stealthy attack.

		Dave


--===============41572504856036341==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============41572504856036341==--
