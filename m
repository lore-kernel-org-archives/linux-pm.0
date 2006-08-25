From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: Re : Re : [HELP] Power management for embedded system
Date: Fri, 25 Aug 2006 14:29:19 +0100
Message-ID: <20060825132919.GA12370@srcf.ucam.org>
References: <20060824162034.GB19753@srcf.ucam.org>
	<20060825131843.87416.qmail@web25803.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <20060825131843.87416.qmail@web25803.mail.ukl.yahoo.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: moreau francis <francis_moreau2000@yahoo.fr>
Cc: linux-pm@lists.osdl.org, Russell King <rmk+lkml@arm.linux.org.uk>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Fri, Aug 25, 2006 at 01:18:43PM +0000, moreau francis wrote:
> Matthew Garrett wrote:
> > Triggering suspend/resume is already generic in the form of the =

> > /sys/power/state interface. There's been discussion of producing a =

> > generic battery class lately. There's some trend towards tying suspend =

> > requests into the input layer, but how appropriate that is may depend o=
n =

> > the hardware in question. I think most of the pieces are in place to =

> > provide an interface that isn't tied to looking like APM, and there's
> =

> what about suspend/resume event handling ? Is there something already in
> place ?

You mean passing those events out to userspace? Not that I know of.
-- =

Matthew Garrett | mjg59@srcf.ucam.org
