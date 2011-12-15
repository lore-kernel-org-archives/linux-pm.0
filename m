From: Anton Vorontsov <cbouatmailru@gmail.com>
Subject: Re: [PATCH v2] ahci: platform support for suspend/resume
Date: Thu, 15 Dec 2011 22:43:46 +0400
Message-ID: <20111215184346.GA15602@oksana.dev.rtsoft.ru>
References: <1321643410-16102-1-git-send-email-computersforpeace@gmail.com>
	<20111118192809.GF11736@legolas.emea.dhcp.ti.com>
	<CAN8TOE-yZyHC3n+dSu9wZ=UBmenD67OHbAyrF2K_sgf0O7oUJA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CAN8TOE-yZyHC3n+dSu9wZ=UBmenD67OHbAyrF2K_sgf0O7oUJA@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Brian Norris <computersforpeace@gmail.com>
Cc: Lin Ming <ming.m.lin@intel.com>, Linux Kernel <linux-kernel@vger.kernel.org>, balbi@ti.com, linux-ide@vger.kernel.org, Tejun Heo <tj@kernel.org>, linux-pm@lists.linux-foundation.org, Jeff Garzik <jgarzik@pobox.com>
List-Id: linux-pm@vger.kernel.org

On Thu, Dec 15, 2011 at 10:13:19AM -0800, Brian Norris wrote:
> On Fri, Nov 18, 2011 at 11:28 AM, Felipe Balbi <balbi@ti.com> wrote:
> > On Fri, Nov 18, 2011 at 11:10:10AM -0800, Brian Norris wrote:
> >> Add platform hooks for custom suspend() and resume() functions. The
> >> generic suspend/resume code in drivers/ata/ahci_platform.c is adapted
> >> from the PCI version in drivers/ata/ahci.c.
> >>
> >> Signed-off-by: Brian Norris <computersforpeace@gmail.com>
> >
> > Reviewed-by: Felipe Balbi <balbi@ti.com>
> 
> Thanks for the review, Felipe.
> 
> What's the status on this? There have been no comments for almost a
> month. Can it be merged?

FWIW, the patch looks quite useful. Hope this will help:

Acked-by: Anton Vorontsov <cbouatmailru@gmail.com>

Thanks!

-- 
Anton Vorontsov
Email: cbouatmailru@gmail.com
