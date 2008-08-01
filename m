From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH] Fix suspend/resume of pxa_camera driver
Date: Fri, 1 Aug 2008 22:16:07 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0808012135300.14927__6112.51660525358$1217621944$gmane$org@axis700.grange>
References: <1217113647-20638-1-git-send-email-robert.jarzmik@free.fr>
	<Pine.LNX.4.64.0807270155020.29126@axis700.grange>
	<878wvnkd8n.fsf@free.fr>
	<Pine.LNX.4.64.0807271337270.1604@axis700.grange>
	<87tze997uu.fsf@free.fr> <87y73h204v.fsf@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <87y73h204v.fsf@free.fr>
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

On Thu, 31 Jul 2008, Robert Jarzmik wrote:

> > So, to sum up :
> >  - I finish the mt9m111 driver
> >  - I submit it
> >  - I cook up a clean suspend/resume (unless you did it first of course :)
> 
> All right, I finished the pxa_camera part. The suspend/resume does work with a
> opened video stream. The capture begins before the suspend and finished after
> the resume.
> 
> I post the patch here attached for information. I'll submit later with the
> complete suspend/resume serie. This is just for preliminary comments. Of course,
> this patch superseeds the origin patch posted in this thread, which didn't work
> for an opened video stream.

Ok, some preliminary comments.

> >From fb38f10c233a5b4e13f5ad42cf1c381ecc4215e9 Mon Sep 17 00:00:00 2001
> From: Robert Jarzmik <robert.jarzmik@free.fr>
> Date: Sun, 27 Jul 2008 00:52:22 +0200
> Subject: [PATCH] Fix suspend/resume of pxa_camera driver
> 
> PXA suspend switches off DMA core, which looses all context

I think, you mean "loses" - with one "o".

> of previously assigned descriptors. As pxa_camera driver
> relies on DMA transfers, setup the lost descriptors on
> resume and retrigger frame acquisition if needed.
> 
> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
> ---
>  drivers/media/video/pxa_camera.c |   49 ++++++++++++++++++++++++++++++++++++++
>  1 files changed, 49 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/media/video/pxa_camera.c b/drivers/media/video/pxa_camera.c
> index efb2d19..f00844c 100644
> --- a/drivers/media/video/pxa_camera.c
> +++ b/drivers/media/video/pxa_camera.c
> @@ -128,6 +128,8 @@ struct pxa_camera_dev {
>  
>  	struct pxa_buffer	*active;
>  	struct pxa_dma_desc	*sg_tail[3];
> +
> +	u32			save_CICR[5];

I think, it would look better in  plane lowercase, just name it "cicr" or 
even "save_cicr" if you prefer.

>  };
>  
>  static const char *pxa_cam_driver_description = "PXA_Camera";
> @@ -1017,6 +1019,51 @@ static struct soc_camera_host pxa_soc_camera_host = {
>  	.ops			= &pxa_soc_camera_host_ops,
>  };
>  
> +static int pxa_camera_suspend(struct platform_device *pdev, pm_message_t state)
> +{
> +	struct pxa_camera_dev *pcdev = platform_get_drvdata(pdev);
> +	int i = 0;
> +
> +	pcdev->save_CICR[i++] = CICR0;
> +	pcdev->save_CICR[i++] = CICR1;
> +	pcdev->save_CICR[i++] = CICR2;
> +	pcdev->save_CICR[i++] = CICR3;
> +	pcdev->save_CICR[i++] = CICR4;
> +
> +	return 0;
> +}
> +
> +static int pxa_camera_resume(struct platform_device *pdev)
> +{
> +	struct pxa_camera_dev *pcdev = platform_get_drvdata(pdev);
> +	int i = 0;
> +
> +	DRCMR68 = pcdev->dma_chans[0] | DRCMR_MAPVLD;
> +	DRCMR69 = pcdev->dma_chans[1] | DRCMR_MAPVLD;
> +	DRCMR70 = pcdev->dma_chans[2] | DRCMR_MAPVLD;
> +
> +	CICR0 = pcdev->save_CICR[i++] & ~CICR0_ENB;
> +	CICR1 = pcdev->save_CICR[i++];
> +	CICR2 = pcdev->save_CICR[i++];
> +	CICR3 = pcdev->save_CICR[i++];
> +	CICR4 = pcdev->save_CICR[i++];
> +
> +	if ((pcdev->icd) && (pcdev->icd->ops->resume))
> +		pcdev->icd->ops->resume(pcdev->icd);

Are we sure, that i2c has been woken up by now?... I am sorry, I wasn't 
quite convinced by your argumentation in a previous email regarding in 
which order the drivers will be resumed. So, I re-added pm to the cc:-) As 
far as I understood, devices get resumed simply in the order they got 
registered. This does guarantee, that children are resumed after parents, 
but otherwise there are no guarantees. I guess, you load pxa-camera after 
i2c-pxa, right? What if you first load pxa-camera and then i2c-pxa? I'm 
almost prepared to bet, your resume will not work then:-)

I think, I have an idea. Our soc_camera_device is registered the last - it 
is registered after the respective i2c device (at least in all drivers so 
far, and future drivers better keep it this way), and after the camera 
host it is on (see soc_camera.c::device_register_link()). So, all we have 
to do is add a suspend and a resume to soc_camera_bus_type and to 
soc_camera_ops and to soc_camera_host_ops. Then just call the latter two 
from soc_camera_bus_type .resume and .suspend. Now this should work, what 
do you think?

> +
> +	/* Restart frame capture if active buffer exists */
> +	if (pcdev->active) {
> +		/* Reset the FIFOs */
> +		CIFR |= CIFR_RESET_F;
> +		/* Enable End-Of-Frame Interrupt */
> +		CICR0 &= ~CICR0_EOFM;
> +		/* Restart the Capture Interface */
> +		CICR0 |= CICR0_ENB;
> +	}
> +
> +	return 0;
> +}
> +
>  static int pxa_camera_probe(struct platform_device *pdev)
>  {
>  	struct pxa_camera_dev *pcdev;
> @@ -1188,6 +1235,8 @@ static struct platform_driver pxa_camera_driver = {
>  	},
>  	.probe		= pxa_camera_probe,
>  	.remove		= __exit_p(pxa_camera_remove),
> +	.suspend	= pxa_camera_suspend,
> +	.resume		= pxa_camera_resume,
>  };

If we agree on the above just move these two to pxa_soc_camera_host_ops.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
