From: Pavel Machek <pavel@suse.cz>
Subject: Re: [PATCH] Fix suspend/resume of pxa_camera driver
Date: Wed, 13 Aug 2008 14:16:35 +0200
Message-ID: <20080813121635.GC6153@ucw.cz>
References: <Pine.LNX.4.44L0.0807271808550.23282-100000@netrider.rowland.org>
	<87prox97oa.fsf@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <87prox97oa.fsf@free.fr>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: video4linux-list@redhat.com, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Mon 2008-07-28 20:37:25, Robert Jarzmik wrote:
> Alan Stern <stern@rowland.harvard.edu> writes:
> 
> > On Sun, 27 Jul 2008, Guennadi Liakhovetski wrote:
> >
> > IMO, suspend should be as transparent as possible for userspace.  So if
> > a user program has started an audio or video stream before suspend,
> > then after resume the stream should still be playing.
> Yes, that's what I think too.
> 
> The only little thing that should change will be timeout problem (userspace
> waits on a poll to get a video frame within 1 second for example).
> I'm not sure how well this is handled, I didn't check.

Userrland problem. Could hit you if you go deeply into swap, for
example. Fix userland.

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
