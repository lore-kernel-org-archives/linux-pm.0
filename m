From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC] userland swsusp
Date: Wed, 16 Nov 2005 23:41:03 +0100
Message-ID: <200511162341.04652.rjw@sisk.pl>
References: <F760B14C9561B941B89469F59BA3A8470BDD12EB@orsmsx401.amr.corp.intel.com>
	<20051116220500.GF12505@elf.ucw.cz>
	<1132175574.25230.111.camel@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3540581371503797=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <1132175574.25230.111.camel@localhost>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: ncunningham@cyclades.com
Cc: Dave Jones <DaveJ@redhat.com>, Linux-pm mailing list <linux-pm@lists.osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

--===============3540581371503797==
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

On Wednesday, 16 of November 2005 22:13, Nigel Cunningham wrote:
> On Thu, 2005-11-17 at 09:05, Pavel Machek wrote:
}-- snip --{
> > So... to get 225 patches in, you'll need to explain that
> > userland-swsusp can't work. If you can do that, please be nice and do
> > it soon, so that I don't waste too much time on userland-swsusp.
> 
> I thought Dave already did that.

Not as far as I'm concerned.  He criticised the implementation,
which I generally agree with, but IMO the overall idea is not wrong.

BTW, you don't need to export the page flags, use /dev/kmem etc. to implement
it.  The only concern that I have wrt it is the writing of the image _after_ the
system has been snapshotted.

Greetings,
Rafael

--===============3540581371503797==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============3540581371503797==--
