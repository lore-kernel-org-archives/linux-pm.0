From: Christoph Lameter <clameter@sgi.com>
Subject: Re: [2/3] 2.6.22-rc2: known regressions v2
Date: Thu, 24 May 2007 10:01:37 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0705241001040.28086__14925.5157485188$1180026151$gmane$org@schroedinger.engr.sgi.com>
References: <46558708.2040803@googlemail.com> <46559B54.80106@googlemail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <46559B54.80106@googlemail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Cc: "Cherwin R. Nooitmeer" <cherwin@gmail.com>, Robert de Rooy <robert.de.rooy@gmail.com>, Tejun Heo <htejun@gmail.com>, linux-usb-devel@lists.sourceforge.net, =?UTF-8?B?S3Jpc3RpYW4gSMO4Z3NiZXJn?= <krh@bitplanet.net>, Greg Kroah-Hartman <gregkh@suse.de>, linux-pcmcia@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>, Andrey Borzenkov <arvidjaar@mail.ru>, Marcus Better <marcus@better.se>, sparclinux@vger.kernel.org, Mikael Pettersson <mikpe@it.uu.se>, Stefan Richter <stefanr@s5r6.in-berlin.de>, Pavel Machek <pavel@ucw.cz>, linux-pm@lists.linux-foundation.org, Alan Cox <alan@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, linux1394-devel@lists.sourceforge.net, Linus Torvalds <torvalds@linux-foundation.org>, David Miller <davem@davemloft.net>
List-Id: linux-pm@vger.kernel.org

On Thu, 24 May 2007, Michal Piotrowski wrote:

> Memory management
> 
> Subject    : kernel BUG at include/linux/slub_def.h:88 kmalloc_index()
> References : http://bugzilla.kernel.org/show_bug.cgi?id=8476
> Submitter  : Cherwin R. Nooitmeer <cherwin@gmail.com>
> Status     : Unknown


Looks like this is in DRM code:

BUG: at include/linux/slub_def.h:88 kmalloc_index()
 [<c014f67f>] get_slab+0x43/0x1c6
 [<c014f875>] __kmalloc+0xc/0x57
 [<f0a7b564>] drm_rmdraw+0x0/0x27d [drm]
 [<f0a7b698>] drm_rmdraw+0x134/0x27d [drm]
 [<f0a7b564>] drm_rmdraw+0x0/0x27d [drm]
 [<f0a7c1d0>] drm_ioctl+0x144/0x18c [drm]
 [<c01265ad>] enqueue_hrtimer+0xe3/0xef
 [<c015c184>] do_ioctl+0x4c/0x64
 [<c015c3c7>] vfs_ioctl+0x22b/0x23e
 [<c015c40d>] sys_ioctl+0x33/0x4e
 [<c0103ca0>] syscall_call+0x7/0xb
