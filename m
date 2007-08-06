From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] kexec: fix pci device initialization fail
	after kexec (2.6.23-rc2). (Related to e1000 doesn't resume
	properly from standby)
Date: Mon, 6 Aug 2007 20:48:36 +0200
Message-ID: <200708062048.37160.rjw__16348.570949822$1186425613$gmane$org@sisk.pl>
References: <b25c3fa70708060642w1b3a326q792a81fdaa3036c5@mail.gmail.com>
	<200708061650.16555.rjw@sisk.pl>
	<b25c3fa70708060850p26b7b3e6yb8a523a479c714c0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <b25c3fa70708060850p26b7b3e6yb8a523a479c714c0@mail.gmail.com>
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
To: Joonwoo Park <joonwpark81@gmail.com>
Cc: Simon Arlott <simon@fire.lp0.eu>, "Kok, Auke" <auke-jan.h.kok@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Monday, 6 August 2007 17:50, Joonwoo Park wrote:
> 2007/8/6, Rafael J. Wysocki <rjw@sisk.pl>:
> > On Monday, 6 August 2007 15:42, Joonwoo Park wrote:
> > > Hi.
> > > I think that the pci_set_power_state() has bug.
> > > The specification says that some delays is required.
> >
> > And they are in place, AFAICS (from drivers/pci/pci.c):
> >
> >        /* Mandatory power management transition delays */
> >        /* see PCI PM 1.1 5.6.1 table 18 */
> >        if (state == PCI_D3hot || dev->current_state == PCI_D3hot)
> >                msleep(pci_pm_d3_delay);
> >        else if (state == PCI_D2 || dev->current_state == PCI_D2)
> >                udelay(200);
> >
> 
> The problem is occurred when state is 'PCI_D0', so those codes can't cover it.
> But pci pm specification 5.4.1 says that when programmed to D0 the
> equivalent of a warm reset, delay for the duration of the D3hot to D0
> Uninitialized state
> transition (10ms) to pci signal drivers remain disabled is required.

Section 5.4.1 of PCI PM 1.1. spec is about D3_hot.  Specifically, it says
that if a device in D3_hot is programmed to D0, it performs the equivalent of
a warm reset.  IOW, this is supposed to happen if the current state is D3_hot
and the targed state is D0, which is covered by the code snippet above.

Greetings,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth
