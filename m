From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH/RESEND] soc-camera: add runtime pm support
 for subdevices
Date: Tue, 9 Feb 2010 09:12:30 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1002090901550.4585__30609.8854206086$1265703186$gmane$org@axis700.grange>
References: <Pine.LNX.4.64.1002081044150.4936@axis700.grange>
	<201002082310.08079.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201002082310.08079.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pm@lists.linux-foundation.org, Mauro Carvalho Chehab <mchehab@redhat.com>, Linux Media Mailing List <linux-media@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Mon, 8 Feb 2010, Rafael J. Wysocki wrote:

> On Monday 08 February 2010, Guennadi Liakhovetski wrote:
> > To save power soc-camera powers subdevices down, when they are not in use, 
> > if this is supported by the platform. However, the V4L standard dictates, 
> > that video nodes shall preserve configuration between uses. This requires 
> > runtime power management, which is implemented by this patch. It allows 
> > subdevice drivers to specify their runtime power-management methods, by 
> > assigning a type to the video device.
> 
> You need a support for that at the bus type/device type/device class level,
> because the core doesn't execute the driver callbacks directly.

That's exactly what this patch is doing - adding a device type with pm 
callbacks. What I wasn't sure about - and why I posted here - is whether 
that's a proper way to use pm_runtime_resume() and pm_runtime_suspend() 
calls - from a central module, targeting underlying devices, before 
powering them down and after powering them up?

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
