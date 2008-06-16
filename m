From: "Huang, Ying" <ying.huang@intel.com>
Subject: Re: [PATCH -mm 1/2] kexec jump -v11: kexec jump
Date: Mon, 16 Jun 2008 09:52:21 +0800
Message-ID: <1213581141.7179.6.camel__36552.2779793993$1213581099$gmane$org@caritas-dev.intel.com>
References: <1213082104.22608.29.camel@caritas-dev.intel.com>
	<20080612192015.GH9654@redhat.com>
	<1213319040.20431.8.camel@caritas-dev.intel.com>
	<20080613180059.GA4906@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080613180059.GA4906@redhat.com>
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

On Fri, 2008-06-13 at 14:00 -0400, Vivek Goyal wrote:
[...]
> Ok, I found that in my config CONFIG_HIBERNATION was not enabled. After
> enabling CONFIG_HIBERNATION, both suspend to disk and kjump started
> working.
> 
> Does that mean there is some dependency on code under CONFIG_HIBERNATION.
> If yes, I think this dependency should be resolved during compile time.
> May be addtional config option (CONFIG_KEXEC_JUMP), which also selects
> the CONFIG_HIBERNATION automatically etc...

Yes. kexec jump need to put devices into quiescent state and save
devices state into memory, which is implemented by calling hibernation
function: device_suspend(PMSG_FREEZE), whose implementation depends on 
CONFIG_HIBERNATION.

So, I will add CONFIG_KEXEC_JUMP and select CONFIG_HIBERNATION
automatically.

Best Regards,
Huang Ying
