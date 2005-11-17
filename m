From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: [RFC] userland swsusp
Date: Thu, 17 Nov 2005 16:16:07 -0500
Message-ID: <1132262168.5959.24.camel@mindpipe>
References: <F760B14C9561B941B89469F59BA3A8470BDD12EB@orsmsx401.amr.corp.intel.com>
	<20051116164429.GA5630@kroah.com> <1132172445.25230.73.camel@localhost>
	<20051116220500.GF12505@elf.ucw.cz>
	<20051117170202.GB10402@dspnet.fr.eu.org>
	<1132257432.4438.8.camel@mindpipe>
	<20051117201204.GA32376@dspnet.fr.eu.org>
	<1132258855.4438.11.camel@mindpipe> <1132258855.4438.11.camel@mindpipe>
	<20051117203731.GG5772@redhat.com>
	<E1Ecr0F-0003TC-00@chiark.greenend.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============63677679173083301=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <E1Ecr0F-0003TC-00@chiark.greenend.org.uk>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Matthew Garrett <mgarrett@chiark.greenend.org.uk>
Cc: linux-pm@lists.osdl.org, Olivier Galibert <galibert@pobox.com>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

--===============63677679173083301==
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, 2005-11-17 at 21:09 +0000, Matthew Garrett wrote:
> Dave Jones <davej@redhat.com> wrote:
> 
> > I don't know about other distros, but here's how that usually goes for Fedora users..
> 
> It Works in Ubuntu(TM)[0]. More seriously: recent alsa-libs should
> provide a pile of stuff in /usr/share/alsa/cards which switches dmix on
> by default in most cards[1]. Obviously, for this to work usefully, your
> application needs to be using libalsa (either natively or using the aoss
> wrapper).
> 
> [0] The only patch is to enable symbol versioning
> [1] Not ones with hardware mixing

[1] is already done for most of the hardware that needs it.  No user
configuration at all should be required.  Please, let us know if you
find a device it does not work that way for.

Lee


--===============63677679173083301==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============63677679173083301==--
