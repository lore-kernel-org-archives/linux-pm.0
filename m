From: Alan Jenkins <sourcejedi.lkml@googlemail.com>
Subject: Re: Regression: First hibernation attempt fails
Date: Thu, 9 Apr 2009 13:29:47 +0100
Message-ID: <9b2b86520904090529u4586906ei878967c2636417be__9341.8494718664$1239288353$gmane$org@mail.gmail.com>
References: <49DDD83F.507@tuffmail.co.uk>
Reply-To: alan-jenkins@tuffmail.co.uk
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <49DDD83F.507@tuffmail.co.uk>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org
Cc: Kernel Testers List <kernel-testers@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 4/9/09, Alan Jenkins <alan-jenkins@tuffmail.co.uk> wrote:
> Yet another issue in 2.6.30-rc1 which was not present in 2.6.29 :-).  I
> wonder if it rings any bells?
>
> On my laptop (EEE 4G), the first attempt at hibernation fails.
> Subsequent attempts succeed.
>
> If I use s2disk as normal, I see "snapshotting system", then before it
> gets to write out the image, it aborts and switches back to X.   I can't
> see any error message, even if I check the log with "dmesg".
>
> If I use "echo disk > /sys/power/state", echo reports the error "Cannot
> allocate memory".
>
> This only happens if I've logged in to X first.  In fact, I narrowed it
> down to gnome-power-manager.  If I kill gnome-power-manager beforehand,
> then it doesn't happen.

Hmm... killing g-p-m doesn't seem to affect this any more, perhaps I
spoke too soon.  But not logging into X still avoids it.
