From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH v2] pm_ops: add system quiesce/activate hooks
Date: Thu, 12 Apr 2007 12:45:58 +0200
Message-ID: <200704121245.59594.rjw@sisk.pl>
References: <1175810054.3489.34.camel@johannes.berg>
	<1176367352.5764.2.camel@localhost.localdomain>
	<20070412101653.GB26473@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070412101653.GB26473@elf.ucw.cz>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org
Cc: Johannes Berg <johannes@sipsolutions.net>, linux-pm <linux-pm@lists.osdl.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On Thursday, 12 April 2007 12:16, Pavel Machek wrote:
> Hi!
> =

> > > I doubt your reasoning is cogent enough. If you add such a global thi=
ng,
> > > you should prove it, or clearly explain what is the thing for.
> > > I don't believe that it's not possible to solve that decrementer case
> > > without this change. Can't you add appropriate platform_device which
> > > would register early enough, to meet that timing requirement when it
> > > gets suspended?
> > =

> > That's would be absolutely disgusting... (relying on magic ordering of
> > platform devices).
> =

> Adding platform hook to disable interrupts just because we need one
> platform device last is not nice, either. (And does decrementer even
> need to come last?)
> =

> Anyway, platform devices may need specific ordering on more than power
> pc, so perhaps we should just make ordering more stable so that
> relying on it is no longer a hack?

I second that, although I think it also would be a global change.

Greetings,
Rafael
