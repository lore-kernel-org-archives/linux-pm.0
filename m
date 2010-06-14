From: Maxim Levitsky <maximlevitsky@gmail.com>
Subject: Re: [PATCH v2] MMC: fix all hangs related to mmc/sd card
 insert/removal during suspend/resume.
Date: Tue, 15 Jun 2010 02:48:33 +0300
Message-ID: <1276559313.7837.41.camel__961.464216425334$1276559374$gmane$org@maxim-laptop>
References: <1276283791.8557.29.camel@maxim-laptop>
	<1276283995-10812-1-git-send-email-maximlevitsky@gmail.com>
	<20100614155157.dca38e09.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100614155157.dca38e09.akpm@linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-pm <linux-pm@lists.linux-foundation.org>, linux-mmc <linux-mmc@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Philip Langdale <philipl@overt.org>
List-Id: linux-pm@vger.kernel.org

On Mon, 2010-06-14 at 15:51 -0700, Andrew Morton wrote: 
> On Fri, 11 Jun 2010 22:19:55 +0300
> Maxim Levitsky <maximlevitsky@gmail.com> wrote:
> 
> > If you don't use CONFIG_MMC_UNSAFE_RESUME, card will now be removed
> > in pm notified while userspace is still running.
> > Thus it will be possible to sync it propely.
> 
> That paragraph is a disaster and I'm not sure that I understand it well
> enough to repair it.  I think you wanted s/now/not/ and s/in/if/ and
> s/it will be/it will not be/.  Or perhaps you didn't.
> 
> Please send a comprehensible replacement.
> 

Sure.



If you don't use CONFIG_MMC_UNSAFE_RESUME, as soon as you attempt to
suspend, the card will be removed, therefore this patch doesn't change
the behavior of this option.

However the removal will be done by pm notifier, which runs while
userspace is still not frozen and thus can freely use del_gendisk,
without the risk of deadlock which would happen otherwise.

If you do use 


Best regards,
Maxim Levitsky
