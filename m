From: Avi Kivity <avi@redhat.com>
Subject: Re: [PATCH 4/6] KVM: Use syscore_ops instead of sysdev
 class and sysdev
Date: Tue, 22 Mar 2011 11:18:36 +0200
Message-ID: <4D88696C.6060203__5286.55730090595$1300897884$gmane$org@redhat.com>
References: <201103100131.58206.rjw@sisk.pl> <201103122212.40828.rjw@sisk.pl>
	<201103220031.22729.rjw@sisk.pl> <201103220037.06465.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201103220037.06465.rjw@sisk.pl>
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
Cc: kvm@vger.kernel.org, Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, iommu@lists.linux-foundation.org, mingo@redhat.com, cpufreq@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Kay Sievers <kay.sievers@suse.de>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, David Woodhouse <dwmw2@infradead.org>, tglx@linutronix.de
List-Id: linux-pm@vger.kernel.org

On 03/22/2011 01:37 AM, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki<rjw@sisk.pl>
>
> KVM uses a sysdev class and a sysdev for executing kvm_suspend()
> after interrupts have been turned off on the boot CPU (during system
> suspend) and for executing kvm_resume() before turning on interrupts
> on the boot CPU (during system resume).  However, since both of these
> functions ignore their arguments, the entire mechanism may be
> replaced with a struct syscore_ops object which is simpler.
>

Acked-by: Avi Kivity <avi@redhat.com>

-- 
error compiling committee.c: too many arguments to function
