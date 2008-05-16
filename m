From: "Huang, Ying" <ying.huang@intel.com>
Subject: Re: [PATCH -mm] kexec jump -v9
Date: Fri, 16 May 2008 09:48:34 +0800
Message-ID: <1210902514.23707.161.camel__6014.86479067734$1210902274$gmane$org@caritas-dev.intel.com>
References: <1204773188.4707.109.camel@caritas-dev.intel.com>
	<20080514205204.GJ30469@redhat.com>
	<1210818762.23707.102.camel@caritas-dev.intel.com>
	<20080515200923.GC9718@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080515200923.GC9718@redhat.com>
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

On Thu, 2008-05-15 at 16:09 -0400, Vivek Goyal wrote:
[...]
> Ok, You want to make BIOS calls. We already do that using vm86 mode and
> use bios real mode interrupts. So why do we need this interface? Or, IOW,
> how is this interface better?

It can call code in 32-bit physical mode in addition to real mode. So It
can be used to call EFI runtime service, especially call EFI 64 runtime
service under 32-bit kernel or vice versa.

The main purpose of kexec jump is for hibernation. But I think if the
effort is small, why not support general 32-bit physical mode code call
at same time.

Best Regards,
Huang Ying
