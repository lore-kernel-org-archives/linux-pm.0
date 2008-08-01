From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH] Fix suspend/resume of pxa_camera driver
Date: Fri, 01 Aug 2008 22:58:59 +0200
Message-ID: <87ljzgfo4s.fsf__40797.3943198614$1217624840$gmane$org@free.fr>
References: <1217113647-20638-1-git-send-email-robert.jarzmik@free.fr>
	<Pine.LNX.4.64.0807270155020.29126@axis700.grange>
	<878wvnkd8n.fsf@free.fr>
	<Pine.LNX.4.64.0807271337270.1604@axis700.grange>
	<87tze997uu.fsf@free.fr> <87y73h204v.fsf@free.fr>
	<Pine.LNX.4.64.0808012135300.14927@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.64.0808012135300.14927@axis700.grange> (Guennadi
	Liakhovetski's message of "Fri\,
	1 Aug 2008 22\:16\:07 +0200 \(CEST\)")
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
Cc: video4linux-list@redhat.com, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Guennadi Liakhovetski <g.liakhovetski@gmx.de> writes:

> I think, you mean "loses" - with one "o".
Typo. Will be fixed.

> I think, it would look better in  plane lowercase, just name it "cicr" or 
> even "save_cicr" if you prefer.
OK. Will be fixed.

>> +	if ((pcdev->icd) && (pcdev->icd->ops->resume))
>> +		pcdev->icd->ops->resume(pcdev->icd);
>
> Are we sure, that i2c has been woken up by now?... I am sorry, I wasn't 
> quite convinced by your argumentation in a previous email regarding in 
> which order the drivers will be resumed. So, I re-added pm to the cc:-) As 
> far as I understood, devices get resumed simply in the order they got 
> registered. This does guarantee, that children are resumed after parents, 
> but otherwise there are no guarantees. I guess, you load pxa-camera after 
> i2c-pxa, right? What if you first load pxa-camera and then i2c-pxa? I'm 
> almost prepared to bet, your resume will not work then:-)

And you're probably right. I tested ... The order is bus before devices, parents
before childs, but I see no link between i2c-pxa and pxa-camera.

Yesterday, I moved that 2 lines into soc_camera_resume(), and
soc_camera_suspend() was added too. I came to the same conclusion, which is that
we can only be sure of the order if called from soc_camera_bus.

> I think, I have an idea. Our soc_camera_device is registered the last - it 
> is registered after the respective i2c device (at least in all drivers so 
> far, and future drivers better keep it this way), and after the camera 
> host it is on (see soc_camera.c::device_register_link()). So, all we have 
> to do is add a suspend and a resume to soc_camera_bus_type and to 
> soc_camera_ops and to soc_camera_host_ops. Then just call the latter two 
> from soc_camera_bus_type .resume and .suspend. Now this should work, what 
> do you think?

Ah, I didn't thought of soc_camera_host_ops ... But I agree, it may be better to
call soc_camera_host_ops->suspend() rather than pxa-camera::suspend(). Which
brings me to another question, in which order :
 a) soc_camera_ops->suspend() then soc_camera_hosts->suspend()
 b) soc_camera_hosts->suspend() then soc_camera_ops->suspend()

For me, the only working order can be (a), because I need
soc_camera_host->resume() first to enable QIF Clock, so that i2c interface is
usable on Micron chip, so that soc_camera->resume() can send i2c commands to the
camera. Do you think the same ?

> If we agree on the above just move these two to pxa_soc_camera_host_ops.
Agreed for me.

--
Robert

--
video4linux-list mailing list
Unsubscribe mailto:video4linux-list-request@redhat.com?subject=unsubscribe
https://www.redhat.com/mailman/listinfo/video4linux-list
