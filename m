From: "Huang, Ying" <ying.huang@intel.com>
Subject: Re: [PATCH -mm 2/2] kexec jump -v11: save/restore device
	state
Date: Fri, 13 Jun 2008 09:18:52 +0800
Message-ID: <1213319932.22697.9.camel__5118.62460193715$1213319895$gmane$org@caritas-dev.intel.com>
References: <1213082106.22608.30.camel@caritas-dev.intel.com>
	<20080611163026.GG6450@redhat.com>
	<1213232019.21353.8.camel@caritas-dev.intel.com>
	<20080612130225.GA9654@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080612130225.GA9654@redhat.com>
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

On Thu, 2008-06-12 at 09:02 -0400, Vivek Goyal wrote:
[...]
> Few things I don't understand.
> 
> - Are you saying that hibernated image will be saved in initrd
>   (rootfs.gz)? But that saving is only in RAM, we never write back
>   it to disk?

No. Hibernated image should be saved in a dedicated raw partition as you
said below.

> - I thought we probably have to dedicate a raw partition kind of thing
>   for saving image and then modify boot loader command line to something
>   similar to, "resume=partition". Then initrd can go hunting for image
>   in respective partition (as specified by command line parameter) and if
>   image is not available then continue with normal boot.

Yes. But the boot-loader command line only need to be changed during
system install or hibernation setup. We need not change the location of
"hibernation partition" frequently.

So I think one boot-loader command line is sufficient for:

- normal boot
- normal boot a system to be hibernated
- boot helper system to restore the hibernated system

Best Regards,
Huang Ying
