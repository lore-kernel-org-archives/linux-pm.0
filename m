From: Pavel Machek <pavel@suse.cz>
Subject: Re: [PATCH -next] Hibernate: Do not oops on resume if
	image data	are incorrect
Date: Sat, 8 Nov 2008 14:09:46 +0100
Message-ID: <20081108130946.GC21405__33843.7515697025$1226149861$gmane$org@elf.ucw.cz>
References: <200811081357.42925.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200811081357.42925.rjw@sisk.pl>
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
Cc: pm list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Sat 2008-11-08 13:57:42, Rafael J. Wysocki wrote:
> Hi Len,
> 
> Please add this patch to the suspend branch.
> 
> Thanks,
> Rafael
> 
> 
> ---
> From: Rafael J. Wysocki <rjw@sisk.pl>
> Subject: Hibernate: Do not oops on resume if image data are incorrect
> 
> During resume from hibernation using the userland interface image
> data are being passed from the used space process to the kernel.
> These data need not be valid, but currently the kernel sometimes
> oopses if it gets invalid image data, which is wrong.  Make the
> kernel return error codes to the user space in such cases.

(Note that userspace will still be able to make it crash / execute
arbitrary code later in the game, by supplying carefully damaged
image. But that's okay and that will always be the case.)

> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> Cc: Pavel Machek <pavel@suse.cz>

Looks okay to me.

Acked-by: Pavel Machek <pavel@suse.cz>

...and thanks :-).
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
