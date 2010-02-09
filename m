From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH/RESEND] soc-camera: add runtime pm support
	for subdevices
Date: Tue, 9 Feb 2010 11:27:20 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1002091053470.4585__46623.8609551967$1265711336$gmane$org@axis700.grange>
References: <Pine.LNX.4.64.1002081044150.4936@axis700.grange>
	<4B7012D1.40605@redhat.com>
	<Pine.LNX.4.64.1002081447020.4936@axis700.grange>
	<4B705216.7040907@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4B705216.7040907@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Mauro Carvalho Chehab <mchehab@redhat.com>
Cc: linux-pm@lists.linux-foundation.org, Valentin Longchamp <valentin.longchamp@epfl.ch>, Linux Media Mailing List <linux-media@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Mon, 8 Feb 2010, Mauro Carvalho Chehab wrote:

> In fact, on all drivers, there are devices that needs to be turn on only when
> streaming is happening: sensors, analog TV/audio demods, digital demods. Also,
> a few devices (for example: TV tuners) could eventually be on power off when
> no device is opened.
> 
> As the V4L core knows when this is happening (due to
> open/close/poll/streamon/reqbuf/qbuf/dqbuf hooks, I think the runtime management 
> can happen at V4L core level.

Well, we can move it up to v4l core. Should it get any more complicated 
than adding

	ret = pm_runtime_resume(&vdev->dev);
	if (ret < 0 && ret != -ENOSYS)
		return ret;

to v4l2_open() and

	pm_runtime_suspend(&vdev->dev);

to v4l2_release()? And to agree, that video drivers may set a device type 
to implement runtime PM, and that the v4l core shouldn't touch it? Then, 
for example, a bridge driver could implement such a device type instance 
and suspend or resume all related components?

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
