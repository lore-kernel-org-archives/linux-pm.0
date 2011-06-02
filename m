From: Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH 5/8] PCI / Intel IOMMU: Use syscore_ops
 instead of sysdev class and sysdev
Date: Thu, 2 Jun 2011 10:30:40 -0700
Message-ID: <BANLkTi=xhg7_0O-aVC8s1Uyo4Wkz5OTCdg__30343.0617358119$1307035892$gmane$org@mail.gmail.com>
References: <201103100131.58206.rjw@sisk.pl> <201103122212.40828.rjw@sisk.pl>
	<201103122218.14832.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201103122218.14832.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, mingo@redhat.com, Avi Kivity <avi@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Kay Sievers <kay.sievers@suse.de>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, tglx@linutronix.de
List-Id: linux-pm@vger.kernel.org

On Sat, Mar 12, 2011 at 1:18 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> -static int __init init_iommu_sysfs(void)
> -{
> - =A0 =A0 =A0 return 0;
> -}
> +static inline int init_iommu_pm_ops(void) { }
> =A0#endif /* CONFIG_PM */

drivers/pci/intel-iommu.c:3391: warning: no return statement in
function returning non-void

s/static inline int/static inline void/

Reported-by: Tony Luck <tony.luck@intel.com>

-Tony
