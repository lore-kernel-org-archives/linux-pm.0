From: Jon Smirl <jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC] Some thoughts on device drivers and sysfs
Date: Sun, 27 Mar 2005 16:25:10 -0500
Message-ID: <9e47339105032713251c88890@mail.gmail.com>
References: <1111951499.3503.87.camel@localhost.localdomain>
Reply-To: Jon Smirl <jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
In-Reply-To: <1111951499.3503.87.camel-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Help: <mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=subscribe>
Sender: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
Errors-To: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
To: Adam Belay <abelay-Et1tbQHTxzrQT0dZR+AlfA@public.gmane.org>
Cc: linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Sun, 27 Mar 2005 14:24:59 -0500, Adam Belay <abelay-Et1tbQHTxzrQT0dZR+AlfA@public.gmane.org> wrote:
> This would allow us to represent per-device driver attributes in sysfs.
> As an added benefit, driver devices would allow the tracking and control
> of driver state, which may be needed for dynamic power management.  I
> look forward to any comments.

Isn't there already a way to do this? I recall some discussion lkml
about six months ago  about doing it. I tried googling for it but
couldn't find it. It may not have been implemented.

-- 
Jon Smirl
jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
