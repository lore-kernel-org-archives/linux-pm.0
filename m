From: "Jordan Crouse" <jordan.crouse-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [RFC] Driver States
Date: Mon, 28 Mar 2005 09:29:25 -0700
Message-ID: <20050328092925.2c2736de@cosmic.amd.com>
References: <1111963367.3503.152.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============23227069328631655=="
Return-path: <linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
In-Reply-To: <1111963367.3503.152.camel-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Help: <mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=subscribe>
Sender: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
Errors-To: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
To: linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
List-Id: linux-pm@vger.kernel.org

--===============23227069328631655==
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 7bit

> struct device_driver {

Its still in debate, but if we decide to do centralized policy
management (like DPM), then we will need some way to pass in attributes
such as device inactivity timeout to the device.  Personally, I would be
happy with a call that passed a pointer for flexibility,  but it seems
that recently, people are heavily favoring arguments that can be
typchecked.

[ As an aside, I think that deciding where policy management will live
will help clear up some of the nagging issues we've been having about
the role of the drivers vs. the role of the system, etc, etc. ]

> A table could be defined that indicates what should be called for each
> power level transition.  *suspend and *resume could handle any extra
> steps (ex. saving state).  As an example, *start and *stop may only be
> called when power is going to be lost entirely.

I think we discussed this during the IRC meeting.  I certainly don't
favor multiple calls which increase the level of complexity of the
calling entity.   I would need one table to tell me what power level the
device should be at, and a second table to tell me if I need to call
stop() or start().  Furthermore some devices may go clocks off during
one S-T-R transition, and then keep clocks on for wake another time. 
Our current thinking is to assume that the driver is intelligent enough
to know what to do for any given power level, and I think a single call
would suffice for that.

Jordan

-- 
Jordan Crouse
Senior Linux Engineer
AMD - Personal Connectivity Solutions Group
<www.amd.com/embeddedprocessors>




--===============23227069328631655==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============23227069328631655==--
