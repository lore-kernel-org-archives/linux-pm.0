From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH] Fix suspend/resume of pxa_camera driver
Date: Mon, 28 Jul 2008 20:37:25 +0200
Message-ID: <87prox97oa.fsf__6873.55964114449$1217271732$gmane$org@free.fr>
References: <Pine.LNX.4.44L0.0807271808550.23282-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0807271808550.23282-100000@netrider.rowland.org>
	(Alan Stern's message of "Sun\,
	27 Jul 2008 18\:10\:02 -0400 \(EDT\)")
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: video4linux-list@redhat.com, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Alan Stern <stern@rowland.harvard.edu> writes:

> On Sun, 27 Jul 2008, Guennadi Liakhovetski wrote:
>
> IMO, suspend should be as transparent as possible for userspace.  So if
> a user program has started an audio or video stream before suspend,
> then after resume the stream should still be playing.
Yes, that's what I think too.

The only little thing that should change will be timeout problem (userspace
waits on a poll to get a video frame within 1 second for example).
I'm not sure how well this is handled, I didn't check.

--
Robert
