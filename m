From: "Jon Medhurst (Tixy)" <tixy@linaro.org>
Subject: Re: [PATCH v3 1/5] Documentation: add DT bindings for ARM SCPI
 sensors
Date: Tue, 15 Sep 2015 11:46:02 +0100
Message-ID: <1442313962.2917.25.camel@linaro.org>
References: <1442235619-4029-1-git-send-email-punit.agrawal@arm.com>
	 <1442235619-4029-2-git-send-email-punit.agrawal@arm.com>
	 <20150914131448.GC7002@leverpostej>
	 <9hhh9mxf7lg.fsf@e105922-lin.cambridge.arm.com>
	 <20150914134949.GE7002@leverpostej>
	 <9hhk2rtdq1f.fsf@e105922-lin.cambridge.arm.com>
	 <1442251092.2850.53.camel@linaro.org>
	 <9hhy4g89g64.fsf@e105922-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <9hhy4g89g64.fsf@e105922-lin.cambridge.arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Punit Agrawal <punit.agrawal@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Liviu Dudau <Liviu.Dudau@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "edubezval@gmail.com" <edubezval@gmail.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "linux@roeck-us.net" <linux@roeck-us.net>, Sudeep Holla <Sudeep.Holla@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On Tue, 2015-09-15 at 10:37 +0100, Punit Agrawal wrote:
> "Jon Medhurst (Tixy)" <tixy@linaro.org> writes:
> 
> > On Mon, 2015-09-14 at 15:38 +0100, Punit Agrawal wrote:
> >> Mark Rutland <mark.rutland@arm.com> writes:
> >> 
[...]
> >> The way the SCP interface is defined, the sensor identifiers are
> >> contiguous,
> >
> > Is there any documentation other than DUI0922A? [1] From what I can seen
> > that just says it's a 16-bit value and doesn't put any particular
> > constraints on its value.
> 
> Although not explicitly stated, if you look at the Get Sensor Capability
> [2] and Get Sensor Info [3] commands you can indirectly infer that the
> Sensor IDs are contiguous.

I personally wouldn't even indirectly infer they are contiguous from
what the document says. If I were implementing the firmware I would feel
quite in my rights to, for example, use the top 8 bits of the ID for a
sensor type and the bottom 8 for an index, if that made dispatching of
requests more efficient. Or if some optional hardware was detected as
missing, leaving some holes in ID space.

As a specification of a 'standard' the document seems to be rather
lacking. So, Sensor ID should be documented as being "an unsigned
integer less than then number of sensors returned by the Get Sensor
Capability command", or something like that. I guess clocks and other
devices suffer from similar lack of specificity.

>  Not the strongest guarantee I know.
> 
> All platforms currently using SCP (Juno R0 and R1) do indeed expose
> contiguous identifiers.

IMO, Linux drivers should be coded to the standard or written
specification (where they are available) not the particular
implementations available.

> >
> > [1] http://community.arm.com/servlet/JiveServlet/download/8401-40-18262/DUI0922A_scp_message_interface.pdf
> [2] http://arminfo.emea.arm.com/help/index.jsp?topic=/com.arm.doc.dui0922b/ch03s02s21.html
> [3] http://arminfo.emea.arm.com/help/index.jsp?topic=/com.arm.doc.dui0922b/BABCCCJJ.html

I think those links are on ARM's intranet, they return NXDOMAIN for me.

-- 
Tixy
