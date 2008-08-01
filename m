From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH] Fix suspend/resume of pxa_camera driver
Date: Fri, 1 Aug 2008 23:26:40 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0808012305080.14927__42543.0967858576$1217626491$gmane$org@axis700.grange>
References: <1217113647-20638-1-git-send-email-robert.jarzmik@free.fr>
	<Pine.LNX.4.64.0807270155020.29126@axis700.grange>
	<878wvnkd8n.fsf@free.fr>
	<Pine.LNX.4.64.0807271337270.1604@axis700.grange>
	<87tze997uu.fsf@free.fr> <87y73h204v.fsf@free.fr>
	<Pine.LNX.4.64.0808012135300.14927@axis700.grange>
	<87ljzgfo4s.fsf@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <87ljzgfo4s.fsf@free.fr>
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

On Fri, 1 Aug 2008, Robert Jarzmik wrote:

> Ah, I didn't thought of soc_camera_host_ops ... But I agree, it may be better to
> call soc_camera_host_ops->suspend() rather than pxa-camera::suspend(). Which
> brings me to another question, in which order :
>  a) soc_camera_ops->suspend() then soc_camera_hosts->suspend()
>  b) soc_camera_hosts->suspend() then soc_camera_ops->suspend()
> 
> For me, the only working order can be (a), because I need
> soc_camera_host->resume() first to enable QIF Clock, so that i2c interface is
> usable on Micron chip, so that soc_camera->resume() can send i2c commands to the
> camera. Do you think the same ?

On resume we have to do this exactly as you have done it in your last 
patch: first restore general parameters on the host, then resume the 
camera, and then continue with the FIFOs and activating the DMA. So, I 
think, we have no choice but to only call host's resume, passing it the 
camera device as a parameter, and let it decide when it wants to resume 
the camera. Similar on suspend. This will also be consistent with how 
pxa_camera_add_device() calls icd->ops->init(icd) and 
pxa_camera_remove_device() calls icd->ops->release(icd).

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
