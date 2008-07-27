From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH] Fix suspend/resume of pxa_camera driver
Date: Sun, 27 Jul 2008 21:11:43 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0807271337270.1604__11649.7070216157$1217186011$gmane$org@axis700.grange>
References: <1217113647-20638-1-git-send-email-robert.jarzmik@free.fr>
	<Pine.LNX.4.64.0807270155020.29126@axis700.grange>
	<878wvnkd8n.fsf@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <878wvnkd8n.fsf@free.fr>
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
Cc: video4linux-list@redhat.com, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Sun, 27 Jul 2008, Robert Jarzmik wrote:

> Yes, I have tested, with a complete suspend/resume cycle on a Mitac Mio A701
> smartphone. And yes, the PXA suspend is based on SDRAM being in self refresh
> state. I'm speaking of suspend, not standby, there's no confusion here.
> 
> Notice I always go into suspend while _not_ in active capturing. That could
> change things.

Yes, this is the difference. The sensor is attached to the camera host 
only on open. In fact, I am not sure, how video applications should behave 
during a suspend / resume cycle. If you suspend, while, say, recording 
from your camera, should you directly continue recording after a wake up? 
How do currect drivers implement this? Or, in general, for example with 
audio - if you suspend while listening to a stream over the net, or to a 
CD, or to a mp3-file on your local disk, should the sound resume after a 
wake up? I added linux-pm for some authoritative answers:-)

If you know how a v4l2 device should handle suspend/resume, or when we get 
some answers, let's try to do it completely-

> Have you previously tested the pxa_camera driver in suspend ?

No, I have not. I didn't have power-management enabled on my board, and I 
don't know how easy such tests would be on my hardware. That's why I just 
removed all suspend/resume code from the pxa270 driver completely.

> For history, my setup is :
>  - a pxa272 on a Mio A701 board
>  - a Micron MT9M111 chip (driver under construction)
> 
> For the camera part, by now, I'm using standard suspend/resume functions of the
> platform driver (mt9m111.c). It does work, but it's not clean ATM. The chaining
> between the driver resume function and the availability of the I2C bus are not
> properly chained. I'm still working on it.

Yes, we have to clarify this too.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
