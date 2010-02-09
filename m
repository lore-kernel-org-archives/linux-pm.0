From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH/RESEND] soc-camera: add runtime pm support
	for subdevices
Date: Tue, 9 Feb 2010 16:50:26 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1002091609350.4585__9693.89366587183$1265730836$gmane$org@axis700.grange>
References: <Pine.LNX.4.64.1002081044150.4936@axis700.grange>   
	<4B7012D1.40605@redhat.com>
	<Pine.LNX.4.64.1002081447020.4936@axis700.grange>
	<4B705216.7040907@redhat.com>
	<Pine.LNX.4.64.1002091053470.4585@axis700.grange>
	<26fe28e3dda70da4d133a9dbc3f2bc74.squirrel@webmail.xs4all.nl>   
	<Pine.LNX.4.64.1002091252530.4585@axis700.grange>   
	<2aa8130b9fd7fe9f9fb2cf626ff58831.squirrel@webmail.xs4all.nl>   
	<4B715CEB.1070602@redhat.com>
	<0c196b926b744e04a94850d4d3b1e029.squirrel@webmail.xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <0c196b926b744e04a94850d4d3b1e029.squirrel@webmail.xs4all.nl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Hans Verkuil <hverkuil@xs4all.nl>
Cc: linux-pm@lists.linux-foundation.org, Mauro Carvalho Chehab <mchehab@redhat.com>, Valentin Longchamp <valentin.longchamp@epfl.ch>, Linux Media Mailing List <linux-media@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, 9 Feb 2010, Hans Verkuil wrote:

> 1) is someone using the driver (i.e. is a device node open, which is not
> necessarily limited to v4l2-type device nodes)?
> 2) are we actively streaming from or to some particular input or output?
> 
> And we probably need some easy way to detect and set the powersaving state
> for each component (subdev or the main v4l2_device).
> 
> I really need to research the pm stuff...

That certainly wouldn't hurt, but I have to resolve a problem of a failing 
device now. And I have 3 options:

1. implement runtime_pm in soc-camera and down, using vdev->dev.type. Easy 
and relatively painless - we already have use-counts there, so, first open 
and last close are readily available.

2. add the same as above to v4l2-dev.c - wouldn't really want to do that, 
implications too large, no use-counting.

3. accept the patch from Val and just write registers, we are currently 
losing, on each s_fmt. Easy, but not very efficient - there can be other 
similar problems elsewhere...

Which of them shall I do for now? Besides, I realise, that decisions which 
devices and when to suspend and to wake up are difficult, so, PM requires 
careful implementation. But doesn't this also mean, that we anyway cannot 
implement any specifics in the top level, and can only implement hooks to 
call hardware-specific pm callbacks, so, probably, the bridge driver will 
have to implement specifics anyway?

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
