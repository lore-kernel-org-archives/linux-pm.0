From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC] Add some hooks to generic suspend code
Date: Fri, 03 Jun 2005 08:18:00 +1000
Message-ID: <1117750680.31082.81.camel@gaston>
References: <1117524577.5826.35.camel@gaston>
	<20050531101344.GB9614@elf.ucw.cz>	<1117550660.5826.42.camel@gaston>
	<20050531212556.GA14968@elf.ucw.cz>  <429F321D.9000009@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============06494105195107025=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <429F321D.9000009@suse.de>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Stefan Seyfried <seife@suse.de>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>, Linux Kernel list <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

--===============06494105195107025==
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, 2005-06-02 at 18:21 +0200, Stefan Seyfried wrote:

> >> Sure, ideally. However, existing X knows how to deal with APM events,
> >> and thus APM emulation is an important thing to get something that
> >> works. Pne thing I should do is consolidate PPC APM emu with ARM one as
> >> I think Russell improve my stuff significantly.
> > 
> > Perhaps we need apm emulation on i386, too?
> 
> No. This is too ugly for words IMO. If we have one good mechanism of
> notifying userland, X can use this mechanism. Let's kill APM, not keep
> it alive.

Euh... maybe but I still think we need to keep this userland interface
alive for a little while. At least ARM and PPC have existing stuff that
rely on it.

Ben.



--===============06494105195107025==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============06494105195107025==--
