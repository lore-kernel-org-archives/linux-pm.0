From: David Brownell <david-b@pacbell.net>
Subject: Re: swsusp status report
Date: Thu, 27 Jul 2006 16:13:25 -0700
Message-ID: <200607271613.25538.david-b@pacbell.net>
References: <200607251325.14747.rjw@sisk.pl>
	<Pine.LNX.4.44L0.0607261137410.6573-100000@iolanthe.rowland.org>
	<20060727204046.GA4623@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060727204046.GA4623@ucw.cz>
Content-Disposition: inline
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: linux-pm@lists.osdl.org
Cc: Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On Thursday 27 July 2006 1:40 pm, Pavel Machek wrote:

> > The disk I/O while reading or writing the image is very slow.  In fact,=
 it =

> > sounds like it's going one sector at a time.  Can it be sped up?  Do th=
e =

> > AIO changes accomplish that?
> =

> Actually yes, it was sector-at-a-time, but it still was ~half of
> possible speed, so it should not be _that_ bad.

Thing is, it's sometimes been acceptably quick, but recent kernels
have gone back and forth between really slow, to not quite so slow,
to OK, to really slow ...
