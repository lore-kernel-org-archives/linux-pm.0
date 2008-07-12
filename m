From: Nigel Cunningham <nigel@nigel.suspend2.net>
Subject: Re: [PATCH -mm 1/2] kexec jump -v12: kexec jump
Date: Sat, 12 Jul 2008 11:02:17 +1000
Message-ID: <1215824537.7319.7.camel__6850.09213998473$1215824765$gmane$org@nigel-laptop>
References: <1215401122.4660.4.camel@caritas-dev.intel.com>
	<20080708145051.GA14745@redhat.com>
	<20080711122131.b6461ab1.akpm@linux-foundation.org>
	<20080711201149.GB3298@redhat.com>
Reply-To: nigel@nigel.suspend2.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080711201149.GB3298@redhat.com>
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
Cc: Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, Horms <horms@verge.net.au>, "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hi.

On Fri, 2008-07-11 at 16:11 -0400, Vivek Goyal wrote:
> Hi Andrew,
> 
> We can use this patchset for hibernation, but can it be a better way of doing
> things than what we already have, I don't know. Last time I had raised
> this question and power people had various views. In the end, Pavel wanted
> this patchset to be in.  Pavel, can tell more here...
> 
> To me this patchset looks interesting for couple of reasons.
> 
> - Looks like an interesting feature where one can have a separate kernel
>   in memory and one can switch between the kernels on the fly. It can
>   be modified to have more than one kernel in memory at a time.

I'm not sure how useful that would be, though. I already have
functionality in TuxOnIce which allows you to resume a different image
instead of powering off (roughly the same thing when combined with not
removing the image after resuming). It was neat when testing to be able
to switch back and forth, and I developed the code because I imagined
that it could form part of the foundation for switching between a login
screen and users' stored sessions. Is this what you're imagining?

> - So far kexec was one directional. One can only kexec to new kernel and
>   old kernel was gone. Now this patchset makes kexec functionality kind
>   of bidirectional and this looks like logical extension and can lead
>   to intersting use cases in future.

Ah. You mean keeping both kernels in memory at the same time? In the
above, I was replacing one image with another.

> Huang also talks of using this feature for snapshotting kernel and
> invoking some BIOS code in protected mode. I am not very sure how exactly
> are they planning to use it. Huang, do you have more details on this?

As Rafael wrote, snapshotting is a completely different beast.

Regards,

Nigel
