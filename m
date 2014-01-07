From: "Dongsheng.Wang@freescale.com" <Dongsheng.Wang@freescale.com>
Subject: RE: [RFC] linux/pci: move pci_platform_pm_ops to linux/pci.h
Date: Tue, 7 Jan 2014 09:35:16 +0000
Message-ID: <121c487959fe4d73897b7003ad8554a4@BN1PR03MB188.namprd03.prod.outlook.com>
References: <1387533832-34554-1-git-send-email-dongsheng.wang@freescale.com>
 <CAErSpo7+8sLZVi24fi+xxTEW2_DTJ2_zUrW+vobMGsvCEFwY_Q@mail.gmail.com>
 <2276888.ovWFBgDtau@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <2276888.ovWFBgDtau@vostro.rjw.lan>
Content-Language: en-US
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Bjorn Helgaas <bhelgaas@google.com>
Cc: Linux PM list <linux-pm@vger.kernel.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, Scott Wood <scottwood@freescale.com>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: linux-pm@vger.kernel.org



> -----Original Message-----
> From: Rafael J. Wysocki [mailto:rjw@rjwysocki.net]
> Sent: Monday, January 06, 2014 8:13 PM
> To: Bjorn Helgaas
> Cc: Wang Dongsheng-B40534; Zang Roy-R61911; Wood Scott-B07421; Kumar Gala; Linux
> PM list; linux-pci@vger.kernel.org; linuxppc-dev
> Subject: Re: [RFC] linux/pci: move pci_platform_pm_ops to linux/pci.h
> 
> On Friday, December 20, 2013 09:42:59 AM Bjorn Helgaas wrote:
> > On Fri, Dec 20, 2013 at 3:03 AM, Dongsheng Wang
> > <dongsheng.wang@freescale.com> wrote:
> > > From: Wang Dongsheng <dongsheng.wang@freescale.com>
> > >
> > > make Freescale platform use pci_platform_pm_ops struct.
> >
> > This changelog doesn't say anything about what the patch does.
> >
> > I infer that you want to use pci_platform_pm_ops from some Freescale
> > code.  This patch should be posted along with the patches that add
> > that Freescale code, so we can see how you intend to use it.
> >
> > The existing use is in drivers/pci/pci-acpi.c, so it's possible that
> > your new use should be added in the same way, in drivers/pci, so we
> > don't have to make pci_platform_pm_ops part of the public PCI
> > interface in include/linux/pci.h.
> >
> > That said, if Raphael thinks this makes sense, it's OK with me.
> 
> Well, I'd like to know why exactly the change is needed in the first place.
> 
Thanks for review, I think the idea is not suitable for freescale platform
implementation of the right now.

I will drop this RFC patch.

-Dongsheng

> Thanks!
> 
> --
> I speak only for myself.
> Rafael J. Wysocki, Intel Open Source Technology Center.
> 
