From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: PNP: do not stop/start devices in suspend/resume path
Date: Wed, 12 Dec 2007 09:29:06 -0700
Message-ID: <200712120929.07134.bjorn.helgaas__6412.66160314462$1197477081$gmane$org@hp.com>
References: <4745F77C.7040402@gmail.com>
	<200712061625.57660.bjorn.helgaas@hp.com>
	<20071212001610.6506c6d2.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20071212001610.6506c6d2.akpm@linux-foundation.org>
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
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jiri Slaby <jirislaby@gmail.com>, matthew@wil.cx, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, drzeus@drzeus.cx, Matthieu Castet <castet.matthieu@free.fr>, linux-pm@lists.linux-foundation.org, Kristen Carlson Accardi <kristen.c.accardi@intel.com>
List-Id: linux-pm@vger.kernel.org

On Wednesday 12 December 2007 01:16:10 am Andrew Morton wrote:
> On Thu, 6 Dec 2007 16:25:57 -0700 Bjorn Helgaas <bjorn.helgaas@hp.com> wrote:
> 
> > Andrew, can you add this before
> > pnp-request-ioport-and-iomem-resources-used-by-active-devices.patch?
> > 
> > ...
> >
> > PNP: do not stop/start devices in suspend/resume path
> 
> I did, but I also temporarily dropped
> pnp-request-ioport-and-iomem-resources-used-by-active-devices.patch.

Thanks.

> Is it expected that this patch will fix
> pnp-request-ioport-and-iomem-resources-used-by-active-devices.patch? 
> Should I bring it back?

No, not yet.  The "do not stop/start" patch should fix the kernel/resource.c
warning, but I don't understand the "acpi reboots machine" (critical temp
reached) problem yet.

Bjorn
