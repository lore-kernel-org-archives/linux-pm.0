From: Andrea Righi <righi.andrea@gmail.com>
Subject: Re: [Linux-fbdev-devel] [2.6.29-rc2] fb_mmap: circular
 locking dependency on hibernation
Date: Sat, 31 Jan 2009 19:11:55 +0100
Message-ID: <4984946B.5000205__18146.8924893581$1233425730$gmane$org@gmail.com>
References: <200901272137.57757.arvidjaar@mail.ru>
	<Pine.LNX.4.64.0901291009220.13600@anakin>
	<200901300716.06137.arvidjaar@mail.ru> <498485E0.4080501@gmail.com>
	<Pine.LNX.4.64.0901311843450.21273@anakin>
Reply-To: righi.andrea@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.64.0901311843450.21273@anakin>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-pm@lists.linux-foundation.org, Andrey Borzenkov <arvidjaar@mail.ru>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Development <linux-kernel@vger.kernel.org>, "Antonino A. Daplas" <adaplas@gmail.com>
List-Id: linux-pm@vger.kernel.org

On 2009-01-31 18:44, Geert Uytterhoeven wrote:
> On Sat, 31 Jan 2009, Andrea Righi wrote:
>> On 2009-01-30 05:15, Andrey Borzenkov wrote:
>>> On 29 of January 2009 12:10:11 Geert Uytterhoeven wrote:
>>>> On Tue, 27 Jan 2009, Andrey Borzenkov wrote:
>> fbcon: avoid circular locking dependency between fb_info->lock and mm->mmap_sem
>>
>> In fbcon notifier the handler for FB_EVENT_SET_CONSOLE_MAP doesn't need
>> to hold fb_info->lock.
>>
>> Simply unlock it before calling set_con2fb_map(), that could try to
>> acquire mm->mmap_sem to avoid a circular locking dependency with
>> fb_mmap() (that acquires mm->mmap_sem -> fb_info-lock).
> 
> However, set_con2fb_map() accesses the array of fb_info pointers
> registered_fb[], which seems to be a bit unsafe now the BKL is no longer held.

mmmh.. not sure about that, registered_fb[] was never accessed with
fb_info->lock held, see register/unregister_framebuffer().

But maybe this is another issue, and anyway, the array and also
num_registered_fb don't seem to be protected at all...

-Andrea
