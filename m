From: Con Kolivas <kernel@kolivas.org>
Subject: Re: [PATCH] Workqueue freezer support.
Date: Mon, 8 Aug 2005 11:27:47 +1000
Message-ID: <200508081127.48432.kernel@kolivas.org>
References: <1121923059.2936.224.camel@localhost>
	<Pine.LNX.4.50.0508052148280.19501-100000@monsoon.he.net>
	<1123462015.3969.98.camel@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============17258096582636817=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <1123462015.3969.98.camel@localhost>
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
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>, Christoph Lameter <christoph@lameter.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

--===============17258096582636817==
Content-Type: text/plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Mon, 8 Aug 2005 10:46 am, Nigel Cunningham wrote:
> Hi.
>
> Sorry for the slow response. Busy still.
>
> On Sat, 2005-08-06 at 15:06, Patrick Mochel wrote:
> > On Fri, 5 Aug 2005, Nigel Cunningham wrote:
> > > Hi.
> > >
> > > I finally found some time to finish this off. I don't really like the
> > > end result - the macros looked clearer to me - but here goes. If it
> > > looks okay, I'll seek sign offs from each of the affected driver
> > > maintainers and from Ingo. Anyone else?
> >
> > What are your feelings about this: http://lwn.net/Articles/145417/ ?
>
> I'm sure it could work, but I do worry a little about the possibilities
> for exploits. It seems to me that if someone can get root, they an
> insmod a module that could schedule any kind of work via any process.
> Tracing that sort of security hole could be intractable. Christoph, is
> that something you've considered/have thoughts on? Perhaps I'm just
> being paranoid :>

If someone gets root access it means you're already exploited.

Cheers,
Con

--===============17258096582636817==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============17258096582636817==--
