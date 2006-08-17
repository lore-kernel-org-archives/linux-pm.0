From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH 3/3] PM: Remove PM_TRACE from Kconfig
Date: Thu, 17 Aug 2006 07:24:23 +0200
Message-ID: <200608170724.23968.rjw@sisk.pl>
References: <200608151509.06087.rjw@sisk.pl> <200608161314.11128.rjw@sisk.pl>
	<20060817044011.GB14127@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060817044011.GB14127@kroah.com>
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
To: Greg KH <greg@kroah.com>
Cc: Linux PM <linux-pm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thursday 17 August 2006 06:40, Greg KH wrote:
> On Wed, Aug 16, 2006 at 01:14:11PM +0200, Rafael J. Wysocki wrote:
> > Remove the CONFIG_PM_TRACE option, which is dangerous and should only b=
e used
> > by people who know exactly what they are doing, from Kconfig.
> =

> No, don't remove this, that's not acceptable at all.  This is useful for
> others (and one specifically who will be pissed to see this removed...)

Well, this was a Pavel's idea. ;-)

However, it does some harm to users.  I was hit by it personally and there's
been at least one report related to it on LKML recently.

Still I think we can just mark it as dangerous or something like that, which
was my initial idea.

Greetings,
Rafael


-- =

You never change things by fighting the existing reality.
		R. Buckminster Fuller
