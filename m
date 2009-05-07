From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 2/9] PM: suspend_block: Add driver to access
	suspend	blockers from user-space
Date: Thu, 7 May 2009 12:32:50 +0200
Message-ID: <20090507103249.GA6132@elf.ucw.cz>
References: <1241583529-5092-1-git-send-email-arve@android.com>
	<1241583529-5092-2-git-send-email-arve@android.com>
	<1241583529-5092-3-git-send-email-arve@android.com>
	<20090505201225.GG1379@ucw.cz>
	<d6200be20905061842l64e71797r11807dff47f335ed@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <d6200be20905061842l64e71797r11807dff47f335ed@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Arve Hj?nnev?g <arve@android.com>
Cc: ncunningham@crca.org.au, u.luckas@road.de, swetland@google.com, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Wed 2009-05-06 18:42:59, Arve Hj?nnev?g wrote:
> On Tue, May 5, 2009 at 1:12 PM, Pavel Machek <pavel@ucw.cz> wrote:
> > Hi!
> >
> >> Add a misc device, "suspend_blocker", that allows user-space processes
> >> to block auto suspend. The device has ioctls to create a suspend_blocker,
> >> and to block and unblock suspend. To delete the suspend_blocker, close
> >> the device.
> >
> > Rafael proposed write() interface. I don't think you answered that.
> >
> 
> I think an ioctl interface makes more sense. With a write interface
> you either have to do string parsing, or invent some other protocol
> between the driver and user-space.

Or perhaps just use "userspace/%d" % pid as a name?

1) can't be faked that trivially

2) small / mostly fixed size

3) can use nicer write protocol?

> > kzalloc on user-supplied argument. Sounds like bad idea.
> >
> > Aha. And probably integer overflow in the same line. Ouch.
> >
> 
> The size is limited to _IOC_SIZEMASK with is 13 or 14 bits depending
> on the architecture. Do you want a lower limit on the name length?

16K of unswappable kernel memory for name is a bit too much, yes.

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
