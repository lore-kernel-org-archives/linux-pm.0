From: Pavel Machek <pavel@suse.cz>
Subject: Re: SMC911X driver Suspend-Resume Failures
Date: Mon, 2 Feb 2009 09:34:02 +0100
Message-ID: <20090202083402.GA3114__348.821204579686$1233563899$gmane$org@elf.ucw.cz>
References: <8bf247760901300435s56024125o9aae1a112196c9a1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <8bf247760901300435s56024125o9aae1a112196c9a1@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Sriram V <vshrirama@gmail.com>
Cc: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Fri 2009-01-30 18:05:27, Sriram V wrote:
> Hi,
>    I am using 2.6.28 and am testing PM on my arm target. I am using
> smc911x.c driver.
>    I get the error when i try to resume from suspend:
> 
>    has anyone seen this error before.

No, but try unloading the smc911 module and see if that repeats. Then
you can debug it with printk.



-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
