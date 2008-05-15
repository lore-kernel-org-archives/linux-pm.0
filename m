From: "Huang, Ying" <ying.huang@intel.com>
Subject: Re: [PATCH -mm] kexec jump -v9
Date: Thu, 15 May 2008 13:41:50 +0800
Message-ID: <1210830110.23707.141.camel__9715.63284188068$1210829971$gmane$org@caritas-dev.intel.com>
References: <1204773188.4707.109.camel@caritas-dev.intel.com>
	<20080514205204.GJ30469@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080514205204.GJ30469@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Vivek Goyal <vgoyal@redhat.com>
Cc: nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hi, Vivek,

On Wed, 2008-05-14 at 16:52 -0400, Vivek Goyal wrote:
[...]
> Ok, I have done some testing on this patch. Currently I have just
> tested switching back and forth between two kernels and it is working for
> me.
> 
> Just that I had to put LAPIC and IOAPIC in legacy mode for it to work. Few
> comments/questions are inline.

It seems that for LAPIC and IOAPIC, there is
lapic_suspend()/lapic_resume() and ioapic_suspend()/ioapic_resume(),
which will be called before/after kexec jump through
device_power_down()/device_power_up(). So, the mechanism for
LAPIC/IOAPIC is there, we may need to check the corresponding
implementation.

Best Regards,
Huang Ying
