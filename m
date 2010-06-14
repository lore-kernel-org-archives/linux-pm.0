From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2] MMC: fix all hangs related to mmc/sd card
 insert/removal during suspend/resume.
Date: Mon, 14 Jun 2010 15:51:57 -0700
Message-ID: <20100614155157.dca38e09.akpm__34912.2765394442$1276556049$gmane$org@linux-foundation.org>
References: <1276283791.8557.29.camel@maxim-laptop>
	<1276283995-10812-1-git-send-email-maximlevitsky@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1276283995-10812-1-git-send-email-maximlevitsky@gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Maxim Levitsky <maximlevitsky@gmail.com>
Cc: linux-pm <linux-pm@lists.linux-foundation.org>, linux-mmc <linux-mmc@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Philip Langdale <philipl@overt.org>
List-Id: linux-pm@vger.kernel.org

On Fri, 11 Jun 2010 22:19:55 +0300
Maxim Levitsky <maximlevitsky@gmail.com> wrote:

> If you don't use CONFIG_MMC_UNSAFE_RESUME, card will now be removed
> in pm notified while userspace is still running.
> Thus it will be possible to sync it propely.

That paragraph is a disaster and I'm not sure that I understand it well
enough to repair it.  I think you wanted s/now/not/ and s/in/if/ and
s/it will be/it will not be/.  Or perhaps you didn't.

Please send a comprehensible replacement.
