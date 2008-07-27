From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] Fix suspend/resume of pxa_camera driver
Date: Sun, 27 Jul 2008 18:10:02 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0807271808550.23282-100000@netrider.rowland.org>
References: <Pine.LNX.4.64.0807271337270.1604@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.64.0807271337270.1604@axis700.grange>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: video4linux-list@redhat.com, Robert Jarzmik <robert.jarzmik@free.fr>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Sun, 27 Jul 2008, Guennadi Liakhovetski wrote:

> Yes, this is the difference. The sensor is attached to the camera host 
> only on open. In fact, I am not sure, how video applications should behave 
> during a suspend / resume cycle. If you suspend, while, say, recording 
> from your camera, should you directly continue recording after a wake up? 
> How do currect drivers implement this? Or, in general, for example with 
> audio - if you suspend while listening to a stream over the net, or to a 
> CD, or to a mp3-file on your local disk, should the sound resume after a 
> wake up? I added linux-pm for some authoritative answers:-)

IMO, suspend should be as transparent as possible for userspace.  So if
a user program has started an audio or video stream before suspend,
then after resume the stream should still be playing.

Alan Stern
