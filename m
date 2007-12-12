From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: PNP: do not stop/start devices in suspend/resume path
Date: Wed, 12 Dec 2007 00:16:10 -0800
Message-ID: <20071212001610.6506c6d2.akpm__10978.8968381055$1197447445$gmane$org@linux-foundation.org>
References: <4745F77C.7040402@gmail.com> <47514CE2.3000600@gmail.com>
	<200712051124.18852.bjorn.helgaas@hp.com>
	<200712061625.57660.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200712061625.57660.bjorn.helgaas@hp.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Jiri Slaby <jirislaby@gmail.com>, matthew@wil.cx, List <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, drzeus@drzeus.cx, Matthieu Castet <castet.matthieu@free.fr>, Linux@smtp2.linux-foundation.org, linux-pm@lists.linux-foundation.org, Kristen@smtp2.linux-foundation.org, Accardi <kristen.c.accardi@intel.com>
List-Id: linux-pm@vger.kernel.org

On Thu, 6 Dec 2007 16:25:57 -0700 Bjorn Helgaas <bjorn.helgaas@hp.com> wrote:

> Andrew, can you add this before
> pnp-request-ioport-and-iomem-resources-used-by-active-devices.patch?
> 
> ...
>
> PNP: do not stop/start devices in suspend/resume path

I did, but I also temporarily dropped
pnp-request-ioport-and-iomem-resources-used-by-active-devices.patch.

Is it expected that this patch will fix
pnp-request-ioport-and-iomem-resources-used-by-active-devices.patch? 
Should I bring it back?
