From: "Huang, Ying" <ying.huang@intel.com>
Subject: Re: [PATCH 0/3 -mm] kexec jump -v8
Date: Thu, 27 Dec 2007 10:33:13 +0800
Message-ID: <1198722793.7320.15.camel__12377.2060186186$1198722873$gmane$org@caritas-dev.intel.com>
References: <1198222399.1965.15.camel@caritas-dev.intel.com>
	<20071227015716.GA6718@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20071227015716.GA6718@redhat.com>
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

On Wed, 2007-12-26 at 20:57 -0500, Vivek Goyal wrote:
[...]
> > 9. Now, you are in the original kernel again. You can read/write the
> >    memory image of kexeced kernel via /proc/kimgcore.
> > 
> 
> Why do we need two interfaces, /proc/vmcore and /proc/kimgcore? Can't
> we have just one say /proc/vmcore. Irrespective of what kernel you are
> in /proc/vmcore gives you the access to the memory of kernel which was
> previously booted.

In theory we can kexec another kernel even in a kexeced kernel, that is,
in kernel A kexec kernel B, and in kernel B kexec another kernel C. In
this situation, both /proc/vmcore and /proc/kimgcore has valid contents.
So I think, it may be better to keep two interfaces.

In fact, current kexec jump implementation use a dummy "jump back helper
image" in kexeced kernel to jump back to the original kernel. The "jump
back helper image" has no PT_LOAD segment, it is used to provide a
struct kimage (including control page, swap page) and entry point to
jump back.

Best Regards,
Huang Ying
