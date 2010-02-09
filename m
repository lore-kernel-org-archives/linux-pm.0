From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH/RESEND] soc-camera: add runtime pm support
 for subdevices
Date: Tue, 9 Feb 2010 16:42:50 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1002091641460.4585__45809.1314686046$1265730545$gmane$org@axis700.grange>
References: <Pine.LNX.4.44L0.1002091016060.1665-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1002091016060.1665-100000@iolanthe.rowland.org>
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
Cc: linux-pm@lists.linux-foundation.org, Linux Media Mailing List <linux-media@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, 9 Feb 2010, Alan Stern wrote:

> On Mon, 8 Feb 2010, Guennadi Liakhovetski wrote:
> 
> > To save power soc-camera powers subdevices down, when they are not in use, 
> > if this is supported by the platform. However, the V4L standard dictates, 
> > that video nodes shall preserve configuration between uses. This requires 
> > runtime power management, which is implemented by this patch. It allows 
> > subdevice drivers to specify their runtime power-management methods, by 
> > assigning a type to the video device.
> > 
> > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> > ---
> > 
> > I've posted this patch to linux-media earlier, but I'd also like to get 
> > comments on linux-pm, sorry to linux-media falks for a duplicate. To 
> > explain a bit - soc_camera.c is a management module, that binds video 
> > interfaces on SoCs and sensor drivers. The calls, that I am adding to 
> > soc_camera.c shall save and restore sensor registers before they are 
> > powered down and after they are powered up.
> 
> This patch is not correct as it stands.  If you use runtime PM then the 
> system PM resume method has to be changed.  See the discussion in 
> section 6 of Documentation/power/runtime_pm.txt.

...changed - for the same device, right? And I don't see any system PM 
methods implemented for these devices yet.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
